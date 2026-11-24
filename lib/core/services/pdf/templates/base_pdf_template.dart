
import 'dart:convert';

class BasePdfTemplate {
  BasePdfTemplate._();

  static String wrapInA4HtmlLayout({
    required String title,
    required String bodyHtml,
    String? regularFontBase64,
    String? boldFontBase64,
  }) {
    if (regularFontBase64 == null ||
        regularFontBase64.isEmpty ||
        boldFontBase64 == null ||
        boldFontBase64.isEmpty) {
      throw StateError(
        'Both bundled Bengali PDF fonts are required.',
      );
    }

    final String fontFaceCss = '''
    @font-face {
      font-family: 'Noto Sans Bengali';
      font-style: normal;
      font-weight: 400;
      src: url(data:font/ttf;base64,$regularFontBase64) format('truetype');
    }

    @font-face {
      font-family: 'Noto Sans Bengali';
      font-style: normal;
      font-weight: 700;
      src: url(data:font/ttf;base64,$boldFontBase64) format('truetype');
    }
    ''';

    final safeTitle = htmlEscape.convert(title);

    return '''
<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>$safeTitle</title>

  <style>

    $fontFaceCss

    @page {
      size: A4 portrait;
      margin: 10mm;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    html, body {
      margin: 0;
      padding: 0;
      background-color: #FFFFFF;
    }

    body {
      font-family: 'Noto Sans Bengali', Arial, sans-serif;
      font-size: 11px;
      line-height: 1.5;
      color: #0B2347;
      background-color: #FFFFFF;

      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }

    /* Native pagination */

    .pdf-document {
      display: block;
      width: 100%;
    }

    /* Document header */

    .header-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 8px;

      break-inside: avoid;
      page-break-inside: avoid;
      overflow-wrap: break-word;
    }

    .header-table td {
      vertical-align: top;
    }

    .brand-title {
      font-size: 17px;
      font-weight: 700;
      color: #0B57D0;
    }

    .brand-sub {
      font-size: 10.5px;
      color: #5F6B7A;
    }

    .doc-info-box {
      text-align: right;
      font-size: 10.5px;
      color: #5F6B7A;
    }

    .divider {
      border-top: 2px solid #0B57D0;
      margin: 6px 0 10px 0;
    }

    /* Client information */

    .info-card {
      width: 100%;
      background-color: #F4F8FF;
      border: 1px solid #D0E2FF;
      border-radius: 6px;
      padding: 6px 8px;
      margin-bottom: 10px;

      break-inside: avoid;
      page-break-inside: avoid;
      overflow-wrap: break-word;
    }

    .info-card-table {
      width: 100%;
      border-collapse: collapse;
    }

    .info-card-table td {
      vertical-align: top;
      width: 50%;
    }

    .info-label {
      font-size: 9.5px;
      color: #5F6B7A;
    }

    .info-val-bold {
      font-size: 12.5px;
      font-weight: 700;
      color: #0B2347;
    }

    .info-val-sub {
      font-size: 10.5px;
      color: #334155;
    }

    /* Material Table */

    .materials-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 4px;
      margin-bottom: 10px;
    }

    .materials-table thead {
      display: table-header-group;
    }

    .materials-table tbody {
      display: table-row-group;
    }

    .materials-table tr {
      break-inside: avoid;
      page-break-inside: avoid;
    }

    .materials-table,
    .materials-table tbody tr:last-child,
    .note-box,
    .total-row,
    .document-total {
      break-after: avoid-page;
      page-break-after: avoid;
    }

    .materials-table th {
      background-color: #0B57D0 !important;
      color: #FFFFFF !important;
      font-size: 10.5px;
      font-weight: 700;
      padding: 6px 5px;
      text-align: left;
    }

    .materials-table td {
      border-bottom: 1px solid #E2E8F0;
      font-size: 10.5px;
      padding: 5px 5px;
      vertical-align: middle;
      word-break: normal;
      overflow-wrap: anywhere;
    }

    .materials-table tbody tr:nth-child(even) {
      background-color: #F8FAFC;
    }

    .material-spec {
      font-size: 10px;
      color: #5F6B7A;
    }

    .materials-table .text-center {
      text-align: center;
    }

    .text-center {
      text-align: center;
    }

    .text-right {
      text-align: right;
    }

    .text-left {
      text-align: left;
    }

    /* Grand total */

    .total-row {
      width: 100%;
      background-color: #E8F0FE;
      border-radius: 6px;
      padding: 7px 9px;
      margin-top: 6px;
      margin-bottom: 10px;
      font-size: 12.5px;
      font-weight: 700;
      color: #0B57D0;
    }

    /* Client note */

    .note-box {
      background-color: #FFF9E6;
      border-left: 4px solid #F59E0B;
      padding: 6px 8px;
      border-radius: 4px;
      font-size: 10.5px;
      color: #78350F;
      margin-bottom: 10px;
      overflow-wrap: anywhere;
    }

    /* Last page footer */

    .last-page-footer {
      width: 100%;

      padding-top: calc(10px + 0.000mm); /* SC_FOOTER_SPACER */

      /* SC_FOOTER_BREAK */

      word-break: normal;
      overflow-wrap: break-word;

      break-inside: avoid;
      page-break-inside: avoid;
    }

    .signature-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 8px;

      break-inside: avoid;
      page-break-inside: avoid;
    }

    .signature-table td {
      width: 50%;
      text-align: center;
      vertical-align: bottom;
    }

    .signature-line {
      width: 130px;
      margin: 0 auto 5px auto;
      border-top: 1px solid #94A3B8;
    }

    .signature-text {
      font-size: 10.5px;
      color: #475569;
    }

    .footer-notice {
      margin-top: 6px;
      text-align: center;
      font-size: 8.5px;
      color: #94A3B8;
      border-top: 1px dashed #CBD5E1;
      padding-top: 5px;
    }

  </style>
</head>

<body>

  <main class="pdf-document">

    $bodyHtml

  </main>

</body>
</html>
''';
  }
}
