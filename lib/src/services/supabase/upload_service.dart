import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gal/gal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/models/photo_model.dart';
import '../local/hive_service.dart';
import 'package:flutter/material.dart';

class UploadService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  static Future<void> startUploadPipeline({
    required File originalFile,
    required String groupId,
    required String uploaderUid,
    required int groupMemberCount,
  }) async {
    final bytes = await originalFile.readAsBytes();
    
    // Step 1: Deduplication (MD5 Hash)
    final imageHash = md5.convert(bytes).toString();
    final existingPhotos = await _supabase
        .from('photos')
        .select('id')
        .eq('group_id', groupId)
        .eq('image_hash', imageHash);

    if (existingPhotos.isNotEmpty) {
      throw Exception('Photo already shared in this group.');
    }

    // Step 2: Compression
    final thumbBytes = await FlutterImageCompress.compressWithList(
      bytes,
      minWidth: 400,
      minHeight: 400,
      quality: 80,
      format: CompressFormat.webp,
    );

    final fullBytes = await FlutterImageCompress.compressWithList(
      bytes,
      minWidth: 1200,
      minHeight: 1200,
      quality: 85,
      format: CompressFormat.webp,
    );

    // Get original dimensions
    final decodedImage = await decodeImageFromList(bytes);
    final width = decodedImage.width;
    final height = decodedImage.height;

    // Step 3: Save to device MediaStore
    await HiveService.uploadedHashes.put(imageHash, true);
    final hasAccess = await Gal.hasAccess();
    if (!hasAccess) {
      await Gal.requestAccess();
    }
    await Gal.putImage(originalFile.path, album: 'Clickd');

    // Step 4: Optimistic UI
    // Insert placeholder locally here.

    // Step 5: Upload to Supabase Storage
    // We use UUID v4 for the photoId, or let Supabase generate it (we generate it so we can upload with it)
    final photoId = _supabase.auth.currentUser?.id ?? DateTime.now().millisecondsSinceEpoch.toString(); 
    // Wait, let's use a proper UUID generator or random string for photo ID.
    // For now we'll just use the hash + timestamp
    final uniqueId = '${imageHash}_${DateTime.now().millisecondsSinceEpoch}';
    final thumbPath = '$groupId/${uniqueId}_thumb.webp';
    final fullPath = '$groupId/${uniqueId}_full.webp';

    await _supabase.storage.from('groups').uploadBinary(thumbPath, thumbBytes, fileOptions: const FileOptions(contentType: 'image/webp'));
    await _supabase.storage.from('groups').uploadBinary(fullPath, fullBytes, fileOptions: const FileOptions(contentType: 'image/webp'));

    // Step 6: Generate signed URLs
    final thumbUrl = await _supabase.storage.from('groups').createSignedUrl(thumbPath, 60 * 60 * 24);
    final fullUrl = await _supabase.storage.from('groups').createSignedUrl(fullPath, 60 * 60 * 24);

    // Step 7: Create database document
    final expiry = DateTime.now().add(const Duration(hours: 24));
    
    final photoDoc = PhotoModel(
      groupId: groupId,
      uploadedBy: uploaderUid,
      thumbUrl: thumbUrl,
      fullUrl: fullUrl,
      storageThumbPath: thumbPath,
      storageFullPath: fullPath,
      imageHash: imageHash,
      width: width,
      height: height,
      memberCount: groupMemberCount,
      downloadedBy: [uploaderUid],
      createdAt: DateTime.now(),
      deletedFromStorage: false,
      signedUrlExpiry: expiry,
    );

    // We omit 'id' so Supabase auto-generates the UUID
    final jsonDoc = photoDoc.toJson();
    jsonDoc.remove('id'); // let Postgres generate it
    
    await _supabase.from('photos').insert(jsonDoc);

    // Step 8: Notification (Triggered automatically by Supabase Edge Function or Postgres Webhook to FCM)
  }
}
