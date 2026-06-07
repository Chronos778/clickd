import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'feed_provider.dart';
import 'groups_provider.dart';
import '../auth/auth_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedProvider);
    final groupsState = ref.watch(groupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clickd', style: TextStyle(fontFamily: 'Google Sans', fontWeight: FontWeight.bold, color: Color(0xFF1A73E8))),
      ),
      body: CustomScrollView(
        slivers: [
          // Filter Chips
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  ActionChip(
                    label: const Text('All'),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  ...groupsState.maybeWhen(
                    data: (groups) => groups.map((group) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        label: Text(group.name),
                        onPressed: () {},
                      ),
                    )).toList(),
                    orElse: () => [],
                  ),
                ],
              ),
            ),
          ),
          
          // Masonry Grid
          feedState.when(
            data: (photos) {
              if (photos.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No photos yet. Start sharing!')),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/viewer/${photo.id}');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          // Pre-calculate height ratio using stored metadata to avoid layout shifts
                          aspectRatio: photo.width / photo.height,
                          child: photo.thumbUrl != null 
                              ? CachedNetworkImage(
                                  imageUrl: photo.thumbUrl!,
                                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                )
                              : Container(color: Colors.grey[300], child: const Center(child: Icon(Icons.image))),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    context.pop();
                    context.push('/camera');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    context.pop();
                    context.push('/gallery');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.group_add),
                  title: const Text('New Group'),
                  onTap: () async {
                    context.pop();
                    final nameController = TextEditingController();
                    final result = await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Create New Group'),
                        content: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(hintText: 'Group Name'),
                          autofocus: true,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => context.pop(nameController.text),
                            child: const Text('Create'),
                          ),
                        ],
                      ),
                    );

                    if (result != null && result.trim().isNotEmpty) {
                      final supabase = ref.read(supabaseClientProvider);
                      final user = supabase.auth.currentUser;
                      if (user != null) {
                        try {
                          await supabase.from('groups').insert({
                            'name': result.trim(),
                            'created_by': user.id,
                            'members': [user.id],
                          });
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Group created successfully')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to create group: $e')),
                            );
                          }
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
