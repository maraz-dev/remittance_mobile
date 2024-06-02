import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/view/features/auth/vm/auth_providers.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';

ValueNotifier<NewCountryModel> selectedCountry =
    ValueNotifier(NewCountryModel());

class ChooseCountryView extends ConsumerStatefulWidget {
  static String path = 'choose-country-view';
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
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Controllers
  final TextEditingController _country = TextEditingController();

  /// Variables
  NewCountryModel _selectedCountry = NewCountryModel();

  @override
  void dispose() {
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getCountries = ref.watch(getCountryProvider);
    return AbsorbPointer(
      absorbing: getCountries.isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                getCountries.maybeWhen(
                  orElse: () => const SpinKitDualRing(
                    color: AppColors.kPrimaryColor,
                    size: 25,
                  ),
                  error: (error, stackTrace) => TextInput(
                    header: 'Country',
                    controller: _country,
                    hint: error.toString(),
                    inputType: TextInputType.text,
                    validator: validateGeneric,
                    readOnly: true,
                  ),
                  data: (data) => TextInput(
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
                      // List<CountryModel>? items = await ref
                      //     .read(chooseCountryProvider.notifier)
                      //     .loadCountries();
                      if (mounted && data.isNotEmpty) {
                        List<String> itemList =
                            data.map((e) => "${e.name}").toList();
                        itemList.sort();
                        await platformSpecificDropdown(
                          key: _key,
                          context: context,
                          items: itemList,
                          value: _selectedCountry.name ?? "",
                          onChanged: (newValue) {
                            setState(() {
                              _country.text = newValue ?? "";
                              _selectedCountry = data.elementAt(data.indexWhere(
                                  (element) => element.name == newValue));
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
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
                if (_formKey.currentState!.validate()) {
                  widget.pressed();
                  selectedCountry.value = _selectedCountry;
                }
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
