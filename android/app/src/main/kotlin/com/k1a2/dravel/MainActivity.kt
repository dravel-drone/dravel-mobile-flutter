package com.k1a2.dravel

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import com.kakao.vectormap.KakaoMapSdk
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.Console

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("map-kakao",
                KakaoMapFactor(flutterEngine.dartExecutor.binaryMessenger))
    }
}

class KakaoMapFactor(
    private val messenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        var creationParams: Map<String?, Any?>? = null
        if (params != null) {
            creationParams = params as Map<String?, Any?>?
        }
        return KakaoMapActivity(context, creationParams, messenger, id)
    }
}
