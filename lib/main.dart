import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/router/app_router.dart';
import 'src/core/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/services/local/hive_service.dart';
import 'src/services/supabase/supabase_options_placeholder.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    print('Starting Hive initialization...');
    await HiveService.init();
    print('Starting Firebase initialization...');
    await Firebase.initializeApp();
    
    print('Starting Supabase initialization...');
    await Supabase.initialize(
      url: SupabaseOptionsPlaceholder.url,
      anonKey: SupabaseOptionsPlaceholder.anonKey,
    );

    print('Starting App...');
    runApp(
      const ProviderScope(
        child: ClickdApp(),
      ),
    );
  } catch (e, stack) {
    print('FATAL ERROR DURING STARTUP: $e');
    print(stack);
  }
}

class ClickdApp extends ConsumerWidget {
  const ClickdApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Clickd',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
