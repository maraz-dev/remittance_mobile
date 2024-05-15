import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/country_model.dart';

class CountriesNotifier extends AutoDisposeAsyncNotifier<CountryModel> {
  Future<List<CountryModel>?> loadCountries() async {
    try {
      var data = jsonDecode(
          await rootBundle.loadString('assets/countries.json', cache: true));
      if (data != null && data is List) {
        return (data)
            .map<CountryModel>(
                (e) => CountryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  FutureOr<CountryModel> build() {
    return CountryModel();
  }
}

final chooseCountryProvider =
    AsyncNotifierProvider.autoDispose<CountriesNotifier, CountryModel>(
        CountriesNotifier.new);
