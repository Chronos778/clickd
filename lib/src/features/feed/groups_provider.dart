import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/group_model.dart';
import '../auth/auth_provider.dart';

final groupsProvider = StreamProvider<List<GroupModel>>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final user = ref.watch(currentUserProvider);

  if (user == null) return Stream.value([]);

  // Thanks to Supabase Row Level Security (RLS), this stream will automatically
  // only return groups where the user is in the 'members' array.
  return supabase
      .from('groups')
      .stream(primaryKey: ['id'])
      .map((data) => data.map((json) => GroupModel.fromJson(json)).toList());
});
