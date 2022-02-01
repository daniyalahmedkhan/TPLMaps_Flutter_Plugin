import 'dart:async';

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
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // This is used in the platform side to register the view.
      const String viewType = 'map';
      // Pass parameters to the platform side.
      const Map<String, dynamic> creationParams = <String, dynamic>{};

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
    return const Text('iOS platform version is not implemented yet.');
  }


  void _onPlatformViewCreated(int id) {
    if (widget.tplMapsViewCreatedCallback == null) {
      return;
    }
    widget.tplMapsViewCreatedCallback!(TplMapsViewController._(id));
  }
}

class TplMapsViewController {
  TplMapsViewController._(int id)
      : _channel = MethodChannel('plugins/map$id');

  final MethodChannel _channel;

  Future<void> ping() async {
    return _channel.invokeMethod('ping');
  }

  Future<void> draggable(bool value) async {
    return _channel.invokeMethod('draggable',value);
  }


}
