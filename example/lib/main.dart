import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';
import 'package:tplmapsflutterplugin/tplmapsflutterplugin.dart';
import 'package:tplmapsflutterplugin_example/second.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

late TplMapsViewController _controller;

class _MyAppState extends State<MyHomePage> {

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'map';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};


    // return TplMapsView(
    //   isShowBuildings: true,
    //   isZoomEnabled: true,
    //   showZoomControls: true,
    //   isTrafficEnabled: true,
    //   mapMode: MapMode.DEFAULT,
    //   enablePOIs: true,
    //   setMyLocationEnabled: false,
    //   myLocationButtonEnabled: false,
    //   showsCompass: true,
    //   allGesturesEnabled: true,
    //   tplMapsViewCreatedCallback: _callback,
    //   tPlMapsViewMarkerCallBack: _markerCallback,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("App Bar 1"),
      ),
      body: Stack(
        children: [
          Container(
            child: TplMapsView(
              isShowBuildings: true,
              isZoomEnabled: true,
              showZoomControls: true,
              isTrafficEnabled: true,
              mapMode: MapMode.NIGHT,
              enablePOIs: true,
              setMyLocationEnabled: false,
              myLocationButtonEnabled: false,
              showsCompass: true,
              allGesturesEnabled: true,
              tplMapsViewCreatedCallback: _callback,
              tPlMapsViewMarkerCallBack: _markerCallback,
            ),

          ),
          Container(
           width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(

                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],

              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
            width: double.infinity,
            height: 50,
            color: Colors.red,
            child: Text("Text on the Map", style: TextStyle(color: Colors.white , fontSize: 20),  textAlign: TextAlign.center,),
          )
        ],

      ),


    );

  }

  void _markerCallback(String callback){

    log(callback);
    //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: SecondRoute()));

  }

  void _callback(TplMapsViewController controller) {
    controller.setZoomEnabled(true);
    controller.showBuildings(false);
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

  // void getSearchItemsbyName (){
  //
  //   TPlSearchViewController tPlSearchViewController =
  //   TPlSearchViewController("Atrium Mall" , 24.8607 , 67.0011 , (retrieveItemsCallback) {
  //
  //     // You will be get json list response
  //     log(retrieveItemsCallback);
  //   },);
  //
  //   tPlSearchViewController.getReverseGeocoding();
  //
  // }
  //
  // void getRouting(){
  //   TPLRoutingViewController tplRoutingViewController =
  //   TPLRoutingViewController(24.820159, 67.123933, 24.830831, 67.080857 , (tplRoutingCallBack) {
  //     log(tplRoutingCallBack);
  //     _controller.setUpPolyLine();
  //   },);
  //
  //   tplRoutingViewController.getSearchItems();
  //
  // }

}

