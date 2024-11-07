class IdOptions {
  final String text;
  final dynamic optionPath;

  IdOptions({
    required this.text,
    this.optionPath,
  });
}

List idOptionList = [
  IdOptions(text: 'Drivers License'),
  IdOptions(text: 'ID Card (NIN)'),
  IdOptions(text: 'International Passport'),
  IdOptions(text: 'Resident Permit Card'),
  IdOptions(text: 'Passport'),
];

List proofOfAddressList = [
  IdOptions(text: 'Utility Bill'),
  IdOptions(text: 'Insurance Document'),
  IdOptions(text: 'Bank Statement'),
  IdOptions(text: 'Land Telephone Bill'),
  IdOptions(text: 'Resident Permit'),
];
