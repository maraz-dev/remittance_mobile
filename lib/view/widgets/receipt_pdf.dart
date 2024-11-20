import 'dart:io';
import 'package:config/config.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class SharePDF {
  static Future<File> pdfTransxReceipt({required TransxDetail details}) async {
    final pdfDoc = pdf.Document(creator: APP_NAME);

    // Convert the Images
    final ByteData logo = await rootBundle.load(AppImages.appIcon);
    Uint8List appLogo = logo.buffer.asUint8List();

    pdfDoc.addPage(
      pdf.Page(
        // theme: pdf.ThemeData.withFont(
        //   base: Font.ttf(await rootBundle.load("assets/fonts/Regular.OTF")),
        //   bold: Font.ttf(await rootBundle.load("assets/fonts/Bold.OTF")),
        // ),
        build: (context) {
          return pdf.Container(
            padding: const pdf.EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            decoration: pdf.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pdf.BorderRadius.circular(12),
            ),
            child: pdf.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                  children: [
                    pdf.Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pdf.Text(
                          'Receipt',
                          style: pdf.TextStyle(
                              fontSize: 16,
                              fontWeight: pdf.FontWeight.bold,
                              color: PdfColors.grey700),
                        ),
                        SizedBox(height: 5),
                        pdf.Text(
                          details.transactionDate!.transactionDate(),
                          style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                        ),
                      ],
                    ),
                    pdf.Image(
                      pdf.MemoryImage(appLogo),
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
                SizedBox(height: 1),

                // Status
                pdf.Text(
                  '${details.status}',
                  style: pdf.TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: switch (details.status ?? "") {
                      "Completed" => const PdfColor.fromInt(0xFF039855),
                      "Failed" => const PdfColor.fromInt(0xFFD92D20),
                      "Cancelled" => const PdfColor.fromInt(0xFFD92D20),
                      "Pending" => const PdfColor.fromInt(0xFFF79009),
                      String() => const PdfColor.fromInt(0xFFF79009),
                    },
                  ),
                ),
                SizedBox(height: 32),

                // Amount
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Amount',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${details.trxAmount.formatDecimal()} ${details.currency!.shortCode}',
                      style: pdf.TextStyle(
                          fontSize: 32, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                // Sender
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Sender',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${SharedPrefManager.firstName} ${SharedPrefManager.lastName}',
                      style: pdf.TextStyle(
                          fontSize: 16, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Receiver
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Receiver',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${details.beneficiary!.contains('|') ? details.beneficiary!.split('|')[1] : details.beneficiary}',
                      style: pdf.TextStyle(
                          fontSize: 16, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Account Number
                if (details.beneficiary!.contains('|') &&
                    (details.beneficiary?.split('|')[2].isNotEmpty ?? false)) ...[
                  pdf.Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pdf.Text(
                        'Account Number',
                        style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                      ),
                      SizedBox(height: 5),
                      pdf.Text(
                        '${details.beneficiary?.split('|')[2]}',
                        style: pdf.TextStyle(
                            fontSize: 16,
                            fontWeight: pdf.FontWeight.bold,
                            color: PdfColors.grey700),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],

                // Reference Number
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Transaction Type',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${details.postingType}',
                      style: pdf.TextStyle(
                          fontSize: 16, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Reference Number
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Reference Number',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${details.reference}',
                      style: pdf.TextStyle(
                          fontSize: 16, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Remarks
                pdf.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pdf.Text(
                      'Remarks (Narration)',
                      style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey500),
                    ),
                    SizedBox(height: 5),
                    pdf.Text(
                      '${details.narration}',
                      style: pdf.TextStyle(
                          fontSize: 16, fontWeight: pdf.FontWeight.bold, color: PdfColors.grey700),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );

    return PdfApi.saveDocument(
      name: '${APP_NAME.toLowerCase()}_transaction_receipt.pdf',
      pdf: pdfDoc,
    );
  }
}

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$name");

    final res = await file.writeAsBytes(await pdf.save());

    return res;
  }
}
