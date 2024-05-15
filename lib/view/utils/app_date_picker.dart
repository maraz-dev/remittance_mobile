import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';

Future<DateTime?> showPlatformDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  SelectableDayPredicate? selectableDayPredicate,
  String? helpText,
  String? cancelText,
  String? confirmText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  String? errorFormatText,
  String? errorInvalidText,
  String? fieldHintText,
  String? fieldLabelText,
  Key? key,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
  int minimumYear = 1,
  int? maximumYear,
  int minuteInterval = 1,
  bool use24hFormat = false,
  Color? backgroundColor,
  double? height,
  bool showMaterial = false,
  bool showCupertino = false,
}) async {
  if ((Theme.of(context).platform == TargetPlatform.iOS && !showMaterial) ||
      showCupertino) {
    DateTime? keep;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height:
                  height ?? MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                key: key,
                mode: mode,
                onDateTimeChanged: (date) {
                  keep = date;
                },
                backgroundColor: backgroundColor,
                // backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                minimumYear: minimumYear,
                maximumYear: maximumYear,
                minuteInterval: minuteInterval,
                use24hFormat: use24hFormat,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MainButton(
                      color: AppColors.kBlackColor,
                      onPressed: () => Navigator.pop(context),
                      text: "Cancel",
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        keep ??= DateTime.now();
                        Navigator.pop(context);
                      },
                      text: "Ok",
                    ),
                  ),
                  // ClickableText(
                  //     height: 30,
                  //     bgColor: AppColors.primaryColor,
                  //     color: Colors.white,
                  //     textSize: 20,
                  //     text: "Ok",
                  //     onPressed: () {
                  //       keep ??= DateTime.now();
                  //       Navigator.pop(context);
                  //     }),
                  // const SizedBox(
                  //   width: 30,
                  // ),
                  // ClickableText(
                  //     height: 30,
                  //     horizontal: 50,
                  //     color: Colors.white,
                  //     bgColor: AppColors.primaryColor,
                  //     textSize: 20,
                  //     text: "Cancel",
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     }),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        );
      },
    );

    return keep;
  } else {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: builder,
      cancelText: cancelText,
      confirmText: confirmText,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
      helpText: helpText,
      initialDatePickerMode: initialDatePickerMode,
      initialEntryMode: initialEntryMode,
      locale: locale,
      routeSettings: routeSettings,
      selectableDayPredicate: selectableDayPredicate,
      textDirection: textDirection,
      useRootNavigator: useRootNavigator,
    );
  }
}

Future<TimeOfDay?> showPlatformTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  TransitionBuilder? builder,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Key? key,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.time,
  int minuteInterval = 1,
  bool use24hFormat = false,
  Color? backgroundColor,
  double? height,
  bool showCupertino = false,
  bool showMaterial = false,
}) async {
  if ((Theme.of(context).platform == TargetPlatform.iOS && !showMaterial) ||
      showCupertino) {
    DateTime now = DateTime.now();
    TimeOfDay? keep;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                key: key,
                mode: mode,
                onDateTimeChanged: (date) =>
                    keep = TimeOfDay.fromDateTime(date),
                backgroundColor: backgroundColor,
                // backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                initialDateTime: DateTime(
                  now.year,
                  now.month,
                  now.day,
                  initialTime.hour,
                  initialTime.minute,
                ),
                minuteInterval: minuteInterval,
                use24hFormat: use24hFormat,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MainButton(
                      color: AppColors.kBlackColor,
                      onPressed: () => Navigator.pop(context),
                      text: "Cancel",
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        keep ??= TimeOfDay.now();
                        Navigator.pop(context);
                      },
                      text: "Ok",
                    ),
                  ),
                  // ClickableText(
                  //     height: 30,
                  //     bgColor: AppColors.primaryColor,
                  //     color: Colors.white,
                  //     textSize: 20,
                  //     text: "Ok",
                  //     onPressed: () {
                  //       keep ??= DateTime.now();
                  //       Navigator.pop(context);
                  //     }),
                  // const SizedBox(
                  //   width: 30,
                  // ),
                  // ClickableText(
                  //     height: 30,
                  //     horizontal: 50,
                  //     color: Colors.white,
                  //     bgColor: AppColors.primaryColor,
                  //     textSize: 20,
                  //     text: "Cancel",
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     }),
                ],
              ),
            ),
            SizedBox(height: 30.h)
          ],
        );
      },
    );
    return keep;
  } else {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: builder,
      routeSettings: routeSettings,
      useRootNavigator: useRootNavigator,
    );
  }
}
