import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/means_of_id_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/proof-of-address-flow/proof_of_address_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfle_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/ssn_and_bvn_view.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class KycOptions {
  final String title, subtitle, imagePath;
  final dynamic optionPath;
  final KycOptionStatus? status;

  KycOptions({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.status,
    required this.optionPath,
  });
}

enum KycOptionStatus { done, current, awaiting }

List<KycOptions> kycOptionList = [
  KycOptions(
    imagePath: AppImages.documentUploadIcon,
    title: 'Social Security Number/BVN',
    subtitle: 'Provide your social security number or BVN',
    optionPath: SsnAndBvnView.path,
  ),
  KycOptions(
    imagePath: AppImages.idIcon,
    title: 'Means of ID',
    subtitle: 'Provide your means of ID to verify \nyour identity.',
    optionPath: MeansOfIdView.path,
  ),
  KycOptions(
    imagePath: AppImages.selfieIcon,
    title: 'Selfie',
    subtitle: 'Take a live photograph of yourself.',
    optionPath: SelfieView.path,
  ),
  KycOptions(
    imagePath: AppImages.locationIcon,
    title: 'Proof of Address',
    subtitle: 'Provide a document showing where you \ncurrently live.',
    optionPath: ProofOfAddressView.path,
  ),
];
