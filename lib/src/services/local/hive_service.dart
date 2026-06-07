import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String feedCacheBox = 'feed_cache';
  static const String uploadQueueBox = 'upload_queue';
  static const String uploadedHashesBox = 'uploaded_hashes';
  static const String dismissedHashesBox = 'dismissed_hashes';
  static const String preferencesBox = 'preferences';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    await Future.wait([
      Hive.openBox(feedCacheBox),
      Hive.openBox(uploadQueueBox),
      Hive.openBox(uploadedHashesBox),
      Hive.openBox(dismissedHashesBox),
      Hive.openBox(preferencesBox),
    ]);
  }

  static Box get feedCache => Hive.box(feedCacheBox);
  static Box get uploadQueue => Hive.box(uploadQueueBox);
  static Box get uploadedHashes => Hive.box(uploadedHashesBox);
  static Box get dismissedHashes => Hive.box(dismissedHashesBox);
  static Box get preferences => Hive.box(preferencesBox);
}
