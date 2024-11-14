import 'package:remittance_mobile/data/models/responses/corridor_response.dart';

class TransferState {
  final CorridorsResponse? sourceCountry;
  final SMCountry? sourceCurrency;
  final SMCountry? destinationCountry;
  final DestinationCurrency? destinationCurrency;
  final List<RecipientType>? recipientTypes;

  TransferState({
    this.sourceCountry,
    this.sourceCurrency,
    this.destinationCountry,
    this.destinationCurrency,
    this.recipientTypes,
  });

  TransferState copyWith({
    CorridorsResponse? sourceCountry,
    SMCountry? sourceCurrency,
    SMCountry? destinationCountry,
    DestinationCurrency? destinationCurrency,
    List<RecipientType>? recipientTypes,
  }) {
    return TransferState(
      sourceCountry: sourceCountry ?? this.sourceCountry,
      sourceCurrency: sourceCurrency ?? this.sourceCurrency,
      destinationCountry: destinationCountry ?? this.destinationCountry,
      destinationCurrency: destinationCurrency ?? this.destinationCurrency,
      recipientTypes: recipientTypes ?? this.recipientTypes,
    );
  }
}
