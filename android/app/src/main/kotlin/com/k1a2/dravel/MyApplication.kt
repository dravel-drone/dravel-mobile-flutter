package com.k1a2.dravel

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.util.Log
import com.kakao.vectormap.KakaoMapSdk
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        val ai: ApplicationInfo = applicationContext.packageManager
            .getApplicationInfo(applicationContext.packageName, PackageManager.GET_META_DATA)
        val ak: String = ai.metaData.getString("kakaoKey")!!

        Log.d("kakaoKey", ak)

        KakaoMapSdk.init(this, ak)
        Log.d("init", "init kakaomap")
    }
}