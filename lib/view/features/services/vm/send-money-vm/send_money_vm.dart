import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_state.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';

class SelectedTransferStateNotifier extends StateNotifier<TransferState> {
  SelectedTransferStateNotifier(this.ref) : super(TransferState()) {
    _initializeDefaultSelections();
  }

  final Ref ref;

  void _initializeDefaultSelections() {
    ref.listen(
      sourceCountryProvider,
      (_, next) {
        next.whenData((sourceCountry) {
          selectSourceCountry(sourceCountry.first);
        });
      },
    );

    // Listen to Destination countries changes
    ref.listen(
      destinationCountryProvider,
      (_, next) {
        next.whenData((countries) {
          if (countries.isNotEmpty && state.destinationCountry == null) {
            final firstCountry = countries.first;
            selectDestinationCountry(firstCountry);
            selectDestinationCurrency(firstCountry.destinationCurrencies!.first);
          }
        });
      },
    );
  }

  void selectSourceCountry(CorridorsResponse country) {
    state = state.copyWith(
      sourceCountry: country,
      sourceCurrency: country.sourceCurrencies!.first,
      destinationCountry: country.destinationCountries!.first,
      destinationCurrency: country.destinationCountries!.first.destinationCurrencies!.first,
      recipientTypes:
          country.destinationCountries!.first.destinationCurrencies!.first.recipientTypes,
    );
    showCharge.value = false;
  }

  void selectSourceCurrency(SMCountry currency) {
    state = state.copyWith(sourceCurrency: currency);
    showCharge.value = false;
  }

  void selectDestinationCountry(SMCountry country) {
    state = state.copyWith(
      destinationCountry: country,
      destinationCurrency: country.destinationCurrencies!.first,
    );
    showCharge.value = false;
  }

  void selectDestinationCurrency(DestinationCurrency currency) {
    state = state.copyWith(
      destinationCurrency: currency,
      recipientTypes: currency.recipientTypes,
    );

    showCharge.value = false;
  }

  void reset() {
    state = TransferState();
  }
}

final selectedTransferStateProvider =
    StateNotifierProvider<SelectedTransferStateNotifier, TransferState>(
        (ref) => SelectedTransferStateNotifier(ref));

// --------------------------------------------------------------
// Providers

final sourceCountryProvider = Provider<AsyncValue<List<CorridorsResponse>>>((ref) {
  final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

  return corridors.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    data: (data) {
      return AsyncValue.data(data);
    },
  );
});

final destinationCountryProvider = Provider<AsyncValue<List<SMCountry>>>((ref) {
  final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

  return corridors.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    data: (data) {
      return AsyncValue.data(data.first.destinationCountries ?? []);
    },
  );
});
