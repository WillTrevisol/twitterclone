import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/features/auth/controller/auth_controller.dart';
import 'app/features/auth/view/login_view.dart';
import 'app/features/home/view/home_view.dart';
import 'app/theme/theme.dart';
import 'app/widgets/deafult_loading.dart';
import 'app/widgets/error_view.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Twitter Clone',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccoutProvider).when(
        data: (data) {
          if (data != null) {
            return const HomeView();
          }

          return const LoginView();
        }, 
        error: (error, stackTrace) => ErrorView(message: error.toString()),
        loading: () => const Scaffold(body:DefaultLoading()),
      ),
    );
  }
}