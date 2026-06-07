import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../feed/groups_provider.dart';
import '../auth/auth_provider.dart';
import '../../services/supabase/upload_service.dart';

class SelectGroupSheet extends ConsumerStatefulWidget {
  final File file;
  
  const SelectGroupSheet({super.key, required this.file});

  @override
  ConsumerState<SelectGroupSheet> createState() => _SelectGroupSheetState();
}

class _SelectGroupSheetState extends ConsumerState<SelectGroupSheet> {
  bool _isUploading = false;

  Future<void> _uploadToGroup(String groupId, int memberCount) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isUploading = true);

    try {
      await UploadService.startUploadPipeline(
        originalFile: widget.file,
        groupId: groupId,
        uploaderUid: user.id,
        groupMemberCount: memberCount,
      );

      if (mounted) {
        context.pop(); // Close sheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo shared successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupsState = ref.watch(groupsProvider);

    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Share to which group?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Google Sans',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (_isUploading)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            groupsState.when(
              data: (groups) {
                if (groups.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: Text('You are not in any groups yet.')),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Text(group.name.substring(0, 1).toUpperCase()),
                      ),
                      title: Text(group.name),
                      subtitle: Text('${group.members.length} members'),
                      onTap: () => _uploadToGroup(group.id, group.members.length),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
        ],
      ),
    );
  }
}
