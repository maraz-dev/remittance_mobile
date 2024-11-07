import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class PaymentMethodCard extends StatelessWidget {
  final String? methodName, methodDescription, methodImage;
  const PaymentMethodCard({
    super.key,
    this.methodName,
    this.methodDescription,
    this.methodImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardIcon(
          image: methodImage ?? AppImages.accountDetails,
          bgColor: AppColors.kGrey100,
        ),
        16.0.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    methodName ?? 'Debit Card',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kGrey700, fontWeight: FontWeight.w500),
                  ),
                  if (methodName!.contains('Bank')) ...[
                    8.0.width,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kWarningColor100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Charges apply',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.kWarningColor700,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    )
                  ],
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 20,
                  )
                ],
              ),
              Text(
                methodDescription ??
                    '${1.05.amountWithCurrency('\$')} transaction fees. Your money will arrive in about 2 hours',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<PaymentMethodCard> paymentMethods = [
  const PaymentMethodCard(
    methodImage: AppImages.card,
    methodName: 'Card',
  ),
  const PaymentMethodCard(
    methodImage: AppImages.accountDetails,
    methodName: 'USSD',
  ),
  const PaymentMethodCard(
    methodImage: AppImages.add,
    methodName: 'Apple Pay',
  ),
];
