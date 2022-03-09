import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

typedef TplMapsViewCreatedCallback = void Function(TplMapsViewController controller);

class TplMapsView extends StatefulWidget {

  final TplMapsViewCreatedCallback? tplMapsViewCreatedCallback;
  const TplMapsView({
    Key? key,
    this.tplMapsViewCreatedCallback,
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
        widget.tplMapsViewCreatedCallback!(TplMapsViewController._(call.hashCode));
    }
  }
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // This is used in the platform side to register the view.
      const String viewType = 'map';
      // Pass parameters to the platform side.
      const Map<String, dynamic> creationParams = <String, dynamic>{
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
      const Map<String, dynamic> creationParams = <String, dynamic>{};
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
    widget.tplMapsViewCreatedCallback!(TplMapsViewController._(id));
  }
}

class TplMapsViewController {
  TplMapsViewController._(int id)
      : _channel = MethodChannel('plugins/map');
  final MethodChannel _channel;
  Future<void> setCameraPositionAnimated(double latitude,double longitude, double zoom) async {
    print("camera animated called");
    return _channel.invokeMethod('setCameraPositionAnimated', {'latitude': latitude,'longitude':longitude, 'zoom':zoom});
  }

  Future<void> addMarker(double latitude,double longitude) async {
    return _channel.invokeMethod('addMarker', {'latitude': latitude,'longitude':longitude});
  }

  Future<void> setZoomEnabled(bool isEnable) async {
    return _channel.invokeMethod('setZoomEnabled', {'isEnable': isEnable});
  }

  Future<void> draggable(bool value) async {
    return _channel.invokeMethod('draggable',value);
  }

  Future<void> animateToZoom(double value) async {
    return _channel.invokeMethod('animateToZoom', value);
  }
}
