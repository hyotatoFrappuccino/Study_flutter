package com.github.hyotatoFrappuccino.first_flutter_app

import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.dev/info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method == "getDeviceInfo") {
                        val deviceInfo = getDeviceInfo()
                        result.success(deviceInfo)
                    }
                }
    }
}
