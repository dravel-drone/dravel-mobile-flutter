package com.k1a2.dravel

import android.content.Context
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
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.platform.PlatformView


class KakaoMapActivity(context: Context, creationParams: Map<String?, Any?>?) : PlatformView, DefaultLifecycleObserver {
    private val nativeView: View?
    private var mapView: MapView? = null
    private var kakaoMap: KakaoMap? = null

    private val creationParams: Map<String?, Any?>?

    init {
        val inflater = LayoutInflater.from(context)
        nativeView = inflater.inflate(R.layout.layout_kakao_map, null)
        this.creationParams = creationParams
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
                val cameraPos: CameraPosition = CameraPosition.from(
                    CameraPosition.Builder()
                        .setZoomLevel(creationParams!!["zoomLevel"].toString().toInt())
                        .setPosition(LatLng.from(
                            creationParams!!["lat"].toString().toDouble(),
                            creationParams!!["lon"].toString().toDouble()))
                )
                kakaoMap!!.moveCamera(CameraUpdateFactory.newCameraPosition(cameraPos))
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
}