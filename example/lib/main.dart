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

late TplMapsViewController _controller;

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
      tPlMapsViewMarkerCallBack: _markerCallback,
    );

  }

  void _markerCallback(String callback){

    log(callback);

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

     _controller = controller;

  }

  void addPolyline(){
    _controller.addPolyLine(23.23 , 23.23 , 23.23 , 123.123);
  }

  void addCircle(){
    _controller.addCircle(23.23 , 23.23 , 23.23 ,);
  }

  void removePolyLine(){
    _controller.removePolyline();
  }

  void removeCircles(){
    _controller.removeAllCircles();
  }

  // void markerClickHandler(){
  //
  //   TplMarkerClickHandler tplMarkerClickHandler = TplMarkerClickHandler((poiDetails) {
  //
  //       log(poiDetails);
  //   });
  //
  // }

}

