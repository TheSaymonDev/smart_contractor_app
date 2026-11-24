
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:printing/printing.dart';

class PdfPaginationService {
  PdfPaginationService._();

  static const double _dpi = 72;

  static const double targetBottomGapMm = 12;

  static const double toleranceMm = 2;

  static const int _maxAttempts = 9;

  static const String _spacerMarker =
      'padding-top: calc(10px + 0.000mm); /* SC_FOOTER_SPACER */';

  static const String _breakMarker =
      '/* SC_FOOTER_BREAK */';

  /// Generates and measures the actual PDF.
  ///
  /// Native WebView handles all material table pagination.
  ///
  /// This method adjusts only the final footer position.

  static Future<Uint8List> anchorLastPageFooter({
    required String html,
    required Future<Uint8List> Function(String html) render,
  }) async {
    if (!html.contains(_spacerMarker) ||
        !html.contains(_breakMarker)) {
      throw StateError(
        'Material PDF footer markers are missing.',
      );
    }

    final printing = await Printing.info();

    if (!printing.canRaster) {
      throw UnsupportedError(
        'PDF raster verification is unavailable.',
      );
    }

    /// Generate a candidate PDF and inspect its actual layout.

    Future<_PdfProbe> probe(
        double spacerMm, {
          bool footerBreak = false,
        }) async {
      var candidate = html.replaceFirst(
        _spacerMarker,
        'padding-top: calc(10px + '
            '${spacerMm.toStringAsFixed(3)}mm);',
      );

      if (footerBreak) {
        candidate = candidate.replaceFirst(
          _breakMarker,
          'break-before: page; '
              'page-break-before: always;',
        );
      }

      final bytes = await render(candidate);

      return _inspect(bytes);
    }

    // Step 1: Render with no additional footer spacing.

    var base = await probe(0);

    if (!base.valid) {
      throw StateError(
        'Native renderer returned an invalid or blank PDF page.',
      );
    }

    bool forceFooterBreak = false;

    // Already aligned correctly.

    if (_withinTarget(base.bottomGapMm)) {
      return base.bytes;
    }

    // If the footer is too close to the physical page edge,
    // move the intact footer to a new page when necessary.

    if (base.bottomGapMm <
        targetBottomGapMm - toleranceMm) {
      forceFooterBreak = true;

      base = await probe(
        0,
        footerBreak: true,
      );

      if (!base.valid) {
        throw StateError(
          'Footer page could not be generated.',
        );
      }

      if (_withinTarget(base.bottomGapMm)) {
        return base.bytes;
      }

      if (base.bottomGapMm <
          targetBottomGapMm - toleranceMm) {
        throw StateError(
          'Native renderer cannot reserve the footer margin.',
        );
      }
    }

    // Step 2:
    // Calculate required spacing from the rendered PDF.

    double low = 0;

    double high = math.min(
      285.0,
      base.bottomGapMm + 8,
    );

    double next = (
        base.bottomGapMm - targetBottomGapMm
    ).clamp(low, high).toDouble();

    var best = base;

    // Step 3:
    // Bounded search to verify the final footer location.

    for (
    int attempt = 0;
    attempt < _maxAttempts;
    attempt++
    ) {
      final result = await probe(
        next,
        footerBreak: forceFooterBreak,
      );

      // Do not accept unintended extra pages.

      if (!result.valid ||
          result.pageCount != base.pageCount) {
        high = next;
      } else {
        final double error =
            result.bottomGapMm - targetBottomGapMm;

        final double bestError =
            best.bottomGapMm - targetBottomGapMm;

        if (error.abs() < bestError.abs()) {
          best = result;
        }

        if (_withinTarget(result.bottomGapMm)) {
          return result.bytes;
        }

        if (error > 0) {
          low = next;
        } else {
          high = next;
        }
      }

      if (high - low < 0.15) {
        break;
      }

      next = (low + high) / 2;
    }

    if (_withinTarget(best.bottomGapMm)) {
      return best.bytes;
    }

    // Never silently return an incorrectly aligned PDF.

    throw StateError(
      'Could not verify last-page footer position. '
          'Measured '
          '${best.bottomGapMm.toStringAsFixed(1)} mm.',
    );
  }

  static bool _withinTarget(double gap) {
    return (
        gap - targetBottomGapMm
    ).abs() <= toleranceMm;
  }

  /// Inspect the actual PDF pages.
  ///
  /// Rasterization is used only for layout measurements.
  /// The returned PDF remains the original text-based PDF.

  static Future<_PdfProbe> _inspect(
      Uint8List bytes,
      ) async {
    int count = 0;

    double? lastGap;

    bool valid = true;

    await for (
    final page in Printing.raster(
      bytes,
      dpi: _dpi,
    )
    ) {
      count++;

      final double widthMm =
          page.width * 25.4 / _dpi;

      final double heightMm =
          page.height * 25.4 / _dpi;

      // Verify physical A4 portrait page dimensions.

      if ((widthMm - 210).abs() > 2 ||
          (heightMm - 297).abs() > 2) {
        throw StateError(
          'Expected physical A4 portrait pages; got '
              '${widthMm.toStringAsFixed(1)} x '
              '${heightMm.toStringAsFixed(1)} mm.',
        );
      }

      final int bottom = _lastInkRow(page);

      if (bottom < 0) {
        valid = false;
      } else {
        lastGap =
            (page.height - 1 - bottom) * 25.4 / _dpi;
      }
    }

    if (count == 0 || lastGap == null) {
      throw StateError(
        'Native renderer returned an empty PDF.',
      );
    }

    return _PdfProbe(
      bytes,
      count,
      lastGap,
      valid,
    );
  }

  /// Find the lowest line containing visible content.
  ///
  /// Raw pixels are RGBA.

  static int _lastInkRow(
      PdfRaster page,
      ) {
    final pixels = page.pixels;

    if (pixels.length !=
        page.width * page.height * 4) {
      throw StateError(
        'Unexpected PDF raster pixel format.',
      );
    }

    for (
    int y = page.height - 1;
    y >= 0;
    y--
    ) {
      int ink = 0;

      for (
      int x = 0;
      x < page.width;
      x++
      ) {
        final int index =
            (y * page.width + x) * 4;

        final int alpha =
        pixels[index + 3];

        final int darkest = math.min(
          pixels[index],
          math.min(
            pixels[index + 1],
            pixels[index + 2],
          ),
        );

        final double darkness =
            (255 - darkest) * alpha / 255;

        if (darkness > 25) {
          ink++;

          if (ink >= 2) {
            return y;
          }
        }
      }
    }

    return -1;
  }
}

class _PdfProbe {
  final Uint8List bytes;

  final int pageCount;

  final double bottomGapMm;

  final bool valid;

  const _PdfProbe(
      this.bytes,
      this.pageCount,
      this.bottomGapMm,
      this.valid,
      );
}
