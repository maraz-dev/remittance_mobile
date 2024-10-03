import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/means_of_id_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_date_picker.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

enum SsnOrBvn { ssn, bvn }

class SsnAndBvnView extends StatefulWidget {
  static String path = 'ssn-and-bvn-view';
  const SsnAndBvnView({super.key});

  @override
  State<SsnAndBvnView> createState() => _SsnAndBvnViewState();
}

class _SsnAndBvnViewState extends State<SsnAndBvnView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<State> _selectKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _selectSsnOrBvn = TextEditingController();
  final TextEditingController _ssnOrBvn = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  String _selectedDOB = '';

  @override
  void dispose() {
    _ssnOrBvn.dispose();
    _selectSsnOrBvn.dispose();
    _dateOfBirth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Social Security Number/BVN'),
      body: ScaffoldBody(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              16.0.height,
              Text(
                'Provide your social security number and date of birth. This is for identification purposes only!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kGrey700),
              ),
              24.0.height,

              /// Recipient Type Provider
              TextInput(
                key: _selectKey,
                header: 'Social Security Number / BVN',
                controller: _selectSsnOrBvn,
                hint: 'Select BVN or Social Security Number',
                inputType: TextInputType.text,
                validator: validateGeneric,
                readOnly: true,
                suffixIcon: SvgPicture.asset(
                  AppImages.arrowDown,
                  fit: BoxFit.scaleDown,
                ),
                onPressed: () async {
                  await platformSpecificDropdown(
                    key: _selectKey,
                    context: context,
                    items: SsnOrBvn.values
                        .map((number) => number.name.toUpperCase())
                        .toList(),
                    value: _selectSsnOrBvn.text,
                    onChanged: (newValue) {
                      setState(() {
                        _selectSsnOrBvn.text = newValue ?? "";
                      });
                    },
                  );
                },
              ),
              24.0.height,

              /// SSN or BVN
              Visibility(
                visible: _selectSsnOrBvn.text == "" ? false : true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInput(
                      header: _selectSsnOrBvn.text,
                      controller: _ssnOrBvn,
                      hint: "Enter Number",
                      inputType: TextInputType.number,
                      inputFormatters: [
                        services.FilteringTextInputFormatter.digitsOnly,
                        services.LengthLimitingTextInputFormatter(
                            _selectSsnOrBvn.text == "BVN" ? 11 : 9)
                      ],
                      validator: validateGeneric,
                    ),
                    16.0.height,
                  ],
                ),
              ),

              /// Date of Birth
              TextInput(
                header: 'Date of Birth',
                controller: _dateOfBirth,
                hint: "DD/MM/YYYY",
                inputType: TextInputType.name,
                validator: validateGeneric,
                readOnly: true,
                onPressed: () async {
                  // This Date is Done in a way that the last date is 16 years ago
                  final minDate = DateTime(
                    DateTime.now().year - 18,
                    DateTime.now().month,
                    DateTime.now().day,
                  );
                  final value = await showPlatformDatePicker(
                    context: context,
                    initialDate: minDate,
                    maximumYear: minDate.year,
                    firstDate: DateTime(1900),
                    lastDate: minDate,
                  );
                  // TODO: FIX THIS LATER
                  if (value == null) return;
                  var formatter = DateFormat('dd-MM-yyyy');
                  String formattedDate = formatter.format(value);
                  setState(() {
                    _selectedDOB = value.toIso8601String();
                    _dateOfBirth.text = formattedDate;
                  });
                },
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
                // Add the BVN/SSN to the KYC Data map
                kycData.addAll({
                  'BvnOrSsn': _ssnOrBvn.text,
                  'DateOfBirth': _selectedDOB,
                });
                context.pushNamed(MeansOfIdView.path);
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
