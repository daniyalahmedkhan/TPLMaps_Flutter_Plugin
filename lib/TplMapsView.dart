import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

typedef TplMapsViewCreatedCallback = void Function(TplMapsViewController controller);

class MapMode {
  static const DEFAULT = 1;
  static const NIGHT = 2;
}

class TplMapsView extends StatefulWidget {
  final TplMapsViewCreatedCallback? tplMapsViewCreatedCallback;
  final isZoomEnabled;
  final isShowBuildings;
  final showZoomControls;
  final isTrafficEnabled;
  final mapMode;
  final enablePOIs;
  final showsCompass;
  final myLocationButtonEnabled;
  final allGesturesEnabled;
  final setMyLocationEnabled;
  const TplMapsView({
    Key? key,
    this.tplMapsViewCreatedCallback,
    this.isShowBuildings = false,
    this.isZoomEnabled = true,
    this.showZoomControls = false,
    this.isTrafficEnabled = false,
    this.enablePOIs = true,
    this.showsCompass = true,
    this.myLocationButtonEnabled = true,
    this.allGesturesEnabled = true,
    this.setMyLocationEnabled = false,
    this.mapMode
  }) : super(key: key);



  @override
  State<StatefulWidget> createState() => _TplMapsViewState();

}

class _TplMapsViewState extends State<TplMapsView>{
  late final MethodChannel mChannel = MethodChannel('plugins/map');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mChannel.setMethodCallHandler(this.nativeMethodHandler);
  }

  Future<void> nativeMethodHandler(MethodCall call) async{
    print("handler called");
    switch(call.method){
      case "onMapReady":
        TplMapsViewController controller = TplMapsViewController._(call.hashCode);
        controller.isBuildingEnabled = widget.isShowBuildings;
        controller.isTrafficEnabled = widget.isTrafficEnabled;
        controller.isPOIsEnabled = widget.enablePOIs;
        widget.tplMapsViewCreatedCallback!(controller);
        break;
      case "onPoiClickListener":
        print("On Poi Click Listener");
    }
  }
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // This is used in the platform side to register the view.
      const String viewType = 'map';
      // Pass parameters to the platform side.
      Map<String, dynamic> creationParams = <String, dynamic>{
        "isZoomEnabled" : widget.isZoomEnabled,
        "isShowBuildings" : widget.isShowBuildings,
        "showZoomControls" : widget.showZoomControls,
        "isTrafficEnabled" : widget.isTrafficEnabled,
        "mapMode" : widget.mapMode,
        "enablePOIs" : widget.enablePOIs,
        "showsCompass" : widget.showsCompass,
        "allGesturesEnabled": widget.allGesturesEnabled,
        "myLocationButtonEnabled": widget.myLocationButtonEnabled,
        "setMyLocationEnabled" : widget.setMyLocationEnabled
      };
      return PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (BuildContext context, PlatformViewController controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS){
      const String viewType = 'map';
      Map<String, dynamic> creationParams = <String, dynamic>{
        "isZoomEnabled" : widget.isZoomEnabled,
        "isShowBuildings" : widget.isShowBuildings,
        "showZoomControls" : widget.showZoomControls,
        "isTrafficEnabled" : widget.isTrafficEnabled,
        "mapMode" : widget.mapMode,
        "enablePOIs" : widget.enablePOIs,
        "showsCompass" : widget.showsCompass,
        "allGesturesEnabled": widget.allGesturesEnabled,
        "myLocationButtonEnabled": widget.myLocationButtonEnabled,
        "setMyLocationEnabled" : widget.setMyLocationEnabled,
      };
      print("ios params: $creationParams");
      return UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return const Text('web platform version is not implemented yet.');
  }

  void _onPlatformViewCreated(int id) {
    print("callback called");
    if (widget.tplMapsViewCreatedCallback == null) {
      return;
    }
    TplMapsViewController controller = TplMapsViewController._(id);
    controller.isBuildingEnabled = widget.isShowBuildings;
    controller.isTrafficEnabled = widget.isTrafficEnabled;
    controller.isPOIsEnabled = widget.enablePOIs;
    widget.tplMapsViewCreatedCallback!(controller);
  }
}

class TplMapsViewController {
  TplMapsViewController._(int id)
      : _channel = MethodChannel('plugins/map');
  final MethodChannel _channel;
  bool isBuildingEnabled = false;
  bool isTrafficEnabled = false;
  bool isPOIsEnabled = false;
  Future<void> setCameraPositionAnimated(double latitude,double longitude, double zoom) async {
    print("camera animated called");
    return _channel.invokeMethod('setCameraPositionAnimated', {'latitude': latitude,'longitude':longitude, 'zoom':zoom});
  }

  Future<void> addMarker(double latitude,double longitude) async {
    return _channel.invokeMethod('addMarker', {'latitude': latitude,'longitude':longitude});
  }

  Future<void> draggable(bool value) async {
    return _channel.invokeMethod('draggable',{'isEnable': value});
  }

  Future<void> animateToZoom(double value) async {
    return _channel.invokeMethod('animateToZoom', {'isEnable': value});
  }
  Future<void> setZoomEnabled(bool isEnable) async {
    return _channel.invokeMethod('setZoomEnabled', {'isEnable': isEnable});
  }

  Future<void> showBuildings(bool value) async {
    isBuildingEnabled = value;
    return _channel.invokeMethod('showBuildings', {'isEnable': value});
  }

  Future<void> showZoomControls(bool value) async {
    return _channel.invokeMethod('showZoomControls', {'isEnable': value});
  }

  Future<void> setTrafficEnabled(bool value) async {
    isTrafficEnabled = value;
    return _channel.invokeMethod('setTrafficEnabled', {'isEnable': value});
  }

  Future<void> enablePOIs(bool value) async {
    isPOIsEnabled = value;
    return _channel.invokeMethod('enablePOIs', {'isEnable': value});
  }

  Future<void> showsCompass(bool value) async {
    return _channel.invokeMethod('showsCompass', {'isEnable': value});
  }

  Future<void> allGesturesEnabled(bool value) async {
    return _channel.invokeMethod('allGesturesEnabled', {'isEnable': value});
  }

  Future<void> myLocationButtonEnabled(bool value) async {
    return _channel.invokeMethod('myLocationButtonEnabled', {'isEnable': value});
  }

  Future<void> setMyLocationEnabled(bool value) async {
    return _channel.invokeMethod('setMyLocationEnabled', {'isEnable': value});
  }
  Future<void> setMapMode(int value) async {
    return _channel.invokeMethod('setMapMode', {'mapMode': value});
  }

}
