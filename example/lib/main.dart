import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';

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
      tplMapsViewCreatedCallback: _callback,
    );
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
    controller.ping();
  }
}
