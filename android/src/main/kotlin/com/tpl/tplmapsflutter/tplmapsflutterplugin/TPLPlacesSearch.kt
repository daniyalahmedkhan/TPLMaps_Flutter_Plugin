package com.tpl.tplmapsflutter.tplmapsflutterplugin

import android.content.Context
import com.google.gson.Gson
import com.tplmaps.sdk.places.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception
import java.util.ArrayList

class TPLPlacesSearch internal constructor(context: Context?, id: Int, messenger: BinaryMessenger, params: Any?)  :
   FlutterActivity(), FlutterPlugin, MethodChannel.MethodCallHandler , OnSearchResult , ActivityAware{

    private var binaryMessenger: BinaryMessenger? = null
    private var channel: MethodChannel


    init {
        channel = MethodChannel(messenger, "plugins/search")
        channel.setMethodCallHandler(this)

    }

   private fun searchQuery(query: String , lat: Double , lng: Double){

        val searchManager =  SearchManager(Constants.contextObj.activity)
        searchManager.onCreate();

        val position = LngLat(lng, lat)

        // Request for query after initializing SearchManager
        // put your query string with location to get your nearer results first
        searchManager.request(
            Params.builder()
                .query(query)
                .location(position) // Default location of Islamabad
                .build(), this
        )
    }

    private fun reverseSearchQuery(lat: Double , lng: Double){

        val searchManager =  SearchManager(Constants.contextObj.activity)
        searchManager.onCreate();

        val position = LngLat(lng, lat)

        // Request for query after initializing SearchManager
        // put your query string with location to get your nearer results first
        searchManager.requestReverse(
            Params.builder()
                .location(position) // Default location of Islamabad
                .build(), this
        )
    }

    override fun onSearchResult(results: ArrayList<Place>?) {
        val jsonString = Gson().toJson(results)

        channel.invokeMethod("searchManagerResult" , jsonString.toString())
    }

    override fun onSearchResultNotFound(params: Params?, requestTimeInMS: Long) {
        print("failed")
    }

    override fun onSearchRequestFailure(e: Exception?) {
        print("failed")
    }

    override fun onSearchRequestCancel(params: Params?, requestTimeInMS: Long) {
        print("failed")
    }

    override fun onSearchRequestSuspended(
        errorMessage: String?,
        params: Params?,
        requestTimeInMS: Long
    ) {
        TODO("Not yet implemented")
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {

        println("**************************************2 --4 ")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        println("**************************************3")    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        println("**************************************4")    }

    override fun onDetachedFromActivity() {
        println("**************************************5")    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binaryMessenger = binding.binaryMessenger
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "searchManager" -> {
                val query : String = call.argument<String>("query") ?: ""
                val lat : Double = call.argument<Double>("lat") ?: 0.0
                val lng : Double = call.argument<Double>("lng") ?: 0.0
                searchQuery(query , lat , lng)
            }
            "reverseSearchManager" -> {
                val lat : Double = call.argument<Double>("lat") ?: 0.0
                val lng : Double = call.argument<Double>("lng") ?: 0.0
                reverseSearchQuery(lat , lng)
            }

        }
    }


}