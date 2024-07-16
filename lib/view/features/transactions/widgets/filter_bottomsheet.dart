import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

filterBottomSheet({
  required BuildContext context,
  required List<dynamic> filterTabList,
  required List<dynamic> isSelectedList,
  required List<dynamic> filterDateList,
  required String selectedFilterDate,
  required TextEditingController startDateController,
  required TextEditingController endDateController,
}) {
  AppBottomSheet.showBottomSheet(
    context,
    widget: StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionHeader(text: 'Filter'),
          16.0.height,
          Text(
            'Services',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlackColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          16.0.height,
          SizedBox(
            height: 35.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: filterTabList.length,
              separatorBuilder: (context, index) => 8.0.width,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      isSelectedList[index] = !isSelectedList[index];
                    });
                    if (kDebugMode) print(isSelectedList);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelectedList[index]
                          ? AppColors.kPrimaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filterTabList[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: isSelectedList[index]
                                ? AppColors.kWhiteColor
                                : AppColors.kInactiveColor,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Date
          16.0.height,
          Text(
            'Date',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlackColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filterDateList.length,
            itemBuilder: (context, index) {
              var list = filterDateList[index];
              return RadioListTile(
                splashRadius: 0,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  list,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kBlackColor,
                      ),
                ),
                value: list,
                groupValue: selectedFilterDate,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (v) {
                  setState(() {
                    selectedFilterDate = v ?? "";
                  });
                },
              );
            },
          ),

          // Custom Date Filter
          Visibility(
            visible: selectedFilterDate == 'Custom',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  8.0.height,
                  Row(
                    children: [
                      Expanded(
                        child: TextInput(
                          controller: startDateController,
                          header: 'Start Date',
                          hint: 'DD/MM',
                          inputType: TextInputType.datetime,
                          validator: validateGeneric,
                          animate: false,
                        ),
                      ),
                      16.0.width,
                      Expanded(
                        child: TextInput(
                          controller: endDateController,
                          header: 'End Date',
                          hint: 'DD/MM',
                          inputType: TextInputType.datetime,
                          validator: validateGeneric,
                          animate: false,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          24.0.height,
          MainButton(
            text: 'Apply',
            onPressed: () => context.pop(),
          )
        ],
      );
    }),
  );
}
