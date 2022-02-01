package com.tpl.tplmapsflutter

import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.RelativeLayout
import androidx.appcompat.app.AppCompatActivity
import com.tplmaps3d.MapController
import com.tplmaps3d.MapView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.tpl.tplmapsflutter.tplmapsflutterplugin.R
import com.tplmaps3d.CameraPosition
import io.flutter.embedding.android.FlutterActivity
import com.tplmaps3d.LngLat


class TPLMapView internal constructor(context: Context?, id: Int) : PlatformView,

    MethodChannel.MethodCallHandler, AppCompatActivity(), MapView.OnMapReadyCallback {
    private var mapViw: View
    private lateinit var map: MapView
    private lateinit var mMapController: MapController


    override fun getView(): View {
        return mapViw;
    }

    init {
        mapViw = LayoutInflater.from(context).inflate(R.layout.activity_main, null)

//        val mapFragment = mapViw.findViewById(R.id.course3DViewer) as com.google.android.gms.maps.MapView
//        mapFragment.getMapAsync(this)


//        val mapFragment = mapViw.findViewById<SupportMapFragment>(R.id.course3DViewer) as SupportMapFragment
//        mapFragment.getMapAsync(this)

        // MapsInitializer.initialize(this)

        map = mapViw.findViewById(R.id.tplmap)
        map.loadMapAsync(this);
    }


    override fun dispose() {
        print("dispose")
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "loadUrl" -> print("hahahha")
            else -> result.notImplemented()
        }
    }

    override fun onMapReady(mapController: MapController?) {
        mMapController = mapController!!

        val islamabad = LngLat(73.093104, 33.730494)
        mapController.addMarker(com.tplmaps3d.MarkerOptions().position(islamabad).title("Islamabad"))

        map.getMapController().animateCamera(CameraPosition.fromLngLatZoom(mapController, islamabad, 8.0F), 0)
    }


}