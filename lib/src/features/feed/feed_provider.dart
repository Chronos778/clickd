import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/photo_model.dart';
import '../auth/auth_provider.dart';

final feedProvider = StreamProvider<List<PhotoModel>>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final user = ref.watch(currentUserProvider);

  if (user == null) return Stream.value([]);

  // Supabase RLS ensures the user only receives photos for groups they belong to.
  return supabase
      .from('photos')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false)
      .map((data) => data.map((json) => PhotoModel.fromJson(json)).toList());
});
