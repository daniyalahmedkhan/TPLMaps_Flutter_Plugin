package com.tpl.tplmapsflutter
//1、BasicMessageChannel：use this to pass string or other object.
//
//2、MethodChannel：use this to method invocation
//
//3、EventChannel: use this to event streams
import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.RelativeLayout
import androidx.appcompat.app.AppCompatActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import android.widget.TextView
import androidx.annotation.NonNull
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.tpl.tplmapsflutter.tplmapsflutterplugin.R
import com.tplmaps3d.*
import io.flutter.embedding.android.FlutterActivity
import com.tplmaps3d.sdk.location.TPLLocationListener
import io.flutter.plugin.common.EventChannel
import java.util.logging.StreamHandler


class TPLMapView internal constructor(context: Context?, id: Int, messenger: BinaryMessenger) : PlatformView,

    MethodChannel.MethodCallHandler, AppCompatActivity(), MapView.OnMapReadyCallback{
    private var mapViw: View
    private lateinit var map: MapView
    private lateinit var mMapController: MapController
    private lateinit var channel: MethodChannel
    private var eventSink: EventChannel.EventSink? = null
//    private lateinit var methodCall: MethodCall
//    private lateinit var methodCallResult: MethodChannel.Result


    override fun getView(): View {
        return mapViw;
    }

    init {
        channel = MethodChannel(messenger, "plugins/map")
        channel.setMethodCallHandler(this)
        mapViw = LayoutInflater.from(context).inflate(R.layout.activity_main, null)
        //MapsInitializer.initialize(this)
        map = mapViw.findViewById(R.id.tplmap)
        map.loadMapAsync(this);
    }


    override fun dispose() {
        print("dispose")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setCameraPositionAnimated" -> {
                var long : Double = call.argument<Double>("longitude") ?: 0.0
                var lat: Double = call.argument<Double>("latitude") ?: 0.0
                var zoom: Double = call.argument<Double>("zoom") ?: 0.0
                setCameraPositionAnimated(map, lat, long, zoom)
            }
            "addMarker" -> {
                var long : Double = call.argument<Double>("longitude") ?: 0.0
                var lat: Double = call.argument<Double>("latitude") ?: 0.0
                addMarker(map, lat, long)
            }
            "setZoomEnabled" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false
                setZoomEnabled(map, isEnable)
            }
            "marker" -> {

            }
            else -> result.notImplemented()
        }
    }

    fun setCameraPositionAnimated(map: MapView, latitude: Double, longitude: Double, zoom: Double){
        val coord = LngLat(longitude, latitude)
        map.mapController.animateCamera(CameraPosition.fromLngLatZoom(mMapController, coord,
            zoom.toFloat()
        ), 0)
    }

    fun addMarker(map: MapView, latitude: Double, longitude: Double){
        val coord = LngLat(longitude, latitude)
        map.mapController.addMarker(com.tplmaps3d.MarkerOptions().position(coord).title("Islamabad"))
    }
    fun setZoomEnabled(map: MapView, isEnable: Boolean){}

    private fun mapReady(){
        channel.invokeMethod("onMapReady", true)
    }

    override fun onMapReady
                (mapController: MapController?) {
        mMapController = mapController!!
        mapReady()
//        val islamabad = LngLat(73.093104, 33.730494)
//        mapController.addMarker(com.tplmaps3d.MarkerOptions().position(islamabad).title("Islamabad"))
//        map.getMapController().animateCamera(CameraPosition.fromLngLatZoom(mapController, islamabad, 12.0F), 0)
    }


}


