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
import com.kakao.vectormap.GestureType
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.KakaoMap.OnCameraMoveEndListener
import com.kakao.vectormap.KakaoMap.OnLabelClickListener
import com.kakao.vectormap.KakaoMapReadyCallback
import com.kakao.vectormap.LatLng
import com.kakao.vectormap.MapLifeCycleCallback
import com.kakao.vectormap.MapView
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraUpdateFactory
import com.kakao.vectormap.label.Label
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelStyle
import com.kakao.vectormap.label.LabelStyles
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
    private var labelStyles: LabelStyles? = null
    private var prevCameraPos: CameraPosition? = null

    init {
        methodChannel.setMethodCallHandler(this)
        val inflater = LayoutInflater.from(context)
        this.context = context
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
                Log.d("Map Callback", "error ${error.message.toString()}")
                error.printStackTrace()
            }
        }, object : KakaoMapReadyCallback() {
            override fun onMapReady(map: KakaoMap) {
                kakaoMap = map
                Log.d("Map Callback", "ready")

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


                if (prevCameraPos == null) {
                    moveCamera(
                        creationParams!!["lat"].toString().toDouble(),
                        creationParams!!["lon"].toString().toDouble(),
                        creationParams!!["zoomLevel"].toString().toInt()
                    )
                } else {
                    kakaoMap!!.moveCamera(CameraUpdateFactory.newCameraPosition(prevCameraPos!!))
                }

//                val initData = creationParams!!["initData"] as List<Map<String, Any>>
//                if (initData.isNotEmpty()) {
//                    for (data in initData) {
//                        val location = data["location"] as Map<String, Double>
//                        addSpotLabel(
//                            data["name"]!!.toString(),
//                            location["lat"]!!,
//                            location["lon"]!!,
//                            data["id"] as Int,
//                        )
//                    }
//                }

                kakaoMap!!.setOnLabelClickListener { p0, p1, p2 ->
                    val tagId = p2!!.tag as Int
                    Log.d("Tag Clicked", "$tagId")
                    methodChannel.invokeMethod("onLabelTabbed", mapOf<String, Any>("id" to tagId))
                    true
                }

                kakaoMap!!.setOnCameraMoveEndListener(object : OnCameraMoveEndListener {
                    override fun onCameraMoveEnd(
                        p0: KakaoMap,
                        p1: CameraPosition,
                        p2: GestureType
                    ) {
                        prevCameraPos = p1
                    }
                })

                methodChannel.invokeMethod("onMapInit", null)
            }
        })

        return nativeView
    }

    override fun dispose() {}

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)
        Log.d("Cycle", "resume")
        if (mapView != null) {
            mapView!!.resume()
        }
    }

    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)
        Log.d("Cycle", "pause")
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

    private fun removeAllSpotLabel() {
        print("deleted1")
        val layer = kakaoMap!!.labelManager!!.layer
        layer!!.removeAll()
        print("deleted2")
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
            "removeAllSpotLabel" -> {
                removeAllSpotLabel()
            }
            "setLabels" -> {
                val data: List<Map<String, Any>>? = call.argument<List<Map<String, Any>>>("labels")
                Log.d("label", data.toString())

                if (data == null) {
                    result.error(
                        "121",
                        "METHOD ERROR",
                        "data null error occur")
                    return
                }

                try {
                    removeAllSpotLabel()
                    data.forEach { item ->
                        val name = item["name"] as? String ?: "Unknown"
                        val lon = item["lon"] as? Double ?: 0.0
                        val lat = item["lat"] as? Double ?: 0.0
                        val id = item["id"] as? Int ?: 0

                        addSpotLabel(name, lat, lon, id)
                    }
                    result.success(null)
                } catch (e: Exception) {
                    result.error(
                        "120",
                        "METHOD ERROR",
                        "setLabels error occur")
                }
            }
        }
    }
}