import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/feed/main_shell.dart';
import '../../features/feed/library_screen.dart';
import '../../features/camera/camera_screen.dart';
import '../../features/upload/gallery_picker.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/auth_provider.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/feed/full_viewer_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/library',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (!isLoggedIn) {
        return isLoggingIn ? null : '/login';
      }
      
      if (isLoggedIn && isLoggingIn) {
        return '/library';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/library',
            builder: (context, state) => const LibraryScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Search Placeholder'))),
          ),
          GoRoute(
            path: '/my_shots',
            builder: (context, state) => const Scaffold(body: Center(child: Text('My Shots Placeholder'))),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/camera',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/gallery',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const GalleryPickerScreen(),
      ),
      GoRoute(
        path: '/viewer/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FullViewerScreen(initialPhotoId: id);
        },
      ),
    ],
  );
});
