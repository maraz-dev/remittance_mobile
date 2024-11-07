import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/means_of_id_select_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class IdNumberView extends StatefulWidget {
  static String path = 'id-number-view';
  final VoidCallback pressed;

  const IdNumberView({
    super.key,
    required this.pressed,
  });

  @override
  State<IdNumberView> createState() => _IdNumberViewState();
}

class _IdNumberViewState extends State<IdNumberView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _idNumber = TextEditingController();

  @override
  void dispose() {
    _idNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: innerAppBar(title: 'ID Number'),
      body: ScaffoldBody(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              Text(
                'Provide ID Number of your ${idSelected.value}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kGrey700),
              ),
              24.0.height,

              /// ID Number
              TextInput(
                header: 'ID Number',
                controller: _idNumber,
                hint: "Enter Number",
                inputType: TextInputType.text,
                validator: validateGeneric,
                inputFormatters: [
                  services.FilteringTextInputFormatter.deny(" ")
                ],
              ),
              16.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Add the ID Number to the KYC Data map
                kycData.addAll({
                  'IdNumber': _idNumber.text,
                });
                widget.pressed();
              }
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
