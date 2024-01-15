import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/rendering.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';

import 'package:http/http.dart' as http;
import 'package:tplmapsflutterplugin_example/second.dart';
import 'package:tplmapsflutterplugin_example/third.dart';

void main() {
  runApp(TestApp());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestApp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

late TplMapsViewController _controller;
double zoomLevel = 8;

class _MyAppState extends State<MyHomePage> {
  String textValue = "";
  Timer timeHandle = Timer(Duration(seconds: 3), () {});

  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 3), () {
      if (textValue != "") {
        print("Calling API Here: $textValue");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timeHandle.cancel();
  }

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  String address = ''; // Initial text value

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
              showZoomControls: false,
              isTrafficEnabled: true,
              longClickMarkerEnable: false,
              mapMode: MapMode.NIGHT,
              enablePOIs: false,
              setMyLocationEnabled: true,
              myLocationButtonEnabled: true,
              showsCompass: true,
              allGesturesEnabled: true,
              tplMapsViewCreatedCallback: _callback,
              tPlMapsViewMarkerCallBack: _markerCallback,
            ),
          ),
          GestureDetector(
            onTap: () {
              zoomLevel += 1;
              _controller.setZoomFixedCenter(zoomLevel);
            },
            child: Center(
              child: Container(
                child: Image.asset(
                  'assets/droppin.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0), // Adding some space between texts
                        Expanded(
                          child: Text(
                            address,
                            style: TextStyle(
                                // Your style for the address text goes here
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onSubmitted: (String value) {
                    getSearchItemsbyName(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              // Bottom right aligned icons
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                    child: Image.asset(
                      'assets/zoomin.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Image.asset(
                    'assets/zoomout.png',
                    width: 70,
                    height: 70,
                  ), // Replace with your icon/image
                  Image.asset(
                    'assets/mylocation.png',
                    width: 70,
                    height: 70,
                  ), // Replace with your icon/image
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _markerCallback(String callback) {
    print(callback);

    // Find the index of "LatLng:"
    int latLngIndex = callback.indexOf("LatLng:");

    if (latLngIndex != -1) {
      // Extract substring after "LatLng:"
      String latLngSubstring =
          callback.substring(latLngIndex + "LatLng:".length).trim();

      // Split the substring to get the values
      List<String> values = latLngSubstring.split(',');

      // Assuming the first value is latitude and the second value is longitude
      if (values.length >= 2) {
        String latitude = values[0].trim();
        String longitude = values[1].trim();

        print("Latitude: $latitude, Longitude: $longitude");

        postData(latitude + ";" + longitude.split("}")[0]);
      }
    }
  }

  void _callback(TplMapsViewController controller) {
    controller.setZoomEnabled(false);
    controller.showBuildings(false);
    controller.showBuildings(false);
    // controller.setZoomEnabled(false);
    controller.setTrafficEnabled(false);
    controller.enablePOIs(false);
    controller.setMyLocationEnabled(true);
    controller.myLocationButtonEnabled(false);
    controller.showsCompass(false);

    controller.setCameraPositionAnimated(
        33.698047971892045, 73.06930062598059, 14.0);

     controller.addMarker(33.698047971892045, 73.06930062598059);

    controller.addMarkerCustomMarker(
        33.698047971892045, 73.06930062598059, 50, 50);

    // controller.addMarkerCustomMarker(33.698047972345, 73.0693006876459, 50 , 50);
    // controller.addMarkerCustomMarker(33.6980479712357878, 73.06930098543452, 50 , 50);
    // controller.addMarkerCustomMarker(33.698047971652341, 73.069300687988, 50 , 50);
    // controller.addMarkerCustomMarker(33.69804797667524235, 73.06930062855673, 50 , 50);
    // controller.addMarkerCustomMarker(0, 0, 50 , 50);
    // controller.addMarkerCustomMarker(24.826295, 67.1236449, 50 , 50);

    // controller.addMarker(33.705349, 73.069788);

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

    _controller.removeAllMarker();

    _controller.animateToZoom(14.0);
  }

  void addPolyline() {
    _controller.addPolyLine(23.23, 23.23, 23.23, 123.123);
  }

  void addCircle() {
    _controller.addCircle(
      23.23,
      23.23,
      23.23,
    );
  }

  void removePolyLine() {
    _controller.removePolyline();
  }

  void removeCircles() {
    _controller.removeAllCircles();
  }

  void getSearchItemsbyName(String text) {
    TPlSearchViewController tPlSearchViewController = TPlSearchViewController(
      text,
      24.8607,
      67.0011,
      (retrieveItemsCallback) {
        print(retrieveItemsCallback);

        List<dynamic> decodedResponse = json.decode(retrieveItemsCallback);

        // Access the first element of the array and then the "responseData" key
        var responseData = decodedResponse[0]['compound_address_parents'];

        // Access the "compound_address_parents" key from "responseData"
        // String compoundAddressParents =
        // responseData['1']['compound_address_parents'];

        print(decodedResponse[0]['lat']);
        print(decodedResponse[0]['lng']);

        setState(() {
          address = responseData;
          _controller.setCameraPositionAnimated(24.8260624, 67.1245394, 14.0);
        });
      },
    );

    tPlSearchViewController.getSearchItems();
  }

  Future<void> postData(String latlng) async {
    final apiUrl = 'https://api1.tplmaps.com:8888/search/rgeocodebulk?addressCount=1&apikey=';
    List<Map<String, dynamic>> dataArray = [
      {
        'point': latlng
      },
    ];
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataArray),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> decodedResponse = json.decode(response.body);

        // Access the first element of the array and then the "responseData" key
        var responseData = decodedResponse[0]['responseData'];

        // Access the "compound_address_parents" key from "responseData"
        String compoundAddressParents = responseData['1']['compound_address_parents'];

        setState(() {
          address = compoundAddressParents;
        });
      } else {
        // Request failed
        print('Failed to post data: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Error in making the request
      print('Error: $error');
    }
  }

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
