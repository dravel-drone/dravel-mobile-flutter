package com.k1a2.dravel

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
import io.flutter.plugin.platform.PlatformView


class KakaoMapActivity(context: Context) : PlatformView {
    private val nativeView: View?

    init {
        val inflater = LayoutInflater.from(context)
        nativeView = inflater.inflate(R.layout.layout_kakao_map, null)
    }

    override fun getView(): View? {
        if (nativeView == null) return null

        val mapView: MapView = nativeView.findViewById<MapView>(R.id.map_kakao)
        mapView.start(object : MapLifeCycleCallback() {
            override fun onMapDestroy() {
                // 지도 API 가 정상적으로 종료될 때 호출됨
            }

            override fun onMapError(error: Exception) {
                // 인증 실패 및 지도 사용 중 에러가 발생할 때 호출됨
            }
        }, object : KakaoMapReadyCallback() {
            override fun onMapReady(kakaoMap: KakaoMap) {
                // 인증 후 API 가 정상적으로 실행될 때 호출됨
            }
        })

        return nativeView
    }

    override fun dispose() {}
}