import 'dart:io';
import 'package:config/config.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
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
        theme: pdf.ThemeData.withFont(
          base: Font.ttf(await rootBundle.load("assets/fonts/Regular.OTF")),
          bold: Font.ttf(await rootBundle.load("assets/fonts/Bold.OTF")),
        ),
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
              children: [
                pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                  children: [
                    pdf.Column(
                      children: [
                        pdf.Text(
                          'Receipt',
                          style: pdf.TextStyle(
                              fontSize: 16,
                              fontWeight: pdf.FontWeight.bold,
                              color: PdfColors.grey700),
                        ),
                        pdf.Text(
                          details.transactionDate!.transactionDate(),
                          style: const pdf.TextStyle(fontSize: 14, color: PdfColors.grey400),
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
