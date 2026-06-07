import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../services/local/background_service_manager.dart';
import '../auth/auth_provider.dart';

final autoDetectProvider = NotifierProvider<AutoDetectNotifier, bool>(() {
  return AutoDetectNotifier();
});

class AutoDetectNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadPreference();
    return false;
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('auto_detect_enabled') ?? false;
  }

  Future<void> toggle(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auto_detect_enabled', value);
    
    if (value) {
      await BackgroundServiceManager.startService();
    } else {
      await BackgroundServiceManager.stopService();
    }
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final isAutoDetectEnabled = ref.watch(autoDetectProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user != null)
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(user.email ?? 'Unknown User'),
              subtitle: Text(user.id),
            ),
          const Divider(height: 32),
          SwitchListTile(
            title: const Text('Background Auto-Detect'),
            subtitle: const Text('Instantly detect photos taken with your normal camera and prompt to share them.'),
            value: isAutoDetectEnabled,
            onChanged: (value) {
              ref.read(autoDetectProvider.notifier).toggle(value);
            },
            activeThumbColor: Theme.of(context).colorScheme.primary,
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
