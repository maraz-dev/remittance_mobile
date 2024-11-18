import 'dart:async';
import 'dart:io';
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:screenshot/screenshot.dart';

class ShareImage {
  static Future<File> imgTransxReceipt({required TransxDetail details}) async {
    // Create a GlobalKey to use with RepaintBoundary
    //final GlobalKey globalKey = GlobalKey();

    // Build the receipt widget
    Widget receiptWidget = Material(
      child: Container(
        decoration: const BoxDecoration(color: AppColors.kGrey200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receipt',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        details.transactionDate!.transactionDate(),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.appIcon,
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '${details.trxAmount.formatDecimal()} ${details.sourceCurrency}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sender',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '${SharedPrefManager.firstName} ${SharedPrefManager.lastName}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Receiver
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Receiver',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '${details.beneficiary!.contains('|') ? details.beneficiary!.split('|')[1] : details.beneficiary}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Account Number (if available)
              if (details.beneficiary!.contains('|') &&
                  (details.beneficiary?.split('|')[2].isNotEmpty ?? false)) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Number',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      '${details.beneficiary?.split('|')[2]}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Reference Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reference Number',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '${details.reference}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Remarks
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remarks (Narration)',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '${details.narration}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );

    return ImageApi.saveImage(
      image: receiptWidget,
      name: '${APP_NAME.toLowerCase()}_transaction_receipt.png',
    );
  }
}

class ImageApi {
  static Future<File> saveImage({required Widget image, required String name}) async {
    final controller = ScreenshotController();
    final output = await getTemporaryDirectory();
    final bytes = await controller.captureFromWidget(image);
    final file = File("${output.path}/$name");

    final res = file.writeAsBytes(bytes);

    return res;
  }
}
