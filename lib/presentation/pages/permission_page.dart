import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/permissions/permission_service.dart';
import 'package:flutter_movie_app/presentation/providers/permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionPage extends ConsumerWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(permissionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('권한 설정')),
      body: permissionState.when(
        data: (state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '앱 기능 사용을 위해 다음 권한이 필요합니다:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildPermissionStatus('카메라', state.isCameraGranted),
                _buildPermissionStatus('위치', state.isLocationGranted),
                _buildPermissionStatus('마이크', state.isMicrophoneGranted),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(permissionProvider.notifier).requestPermissions();
                    await ref.read(permissionProvider.notifier).openSettingsIfPermanentlyDenied();
                    // 모든 권한이 허가된 경우 HomePage로 이동
                    final allGranted = await PermissionService().areAllPermissionsGranted();
                    if (allGranted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: const Text('권한 요청'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('건너뛰기'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류 발생: $error')),
      ),
    );
  }

  Widget _buildPermissionStatus(String name, bool isGranted) {
    return Row(
      children: [
        Text(name, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Icon(
          isGranted ? Icons.check_circle : Icons.cancel,
          color: isGranted ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}