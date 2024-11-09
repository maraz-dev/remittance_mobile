import 'package:remittance_mobile/data/models/responses/corridor_response.dart';

class TransferState {
  final SMCountry? sourceCurrency;
  final SMCountry? destinationCountry;
  final DestinationCurrency? destinationCurrency;

  TransferState({
    this.sourceCurrency,
    this.destinationCountry,
    this.destinationCurrency,
  });

  TransferState copyWith({
    SMCountry? sourceCurrency,
    SMCountry? destinationCountry,
    DestinationCurrency? destinationCurrency,
  }) {
    return TransferState(
      sourceCurrency: sourceCurrency ?? this.sourceCurrency,
      destinationCountry: destinationCountry ?? this.destinationCountry,
      destinationCurrency: destinationCurrency ?? this.destinationCurrency,
    );
  }
}
