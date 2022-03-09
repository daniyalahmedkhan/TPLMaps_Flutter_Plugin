
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class Tplmapsflutterplugin {
  static const MethodChannel _channel = const MethodChannel('tplmapsflutterplugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


 // static Future<PlatformViewLink> get maps async {
 //   const String viewType = 'map';
 //   const Map<String, dynamic> creationParams = <String, dynamic>{};
 //
 //   return PlatformViewLink(
 //     viewType: viewType,
 //     surfaceFactory: (BuildContext context, PlatformViewController controller) {
 //       return AndroidViewSurface(
 //         controller: controller as AndroidViewController,
 //         gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
 //         hitTestBehavior: PlatformViewHitTestBehavior.opaque,
 //       );
 //     },
 //     onCreatePlatformView: (PlatformViewCreationParams params) {
 //       return PlatformViewsService.initSurfaceAndroidView(
 //         id: params.id,
 //         viewType: viewType,
 //         layoutDirection: TextDirection.ltr,
 //         creationParams: creationParams,
 //         creationParamsCodec: const StandardMessageCodec(),
 //         onFocus: () {
 //           params.onFocusChanged(true);
 //         },
 //       )
 //         ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
 //         ..create();
 //     },
 //   );
 //  }
}
