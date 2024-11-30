import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

class UploadKycDocNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> uploadKycDocMethod(File file, String fileName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(kycRepository).uploadKycFile(file, fileName));
  }

  @override
  FutureOr<String> build() {
    return "";
  }
}

final uploadKycDocProvider =
    AsyncNotifierProvider.autoDispose<UploadKycDocNotifier, String>(UploadKycDocNotifier.new);

class UploadKycFileNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> uploadKycFileMethod(File file, String fileName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(kycRepository).uploadKycFile(file, fileName));
  }

  @override
  FutureOr<String> build() {
    return "";
  }
}

final uploadKycFileProvider =
    AsyncNotifierProvider.autoDispose<UploadKycFileNotifier, String>(UploadKycFileNotifier.new);
