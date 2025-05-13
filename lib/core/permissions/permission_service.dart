import 'dart:io' show Platform;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> isCameraPermissionGranted() async {
    return await Permission.camera.isGranted;
  }

  Future<bool> isLocationPermissionGranted() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  Future<bool> isMicrophonePermissionGranted() async {
    return await Permission.microphone.isGranted;
  }

  Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  Future<bool> areAllPermissionsGranted() async {
    if (Platform.isAndroid) {
      // Android: 모든 권한을 개별적으로 확인
      final cameraGranted = await isCameraPermissionGranted();
      final locationGranted = await isLocationPermissionGranted();
      final microphoneGranted = await isMicrophonePermissionGranted();
      return cameraGranted && locationGranted && microphoneGranted;
    } else if (Platform.isIOS) {
      // iOS: 마이크는 선택적 권한으로 간주
      final cameraGranted = await isCameraPermissionGranted();
      final locationGranted = await isLocationPermissionGranted();
      return cameraGranted && locationGranted;
    }
    return false;
  }

  Future<String> getPermissionMessage(Permission permission) async {
    if (Platform.isAndroid && await permission.isPermanentlyDenied) {
      return '이 기능을 사용하려면 설정에서 ${permission.toString()} 권한을 허용해주세요.';
    }
    return '이 기능을 사용하려면 ${permission.toString()} 권한이 필요합니다.';
  }
}