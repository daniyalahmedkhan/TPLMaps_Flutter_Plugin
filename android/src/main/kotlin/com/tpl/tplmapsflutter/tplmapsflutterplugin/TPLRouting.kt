//package com.tpl.tplmapsflutter.tplmapsflutterplugin
//
//import android.content.Context
//import com.google.gson.Gson
//import com.tpl.maps.sdk.routing.IMapRoute
//import com.tpl.maps.sdk.routing.LngLat
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.plugin.common.BinaryMessenger
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import com.tpl.maps.sdk.routing.TPLRouteManager
//import com.tpl.maps.sdk.routing.structures.Place
//import com.tpl.maps.sdk.routing.TPLRouteConfig
//import java.util.ArrayList
//
//
//class TPLRouting internal constructor(context: Context?, id: Int, messenger: BinaryMessenger, params: Any?)  :
//    FlutterActivity(), FlutterPlugin, MethodChannel.MethodCallHandler{
//
//    private var channel: MethodChannel
//    private var mRouteManager: TPLRouteManager? = null
//
//    init {
//        channel = MethodChannel(messenger, "plugins/route")
//        channel.setMethodCallHandler(this)
//
//        // Initiating TPLRouteManager instance
//
//        // Initiating TPLRouteManager instance
//        mRouteManager = TPLRouteManager()
//        mRouteManager!!.onCreate(Constants.contextObj.activity)
//    }
//
//    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        when(call.method){
//            "routing" -> {
//                val startLat : Double = call.argument<Double>("startLat") ?: 0.0
//                val startLng : Double = call.argument<Double>("startLng") ?: 0.0
//                val desLat : Double = call.argument<Double>("desLat") ?: 0.0
//                val desLng : Double = call.argument<Double>("desLng") ?: 0.0
//
//                calculateRoute(startLat, startLng , desLat , desLng)
//
//            }
//        }
//    }
//
//    fun calculateRoute(startLat: Double, startLng: Double , desLat: Double , desLng: Double){
//
//        val location = ArrayList<Place>()
//
//        val sourcePlace = Place()
//        sourcePlace.name = "Source"
//        sourcePlace.x = startLng
//        sourcePlace.y = startLat
//
//        val destPlace = Place()
//        destPlace.name = "Destination"
//        destPlace.x = desLng
//        destPlace.y = desLat
//
//        location.add(sourcePlace)
//        location.add(destPlace)
//
//
//        val config = TPLRouteConfig.Builder()
//            .reRoute(false)
//            .endPoints(location)
//            .heading(90)
//            .build()
//
//        val listNodes: List<LngLat> = ArrayList()
//
//        mRouteManager?.calculate(Constants.contextObj.activity, config , IMapRoute { endPoints, routes ->
//
//            for(i in routes.iterator()){
//
//                val tplroute = i.routeNodes
//                val lnglats = arrayOfNulls<LngLat>(i.getRouteNodes().size)
//
//                for (j in 0 until i.getRouteNodes().size) {
//                    val lngLat: LngLat = i.getRouteNodes().get(j)
//                    lnglats[j] = LngLat(lngLat.longitude, lngLat.latitude)
//                }
//
//                val jsonString = Gson().toJson(lnglats)
//                channel.invokeMethod("routingResult" , jsonString)
//
//            }
//
//        })
//
//    }
//}