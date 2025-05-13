import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_app/core/permissions/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionState {
  final bool isCameraGranted;
  final bool isLocationGranted;
  final bool isMicrophoneGranted;
  final bool isLoading;

  PermissionState({
    this.isCameraGranted = false,
    this.isLocationGranted = false,
    this.isMicrophoneGranted = false,
    this.isLoading = false,
  });

  PermissionState copyWith({
    bool? isCameraGranted,
    bool? isLocationGranted,
    bool? isMicrophoneGranted,
    bool? isLoading,
  }) {
    return PermissionState(
      isCameraGranted: isCameraGranted ?? this.isCameraGranted,
      isLocationGranted: isLocationGranted ?? this.isLocationGranted,
      isMicrophoneGranted: isMicrophoneGranted ?? this.isMicrophoneGranted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PermissionNotifier extends AsyncNotifier<PermissionState> {
  @override
  Future<PermissionState> build() async {
    final permissionService = PermissionService();
    final cameraGranted = await permissionService.isCameraPermissionGranted();
    final locationGranted = await permissionService.isLocationPermissionGranted();
    final microphoneGranted = await permissionService.isMicrophonePermissionGranted();

    return PermissionState(
      isCameraGranted: cameraGranted,
      isLocationGranted: locationGranted,
      isMicrophoneGranted: microphoneGranted,
    );
  }

  Future<void> requestPermissions() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final permissionService = PermissionService();
      final cameraGranted = await permissionService.requestCameraPermission();
      final locationGranted = await permissionService.requestLocationPermission();
      final microphoneGranted = await permissionService.requestMicrophonePermission();

      return PermissionState(
        isCameraGranted: cameraGranted,
        isLocationGranted: locationGranted,
        isMicrophoneGranted: microphoneGranted,
      );
    });
  }

  Future<void> openSettingsIfPermanentlyDenied() async {
    final permissionService = PermissionService();
    final isCameraDenied = await permissionService.isPermissionPermanentlyDenied(Permission.camera);
    final isLocationDenied = await permissionService.isPermissionPermanentlyDenied(Permission.locationWhenInUse);
    final isMicrophoneDenied = await permissionService.isPermissionPermanentlyDenied(Permission.microphone);

    if (isCameraDenied || isLocationDenied || isMicrophoneDenied) {
      await permissionService.openAppSettings();
    }
  }
}

final permissionProvider = AsyncNotifierProvider<PermissionNotifier, PermissionState>(() => PermissionNotifier());