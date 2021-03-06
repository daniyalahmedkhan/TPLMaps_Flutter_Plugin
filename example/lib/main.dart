import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';
import 'package:tplmapsflutterplugin/tplmapsflutterplugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'map';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};


    return TplMapsView(
      isShowBuildings: true,
      isZoomEnabled: true,
      showZoomControls: true,
      isTrafficEnabled: true,
      mapMode: MapMode.DEFAULT,
      enablePOIs: true,
      setMyLocationEnabled: false,
      myLocationButtonEnabled: false,
      showsCompass: true,
      allGesturesEnabled: true,
      tplMapsViewCreatedCallback: _callback,
    );
    // switch (defaultTargetPlatform) {
    //   case TargetPlatform.android:
    //   // return widget on Android.
    //
    //   case TargetPlatform.iOS:
    //   // return widget on iOS.
    //   default:
    //     throw UnsupportedError('Unsupported platform view');
    // }

    // return TplMapsView(
    //   tplMapsViewCreatedCallback: _callback,
    // );
    // return PlatformViewLink(
    //   viewType: viewType,
    //   surfaceFactory:
    //       (BuildContext context, PlatformViewController controller) {
    //     return AndroidViewSurface(
    //       controller: controller as AndroidViewController,
    //       gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
    //       hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    //     );
    //   },
    //   onCreatePlatformView: (PlatformViewCreationParams params) {
    //     return PlatformViewsService.initSurfaceAndroidView(
    //       id: params.id,
    //       viewType: viewType,
    //       layoutDirection: TextDirection.ltr,
    //       creationParams: creationParams,
    //       creationParamsCodec: const StandardMessageCodec(),
    //       onFocus: () {
    //         params.onFocusChanged(true);
    //       },
    //     )
    //       ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
    //       ..create();
    //   },
    // );

  }

  void _callback(TplMapsViewController controller) {
    //controller.setZoomEnabled(true);
    //controller.showBuildings(false);
     controller.showBuildings(false);
    // controller.setZoomEnabled(false);
     controller.showZoomControls(false);
     controller.setTrafficEnabled(false);
     controller.enablePOIs(true);
     controller.setMyLocationEnabled(true);
     controller.myLocationButtonEnabled(true);
     controller.showsCompass(false);

     controller.setCameraPositionAnimated(33.698047971892045, 73.06930062598059, 14.0);
     controller.addMarker(33.705349, 73.069788);
     controller.addMarker(33.698047971892045, 73.06930062598059);
    // controller.allGesturesEnabled(false);
     controller.setMapMode(MapMode.DEFAULT);
    bool isBuildingsEnabled = controller.isBuildingEnabled;
    print("isBuildingsEnabled: $isBuildingsEnabled");
    bool isTrafficEnabled = controller.isTrafficEnabled;
    print("isTrafficEnabled: $isTrafficEnabled");
    bool isPOIsEnabled = controller.isPOIsEnabled;
    print("isPOIsEnabled: $isPOIsEnabled");
    //mapMode: MapMode.DEFAULT,
  }
}
