package com.tpl.tplmapsflutter


import android.content.Context
import com.tpl.tplmapsflutter.tplmapsflutterplugin.TPLPlacesSearch
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TPLMapViewFactory internal constructor(messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private var bMessenger: BinaryMessenger = messenger

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params: Object? = args as? Object
        val tplPlacesSearch = TPLPlacesSearch(context, viewId, bMessenger, args)
       // val tplRoutingPlaces = TPLRouting(context, viewId, bMessenger, args)
        return TPLMapView(context, viewId, bMessenger, args)
    }
}