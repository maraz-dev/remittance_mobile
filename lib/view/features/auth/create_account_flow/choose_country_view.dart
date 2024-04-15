import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/country_model.dart';
import 'package:remittance_mobile/view/features/auth/vm/countries_vm.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';

ValueNotifier<CountryModel> selectedCountry = ValueNotifier(CountryModel());

class ChooseCountryView extends ConsumerStatefulWidget {
  final VoidCallback pressed;

  const ChooseCountryView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends ConsumerState<ChooseCountryView> {
  /// Global Keys
  final GlobalKey<State> _key = GlobalKey();

  /// Controllers
  final TextEditingController _country = TextEditingController();

  /// Variables
  CountryModel _selectedCountry = CountryModel();

  @override
  void dispose() {
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chooseCountryProvider, (_, next) {
      if (next is AsyncData<List<CountryModel>>) {}
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              const BackArrowButton(),
              18.0.height,
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.displayLarge,
              )
                  .animate()
                  .fadeIn(
                    begin: 0,
                    delay: 400.ms,
                  )
                  .slideY(begin: -.5, end: 0),
              8.0.height,
              RichTextWidget(
                text: 'Already have an Account?',
                hyperlink: ' Log In',
                onTap: () => context.pop(),
              )
                  .animate()
                  .fadeIn(
                    begin: 0,
                    delay: 400.ms,
                  )
                  .slideX(begin: -.1, end: 0),
              32.0.height,
              TextInput(
                key: _key,
                header: 'Country',
                controller: _country,
                hint: "Select your Country",
                inputType: TextInputType.text,
                validator: validateGeneric,
                readOnly: true,
                suffixIcon: SvgPicture.asset(
                  AppImages.arrowDown,
                  fit: BoxFit.scaleDown,
                ),
                onPressed: () async {
                  final mounted = this.mounted;
                  List<CountryModel>? items = await ref
                      .read(chooseCountryProvider.notifier)
                      .loadCountries();
                  if (mounted && items != null && items.isNotEmpty) {
                    List<String> itemList =
                        items.map((e) => "${e.flag} ${e.name}").toList();
                    await platformSpecificDropdown(
                      key: _key,
                      context: context,
                      items: itemList,
                      value: _selectedCountry.name ?? "",
                      onChanged: (newValue) {
                        setState(() {
                          _country.text = newValue ?? "";
                          _selectedCountry = items
                              .where((element) =>
                                  element.flag == newValue!.split(' ').first)
                              .single;
                        });
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          height: 130.h,
          children: [
            const RichTextWidget(
              text: "By continuing, you’ve accepted our ",
              hyperlink: 'terms and conditions.',
              onTap: null,
            ),
            12.0.height,
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                widget.pressed();
                selectedCountry.value = _selectedCountry;
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
            10.0.height,
          ],
        ),
      ),
    );
  }
}
