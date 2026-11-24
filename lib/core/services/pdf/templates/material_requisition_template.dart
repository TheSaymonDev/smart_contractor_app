
import 'dart:convert';

import 'package:smart_contractor_app/core/services/pdf/templates/base_pdf_template.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';

class MaterialRequisitionPdfTemplate {
  MaterialRequisitionPdfTemplate._();

  static String _money(num value) {
    return value % 1 == 0
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
  }

  static String generateHtml({
    required String contractorName,
    required String contractorPhone,
    required String contractorAddress,
    required String clientName,
    required String clientPhone,
    required String clientAddress,
    required String jobName,
    required List<MaterialItemModel> items,
    required bool showPrice,
    required double grandTotal,
    required String clientNote,
    String memoNo = 'ML-2026-001',
    String dateText = '২৩ অক্টোবর ২০২৬',
    String? regularFontBase64,
    String? boldFontBase64,
  }) {
    if (items.isEmpty) {
      throw StateError(
        'মালামালের তালিকা খালি।',
      );
    }

    // Escape all dynamic HTML data

    final safeContractorName =
    htmlEscape.convert(contractorName);

    final safeContractorPhone =
    htmlEscape.convert(contractorPhone);

    final safeContractorAddress =
    htmlEscape.convert(contractorAddress);

    final safeClientName =
    htmlEscape.convert(clientName);

    final safeClientPhone =
    htmlEscape.convert(clientPhone);

    final safeClientAddress =
    htmlEscape.convert(clientAddress);

    final safeJobName =
    htmlEscape.convert(jobName);

    final safeClientNote =
    htmlEscape.convert(clientNote);

    final safeMemoNo =
    htmlEscape.convert(memoNo);

    final safeDateText =
    htmlEscape.convert(dateText);

    // Generate all material rows.
    // Native PDF engine handles pagination.

    final StringBuffer tableRowsHtml = StringBuffer();

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      final safeItemName =
      htmlEscape.convert(item.name);

      final safeSize =
      htmlEscape.convert(item.size);

      final safeBrand =
      htmlEscape.convert(item.brand);

      final safeUnit =
      htmlEscape.convert(item.unit);

      final String qtyStr =
      item.quantity % 1 == 0
          ? item.quantity.toInt().toString()
          : item.quantity.toString();

      final String priceStr =
      item.unitPrice > 0
          ? '৳${_money(item.unitPrice)}'
          : '—';

      final String totalStr =
      item.totalPrice > 0
          ? '৳${_money(item.totalPrice)}'
          : '—';

      final String specBrand = [
        if (safeSize.isNotEmpty)
          safeSize,

        if (safeBrand.isNotEmpty)
          'ব্র্যান্ড: $safeBrand',
      ].join(' • ');

      tableRowsHtml.write('''
        <tr>

          <td class="text-center">
            ${i + 1}
          </td>

          <td>

            <strong>$safeItemName</strong>

            ${specBrand.isNotEmpty ? '''
              <br>
              <span class="material-spec">
                $specBrand
              </span>
            ''' : ''}

          </td>

          <td class="text-center">
            <strong>$qtyStr</strong>
          </td>

          <td class="text-center">
            $safeUnit
          </td>

          ${showPrice ? '''
            <td class="text-center">
              $priceStr
            </td>

            <td class="text-center">
              <strong>$totalStr</strong>
            </td>
          ''' : ''}

        </tr>
      ''');
    }

    // Business and document header

    final String headerContentHtml = '''

      <table class="header-table">

        <tr>

          <td>

            <div class="brand-title">
              $safeContractorName
            </div>

            <div class="brand-sub">
              ঠিকাদার: $safeContractorName
              • মোবাইল: $safeContractorPhone
            </div>

            <div class="brand-sub">
              ঠিকানা: $safeContractorAddress
            </div>

          </td>

          <td class="doc-info-box">

            <div style="
              font-size: 16px;
              font-weight: 700;
              color: #0B57D0;
              margin-bottom: 2px;
            ">
              মালামালের তালিকা
            </div>

            <div>
              মেমো: <strong>$safeMemoNo</strong>
            </div>

            <div>
              তারিখ: <strong>$safeDateText</strong>
            </div>

          </td>

        </tr>

      </table>

      <div class="divider"></div>

      <div class="info-card">

        <table class="info-card-table">

          <tr>

            <td>

              <div class="info-label">
                ক্লায়েন্টের তথ্য
              </div>

              <div class="info-val-bold">
                $safeClientName
              </div>

              <div class="info-val-sub">
                মোবাইল: $safeClientPhone
              </div>

            </td>

            <td>

              <div class="info-label">
                কাজের বিবরণ
              </div>

              <div class="info-val-bold">
                $safeJobName
              </div>

              <div class="info-val-sub">
                ঠিকানা: $safeClientAddress
              </div>

            </td>

          </tr>

        </table>

      </div>
    ''';

    // One continuous material table

    final String materialTableHtml = '''

      <table class="materials-table">

        <thead>

          <tr>

            <th class="text-center"
                style="width: 32px;">
              #
            </th>

            <th>
              মালামালের নাম ও স্পেসিফিকেশন
            </th>

            <th class="text-center"
                style="width: 65px;">
              পরিমাণ
            </th>

            <th class="text-center"
                style="width: 45px;">
              একক
            </th>

            ${showPrice ? '''

              <th class="text-center"
                  style="width: 65px;">
                একক দাম
              </th>

              <th class="text-center"
                  style="width: 75px;">
                মোট
              </th>

            ''' : ''}

          </tr>

        </thead>

        <tbody>

          $tableRowsHtml

        </tbody>

      </table>

    ''';

    // Total and client note

    final String lastPageExtrasHtml = '''

      ${showPrice && grandTotal > 0 ? '''

        <table
          class="document-total"
          style="
            width: 100%;
            margin-top: 4px;
            margin-bottom: 10px;
          "
        >

          <tr>

            <td class="text-right"
                style="
                  font-size: 13px;
                  font-weight: 700;
                  color: #0B57D0;
                ">

              মালামালের আনুমানিক মোট:
              ৳${_money(grandTotal)}

            </td>

          </tr>

        </table>

      ''' : ''}

      ${safeClientNote.isNotEmpty ? '''

        <div class="note-box">

          <strong>
            ক্লায়েন্টের জন্য নোট:
          </strong>

          $safeClientNote

        </div>

      ''' : ''}

    ''';

    // Footer appears only once in the document

    final String footerSectionHtml = '''

      <div class="last-page-footer">

        <table class="signature-table">

          <tr>

            <td>

              <div class="signature-line"></div>

              <div class="signature-text">
                ক্লায়েন্ট / কর্মীর স্বাক্ষর
              </div>

            </td>

            <td>

              <div class="signature-line"></div>

              <div class="signature-text">
                ঠিকাদারের স্বাক্ষর
              </div>

            </td>

          </tr>

        </table>

        <div class="footer-notice">

          এটি Smart Contractor অ্যাপ দ্বারা তৈরি
          মালামালের আনঅফিসিয়াল রিকুইজিশন স্লিপ।
          কেনার আগে পরিমাণ ও মাপ মিলিয়ে নিন।

        </div>

      </div>

    ''';

    final String bodyHtml = '''

      $headerContentHtml

      $materialTableHtml

      $lastPageExtrasHtml

      $footerSectionHtml

    ''';

    return BasePdfTemplate.wrapInA4HtmlLayout(
      title: 'মালামালের তালিকা - $clientName',
      bodyHtml: bodyHtml,
      regularFontBase64: regularFontBase64,
      boldFontBase64: boldFontBase64,
    );
  }
}
