package com.k1a2.dravel

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.util.DisplayMetrics
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
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelStyle
import com.kakao.vectormap.label.LabelStyles
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
    private val context: Context

    private val creationParams: Map<String?, Any?>?

    private var labelStyles: LabelStyles? = null;

    init {
        val inflater = LayoutInflater.from(context)
        this.context = context
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

                val labelManager: LabelManager = kakaoMap!!.labelManager!!

                // 라벨 사진 로드
                var bitmap = BitmapFactory.decodeResource(context.resources, R.drawable.spot_pin)
                // 라벨 크기 화면에 맞게 조정
                bitmap = Bitmap.createScaledBitmap(bitmap, dpToPx(18), dpToPx(18), true)

                // 라벨 스타일 지정
                labelStyles = labelManager.addLabelStyles(
                    LabelStyles.from(
                        LabelStyle.from(bitmap)
                            .setTextStyles(dpToPx(12), Color.BLACK)
                            .setApplyDpScale(false),
                    ),
                )

                moveCamera(
                    creationParams!!["lat"].toString().toDouble(),
                    creationParams!!["lon"].toString().toDouble(),
                    creationParams!!["zoomLevel"].toString().toInt()
                )

                val initData = creationParams!!["initData"] as List<Map<String, Any>>
                if (initData.isNotEmpty()) {
                    for (data in initData) {
                        val location = data["location"] as Map<String, Double>
                        addSpotLabel(
                            data["name"]!!.toString(),
                            location["lat"]!!,
                            location["lon"]!!,
                            data["id"] as Int,
                        )
                    }
                }
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

    private fun dpToPx(dp: Int): Int {
        val displayMetrics: DisplayMetrics = this.context.resources.displayMetrics
        return (dp * displayMetrics.density).toInt()
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

    private fun addSpotLabel(
        name: String,
        lat: Double,
        lng: Double,
        id: Int
    ) {
        // 라벨 옵션 지정
        val options = LabelOptions.from(LatLng.from(lat, lng))
            .setStyles(labelStyles)
            .setClickable(true)
            .setTexts(name)
            .setTag(id)

        // 라벨 추가
        val layer = kakaoMap!!.labelManager!!.layer
        layer!!.addLabel(options)
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
            "addSpotLabel" -> {
                val lat = call.argument<Double>("lat")
                val lon = call.argument<Double>("lon")
                val name = call.argument<String>("name")
                val id = call.argument<Int>("id")
                try {
                    addSpotLabel(name!!, lat!!, lon!!, id!!)
                } catch (e: Exception) {
                    result.error(
                        "110",
                        "METHOD ERROR",
                        "add spot label error occur")
                }
            }
        }
    }
}