import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class AppBottomSheet {
  static Future<void> showBottomSheet(
    BuildContext context, {
    required Widget widget,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        barrierColor: Colors.black.withOpacity(0.2),
        enableDrag: enableDrag,
        isScrollControlled: true,
        isDismissible: isDismissible,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: const ShapeDecoration(
                      color: AppColors.kWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ))),
                  child: SafeArea(
                    child: widget,
                  )),
            );
          });
        });
  }
}
