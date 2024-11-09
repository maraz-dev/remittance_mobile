import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_state.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';

class SelectedTransferStateNotifier extends StateNotifier<TransferState> {
  SelectedTransferStateNotifier(this.ref) : super(TransferState()) {
    _initializeDefaultSelections();
  }

  final Ref ref;

  void _initializeDefaultSelections() {
    // Default Country
    ref.listen(
      sourceCurrencyProvider,
      (_, next) {
        next.whenData((sourceCountry) {
          if (state.sourceCurrency == null) {
            selectSourceCurrency(sourceCountry.first);
          }
        });
      },
    );

    // Listen to destination countries changes
    ref.listen(destinationCountryProvider, (previous, next) {
      next.whenData((countries) {
        if (countries.isNotEmpty && state.destinationCountry == null) {
          final firstCountry = countries.first;
          selectDestinationCountry(firstCountry);

          selectDestinationCurrency(firstCountry.destinationCurrencies!.first);
        }
      });
    });
  }

  void selectSourceCurrency(SMCountry country) {
    state = state.copyWith(sourceCurrency: country);
  }

  void selectDestinationCountry(SMCountry country) {
    state = state.copyWith(
      destinationCountry: country,
      destinationCurrency: null,
    );
  }

  void selectDestinationCurrency(DestinationCurrency currency) {
    state = state.copyWith(destinationCurrency: currency);
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

final sourceCurrencyProvider = Provider<AsyncValue<List<SMCountry>>>((ref) {
  final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

  return corridors.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    data: (data) {
      return AsyncValue.data(data.first.sourceCurrencies ?? []);
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
