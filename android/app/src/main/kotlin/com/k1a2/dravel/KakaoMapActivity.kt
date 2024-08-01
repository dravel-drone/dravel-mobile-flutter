package com.k1a2.dravel

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdateFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView


class KakaoMapActivity(
    context: Context,
    creationParams: Map<String?, Any?>?,
    messenger: BinaryMessenger,
    id: Int,
) : PlatformView, DefaultLifecycleObserver, MethodCallHandler {
    private val methodChannel: MethodChannel = MethodChannel(messenger, "map-kakao/$id")

    private val nativeView: View?
    private var mapView: MapView? = null
    private var kakaoMap: KakaoMap? = null

    private val creationParams: Map<String?, Any?>?

    init {
        val inflater = LayoutInflater.from(context)
        nativeView = inflater.inflate(R.layout.layout_kakao_map, null)
        this.creationParams = creationParams
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View? {
        if (nativeView == null) return null

        mapView = nativeView.findViewById<MapView>(R.id.map_kakao)
        mapView!!.start(object : MapLifeCycleCallback() {
            override fun onMapDestroy() {
                // 지도 API 가 정상적으로 종료될 때 호출됨
            }

            override fun onMapError(error: Exception) {
                // 인증 실패 및 지도 사용 중 에러가 발생할 때 호출됨
            }
        }, object : KakaoMapReadyCallback() {
            override fun onMapReady(map: KakaoMap) {
                kakaoMap = map
                moveCamera(
                    creationParams!!["lat"].toString().toDouble(),
                    creationParams!!["lon"].toString().toDouble(),
                    creationParams!!["zoomLevel"].toString().toInt()
                )
            }
        })

        return nativeView
    }

    override fun dispose() {}

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)
        if (mapView != null) {
            mapView!!.resume()
        }
    }

    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)
        if (mapView != null) {
            mapView!!.pause()
        }
    }

    private fun moveCamera(
        lat: Double,
        lon: Double,
        zoomLevel: Int
    ) {
        val cameraPos: CameraPosition = CameraPosition.from(
            CameraPosition.Builder()
                .setZoomLevel(zoomLevel)
                .setPosition(LatLng.from(lat, lon))
        )
        kakaoMap!!.moveCamera(CameraUpdateFactory.newCameraPosition(cameraPos))
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "moveCamera" -> {
                val lat = call.argument<Double>("lat")
                val lon = call.argument<Double>("lon")
                val zoomLevel = call.argument<Int>("zoomLevel")
                try {
                    moveCamera(lat!!, lon!!, zoomLevel!!)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(
                        "100",
                        "METHOD ERROR",
                        "moveCamera error occur")
                }
            }
        }
    }
}