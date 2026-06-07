package com.clickd.clickd

import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.clickd.clickd/background_service"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startService" -> {
                    startPhotoDetectionService()
                    result.success(true)
                }
                "stopService" -> {
                    stopPhotoDetectionService()
                    result.success(true)
                }
                "getInitialPhoto" -> {
                    val uri = intent?.getStringExtra("DETECTED_PHOTO_URI")
                    result.success(uri)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startPhotoDetectionService() {
        val serviceIntent = Intent(this, PhotoDetectionService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(serviceIntent)
        } else {
            startService(serviceIntent)
        }
    }

    private fun stopPhotoDetectionService() {
        val serviceIntent = Intent(this, PhotoDetectionService::class.java)
        stopService(serviceIntent)
    }
}
