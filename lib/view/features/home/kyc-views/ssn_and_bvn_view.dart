import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:remittance_mobile/view/utils/app_date_picker.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SsnAndKycView extends StatefulWidget {
  static String path = '/ssn-and-kyc-view';
  const SsnAndKycView({super.key});

  @override
  State<SsnAndKycView> createState() => _SsnAndKycViewState();
}

class _SsnAndKycViewState extends State<SsnAndKycView> {
  final TextEditingController _ssnOrBvn = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  DateTime _currentDate = DateTime(DateTime.now().year - 16);

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
        body: Column(
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
                final value = await showPlatformDatePicker(
                  context: context,
                  initialDate: _currentDate,
                  maximumYear: _currentDate.year,
                  firstDate: DateTime(1900),
                  lastDate: _currentDate,
                );
                if (value == null) return;
                var formatter = DateFormat('dd-MM-yyyy');
                String formattedDate = formatter.format(value);
                setState(() {
                  _currentDate = value;
                  _dateOfBirth.text = formattedDate;
                });
              },
            ),
            16.0.height,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Continue',
            onPressed: () {},
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
