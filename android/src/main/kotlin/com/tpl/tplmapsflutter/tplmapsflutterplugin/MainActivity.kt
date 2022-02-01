package com.tpl.tplmapsflutter

import android.app.Activity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.os.Bundle
import android.widget.FrameLayout
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.view.LayoutInflater
import android.view.View
import androidx.appcompat.app.AppCompatActivity

import com.tplmaps3d.MapController
import com.tplmaps3d.MapView


class MainActivity : FlutterActivity()  {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("map", TPLMapViewFactory())
    }


}
