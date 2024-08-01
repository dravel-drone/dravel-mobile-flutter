package com.k1a2.dravel

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.util.Log
import com.kakao.vectormap.KakaoMapSdk
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.io.Console

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val ai: ApplicationInfo = context.packageManager
            .getApplicationInfo(context.packageName, PackageManager.GET_META_DATA)
        val ak: String = ai.metaData.getString("kakaoKey")!!

        Log.d("kakaoKey", ak)

        KakaoMapSdk.init(this, ak)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("map-kakao", KakaoMapFactor())
    }
}

class KakaoMapFactor : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        var creationParams: Map<String?, Any?>? = null
        if (params != null) {
            creationParams = params as Map<String?, Any?>?
        }
        return KakaoMapActivity(context, creationParams)
    }
}
