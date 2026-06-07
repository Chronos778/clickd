import 'package:workmanager/workmanager.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../local/hive_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await HiveService.init();
      
      final lastChecked = HiveService.preferences.get('last_checked_timestamp', defaultValue: 0) as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (!ps.isAuth) return Future.value(true);

      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          createTimeCond: DateTimeCond(
            min: DateTime.fromMillisecondsSinceEpoch(lastChecked),
            max: DateTime.fromMillisecondsSinceEpoch(now),
          ),
        ),
      );

      if (paths.isNotEmpty) {
        final List<AssetEntity> entities = await paths.first.getAssetListPaged(page: 0, size: 10);
        
        for (var asset in entities) {
          // In a real implementation, we would hash the file here.
          // For now, we use the asset ID as a mock hash.
          final String mockHash = asset.id; 
          
          final isUploaded = HiveService.uploadedHashes.containsKey(mockHash);
          final isDismissed = HiveService.dismissedHashes.containsKey(mockHash);

          if (!isUploaded && !isDismissed) {
            // Show Notification
            final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
            const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
              'clickd_auto_detect',
              'Auto Detect Notifications',
              channelDescription: 'Notifications for new photos detected',
              importance: Importance.max,
              priority: Priority.high,
            );
            const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
            await flutterLocalNotificationsPlugin.show(
              0,
              'New photo taken',
              'Share to a group?',
              platformChannelSpecifics,
            );
            break; // Prompt once per cycle
          }
        }
      }

      await HiveService.preferences.put('last_checked_timestamp', now);
      return Future.value(true);
    } catch (err) {
      return Future.value(false);
    }
  });
}

class BackgroundService {
  static Future<void> init() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  static void startAutoDetect() {
    Workmanager().registerPeriodicTask(
      "1",
      "autoDetectPhotos",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
      ),
    );
  }

  static void stopAutoDetect() {
    Workmanager().cancelAll();
  }
}
