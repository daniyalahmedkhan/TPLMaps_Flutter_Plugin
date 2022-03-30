package com.tpl.tplmapsflutter
//1、BasicMessageChannel：use this to pass string or other object.
//
//2、MethodChannel：use this to method invocation
//
//3、EventChannel: use this to event streams
import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import com.tpl.tplmapsflutter.tplmapsflutterplugin.R
import com.tplmaps3d.*
import io.flutter.plugin.common.EventChannel
import com.google.android.material.floatingactionbutton.ExtendedFloatingActionButton
import java.util.concurrent.Future


class TPLMapView internal constructor(context: Context?, id: Int, messenger: BinaryMessenger, params: Any?) : PlatformView,

    MethodChannel.MethodCallHandler, AppCompatActivity(), MapView.OnMapReadyCallback{
    private var mapViw: View
    private lateinit var map: MapView
    private lateinit var myLocBtn: ExtendedFloatingActionButton
    private lateinit var mMapController: MapController
    private lateinit var mUiSettings: UISettings
    private var channel: MethodChannel
    private var args: HashMap<String?, Any?>? = null
//    private lateinit var methodCall: MethodCall
//    private lateinit var methodCallResult: MethodChannel.Result


    override fun getView(): View {
        return mapViw;
    }

    init {
        channel = MethodChannel(messenger, "plugins/map")
        channel.setMethodCallHandler(this)
        mapViw = LayoutInflater.from(context).inflate(R.layout.activity_main, null)

        map = mapViw.findViewById(R.id.tplmap)
        args = params as HashMap<String?, Any?>?
        //var keys: MutableSet<String?> = args!!.keys
        var isTrafficEnabled : Boolean = args?.get("isTrafficEnabled") as Boolean
        var isShowBuildings: Boolean = args?.get("isShowBuildings") as Boolean
        var mapMode = args?.get("mapMode")
        var enablePOIs = args?.get("enablePOIs") as Boolean

        map.setTrafficEnabled(isTrafficEnabled);
        map.setBuildingsEnabled(isShowBuildings);
        map.setPOIsEnabled(enablePOIs)
        if(mapMode == 1){
            map.mapMode = MapMode.DEFAULT
        }
        else{
            map.mapMode = MapMode.NIGHT
        }
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
            "showBuildings" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                showBuildings(map, isEnable)
            }
            "showZoomControls" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                showZoomControls(map, isEnable)
            }
            "setTrafficEnabled" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                setTrafficEnabled(map, isEnable)
            }
            "showZoomControls" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                showZoomControls(map, isEnable)
            }
            "enablePOIs" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                enablePOIs(map, isEnable)
            }
            "showsCompass" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                showsCompass(map, isEnable)
            }
            "allGesturesEnabled" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                allGesturesEnabled(map, isEnable)
            }
            "myLocationButtonEnabled" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                myLocationButtonEnabled(map, isEnable)
            }
            "setMyLocationEnabled" -> {
                var isEnable: Boolean = call.argument<Boolean>("isEnable") ?: false

                setMyLocationEnabled(map, isEnable)
            }
            "setMapMode" -> {
                var value: Int = call.argument<Int>("mapMode") ?: 1
                var mapMode: MapMode;
                if(value == 1){
                    mapMode = MapMode.DEFAULT
                }
                else{
                    mapMode = MapMode.NIGHT
                }
                setMapMode(map, mapMode)
            }
            else -> result.notImplemented()
        }
    }

    private fun setCameraPositionAnimated(map: MapView, latitude: Double, longitude: Double, zoom: Double){
        val coord = LngLat(longitude, latitude)
        map.mapController.animateCamera(CameraPosition.fromLngLatZoom(mMapController, coord,
            zoom.toFloat()
        ), 0)
    }

    private fun addMarker(map: MapView, latitude: Double, longitude: Double){
        val coord = LngLat(longitude, latitude)
        map.mapController.addMarker(com.tplmaps3d.MarkerOptions().position(coord).title("Islamabad"))
    }
    fun setZoomEnabled(map: MapView, isEnable: Boolean){
        map.mapController.uiSettings.setDoubleTapZoomInGestureEnabled(isEnable);
    }

    private fun showBuildings(map: MapView, isEnable: Boolean){
        map.setBuildingsEnabled(isEnable);
        channel.invokeMethod("setBuildingsEnabled", map.isBuildingEnabled)
    }

    private fun showZoomControls(map: MapView, isEnable: Boolean){
        map.mapController.uiSettings.showZoomControls(isEnable);
    }

    private fun setTrafficEnabled(map: MapView, isEnable: Boolean){
        map.isTrafficEnabled = isEnable;
    }

    private fun enablePOIs(map: MapView, isEnable: Boolean){
        map.isPOIsEnabled = isEnable;
    }

    private fun showsCompass(map: MapView, isEnable: Boolean){
        map.mapController.uiSettings.showCompass(isEnable);
    }

    private fun allGesturesEnabled(map: MapView, isEnable: Boolean){
        map.mapController.uiSettings.isAllMapGesturesEnabled = isEnable;
    }

    private fun myLocationButtonEnabled(map: MapView, isEnable: Boolean){
        map.mapController.uiSettings.showMyLocationButton(isEnable);
    }

    private fun setMyLocationEnabled(map: MapView, isEnable: Boolean){
        map.mapController.setMyLocationEnabled(isEnable);
    }
    private fun setMapMode(map: MapView, mapMode: MapMode){
        map.mapMode = mapMode
    }


    private fun mapReady(){
        channel.invokeMethod("onMapReady", true)
    }


    override fun onMapReady
                (mapController: MapController?) {
        mMapController = mapController!!
        mUiSettings = mapController.uiSettings
        var isZoomEnabled: Boolean = args?.get("isZoomEnabled") as Boolean
        var showsCompass = args?.get("showsCompass") as Boolean
        var showZoomControls: Boolean = args?.get("showZoomControls") as Boolean
        var myLocationButtonEnabled = args?.get("myLocationButtonEnabled") as Boolean
        var allGesturesEnabled = args?.get("allGesturesEnabled") as Boolean
        var setMyLocationEnabled = args?.get("setMyLocationEnabled") as Boolean
        mUiSettings.showCompass(showsCompass)
        mUiSettings.showZoomControls(showZoomControls)
        mUiSettings.isAllMapGesturesEnabled = allGesturesEnabled
        mMapController.setMyLocationEnabled(setMyLocationEnabled)
        mUiSettings.showMyLocationButton(myLocationButtonEnabled)

        mMapController.setOnPoiClickListener {
            channel.invokeMethod("onPoiClickListener", map.isBuildingEnabled)
        }
        mapReady()
 //       val islamabad = LngLat(73.093104, 33.730494)
//        mapController.addMarker(com.tplmaps3d.MarkerOptions().position(islamabad).title("Islamabad"))
//        map.getMapController().animateCamera(CameraPosition.fromLngLatZoom(mapController, islamabad, 12.0F), 0)
    }


}


