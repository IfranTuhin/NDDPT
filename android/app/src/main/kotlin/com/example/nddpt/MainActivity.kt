package com.example.nddpt

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.nddpt/mobile_data"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger ?: return, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openMobileDataSettings") {
                val intent = Intent(Settings.ACTION_WIFI_SETTINGS) // TODO: Mobile data setting : ACTION_DATA_ROAMING_SETTINGS
                startActivity(intent)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
