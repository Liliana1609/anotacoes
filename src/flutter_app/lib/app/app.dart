import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../features/account/account_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/plans/plans_screen.dart';
import '../features/resume/editor_screen.dart';
import '../features/resume/preview_screen.dart';
import '../features/resume/templates_screen.dart';
import '../features/resume/export_screen.dart';
import '../features/photo_ai/photo_ai_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/language/language_screen.dart';
import '../features/auth/auth_controller.dart';

final _routerProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authController,
    redirect: (context, state) {
      final isLoggedIn = authController.user != null;
      final isAuthRoute = state.uri.path == '/login' || state.uri.path == '/onboarding';

      if (!isLoggedIn && !isAuthRoute && state.uri.path != '/splash') {
        return '/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/editor', builder: (_, __) => const EditorScreen()),
      GoRoute(path: '/photo', builder: (_, __) => const PhotoAiScreen()),
      GoRoute(path: '/templates', builder: (_, __) => const TemplatesScreen()),
      GoRoute(path: '/preview', builder: (_, __) => const PreviewScreen()),
      GoRoute(path: '/export', builder: (_, __) => const ExportScreen()),
      GoRoute(path: '/plans', builder: (_, __) => const PlansScreen()),
      GoRoute(path: '/languages', builder: (_, __) => const LanguageScreen()),
      GoRoute(path: '/account', builder: (_, __) => const AccountScreen()),
    ],
  );
});

class ResumeApp extends ConsumerWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);
    return MaterialApp.router(
      title: 'Nome do App',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
