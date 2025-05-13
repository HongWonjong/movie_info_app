import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_app/core/permissions/permission_service.dart';
import 'package:flutter_movie_app/presentation/pages/home_page.dart';
import 'package:flutter_movie_app/presentation/pages/permission_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: PermissionService().areAllPermissionsGranted(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const HomePage();
          }
          return const PermissionPage();
        },
      ),
      routes: {
        '/permission': (context) => const PermissionPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}