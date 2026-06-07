import 'package:flutter/services.dart';

class BackgroundServiceManager {
  static const MethodChannel _channel = MethodChannel('com.clickd.clickd/background_service');

  static Future<void> startService() async {
    try {
      await _channel.invokeMethod('startService');
    } catch (e) {
      print('Failed to start background service: $e');
    }
  }

  static Future<void> stopService() async {
    try {
      await _channel.invokeMethod('stopService');
    } catch (e) {
      print('Failed to stop background service: $e');
    }
  }

  static Future<String?> getInitialDetectedPhoto() async {
    try {
      final String? uri = await _channel.invokeMethod('getInitialPhoto');
      return uri;
    } catch (e) {
      print('Failed to get initial photo: $e');
      return null;
    }
  }
}
