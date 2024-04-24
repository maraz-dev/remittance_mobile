import 'package:remittance_mobile/view/features/home/kyc-views/means_of_id_view.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/proof_of_address.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/selfle_view.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/ssn_and_bvn_view.dart';

class KycOptions {
  final String title, subtitle;
  final dynamic optionPath;
  final KycOptionStatus? status;

  KycOptions({
    required this.title,
    required this.subtitle,
    this.status,
    required this.optionPath,
  });
}

enum KycOptionStatus { done, current, awaiting }

List<KycOptions> kycOptionList = [
  KycOptions(
    title: 'Social Security Number/BVN',
    subtitle: 'Provide your social security number or BVN',
    optionPath: SsnAndKycView.path,
  ),
  KycOptions(
    title: 'Means of ID',
    subtitle: 'Provide your means of ID to verify your identity.',
    optionPath: MeansOfIdView.path,
  ),
  KycOptions(
    title: 'Selfie',
    subtitle: 'Take a live photograph of yourself.',
    optionPath: SelfieView.path,
  ),
  KycOptions(
    title: 'Proof of Address',
    subtitle: 'Provide a document showing where you currently live.',
    optionPath: ProofOfAddressView.path,
  ),
];
