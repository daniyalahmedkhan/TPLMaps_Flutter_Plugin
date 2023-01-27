package com.tpl.tplmapsflutter.tplmapsflutterplugin

import androidx.annotation.NonNull
import com.tpl.tplmapsflutter.TPLMapViewFactory
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TplmapsflutterpluginPlugin */
class TplmapsflutterpluginPlugin : FlutterPlugin, MethodCallHandler, FlutterActivity(), ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var binaryMessenger: BinaryMessenger? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//       channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tplmapsflutterplugin")
//        channel.setMethodCallHandler(this)
        binaryMessenger = flutterPluginBinding.binaryMessenger

        flutterPluginBinding
            .getPlatformViewRegistry()
            .registerViewFactory("map", TPLMapViewFactory(flutterPluginBinding.binaryMessenger))
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }
//
    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    println("**************************************1")
       // channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Constants.contextObj.activity = binding.activity
        println("**************************************2 --1")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        println("**************************************3")    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        println("**************************************4")    }

    override fun onDetachedFromActivity() {
        println("**************************************5")    }


}

//object TplmapsflutterpluginPlugin {
//    fun registerWith(registrar: Registrar) {
//        registrar
//            .platformViewRegistry()
//            .registerViewFactory(
//                "map", TPLMapViewFactory())
//    }
//}
