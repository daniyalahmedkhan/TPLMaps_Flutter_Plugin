package com.tpl.tplmapsflutter

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry.Registrar

object TPLMapViewPlugin {
    fun registerWith(registrar: Registrar) {
        registrar
            .platformViewRegistry()
            .registerViewFactory(
                "map", TPLMapViewFactory())
    }
}