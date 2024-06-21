import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/utils/app_date_picker.dart';
import 'package:remittance_mobile/view/utils/bottomsheets/kyc_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SsnAndBvnView extends StatefulWidget {
  static String path = '/ssn-and-bvn-view';
  const SsnAndBvnView({super.key});

  @override
  State<SsnAndBvnView> createState() => _SsnAndBvnViewState();
}

class _SsnAndBvnViewState extends State<SsnAndBvnView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _ssnOrBvn = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  String _selectedDOB = '';

  @override
  void dispose() {
    _ssnOrBvn.dispose();
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

              /// SSN or BVN
              TextInput(
                header: 'Social Security Number / BVN',
                controller: _ssnOrBvn,
                hint: "Enter Number",
                inputType: TextInputType.number,
                validator: validateGeneric,
              ),
              16.0.height,

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
                context.pop();
                kycData.addAll({
                  'RequestId': SharedPrefManager.userId,
                  'BvnOrSsn': _ssnOrBvn.text,
                  'DateOfBirth': _selectedDOB,
                });
                kycPosition.value += 1;
                kycBottomSheet(
                  context: context,
                  current: 1,
                );
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
