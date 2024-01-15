# Flutter TPL Maps (v-1.5.5)


**Flutter TPL Maps** Android, iOS plugin for Flutter Apps. It will help you to add maps in your application. The API automatically handles access to our TPL Maps servers, data downloading, map display, and response to map gestures. You can do add markers, shapes, POIs show/hide point of interests, custom map styles and much more.



### Maintainers

**TPL Maps** 
- Abdul Basit - Head of Analytics & Data Services – Information Technology (IT) - Abdul.Basit@tplmaps.com
- Daniyal Ahmed Khan - Manager & Team Lead (Android Development) - daniyal.khan@tplmaps.com

### Platform Compatibility  

This project is compatible with **Android** , **iOS** 
This project is compatible with Android Minimum SDK 21.

### Getting Started

Please follow the below steps:

1- **Add the latest version of package in your pubspec.yml**  
2- **Add your TPL Maps Key in Android Manifest File like below**  
```tsx
 <meta-data android:name="com.tplmaps.android.sdk.API_KEY"
            android:value="YOUR_API_KEY" />
```

4- **Add tplservices.config file in iOS project (Download from api.tplmaps.com follow iOS guide.)**  

5- **Access in dart classes  import 'package:tplmapsflutterplugin/tplmapsflutterplugin.dart';   **  

### Usage

```tsx
return TplMapsView(
        isShowBuildings: true,
        isZoomEnabled: true,,
        showZoomControls: true,,
        isTrafficEnabled: true,,
        mapMode: MapMode.NIGHT,
         enablePOIs: true,,
         setMyLocationEnabled: false,
         myLocationButtonEnabled: false,
         showsCompass: true,,
         allGesturesEnabled: true,,
 tplMapsViewCreatedCallback: _callback,
 );
 void _callback (TplMapsViewController controller)
 {
 }
 
 
 
 void _callback(TplMapsViewController controller) {
        _controller = controller;
        controller.showBuildings(false);
        controller.showZoomControls(false);
        controller.setTrafficEnabled(false);
        controller.enablePOIs(true);
        controller.setMyLocationEnabled(true);
        controller.myLocationButtonEnabled(true);
        controller.showsCompass(false);
        controller.setCameraPositionAnimated(33.698047971892045,
        73.06930062598059,14.0);
        controller.addMarker(33.705349, 73.069788);
        controller.addMarker(33.698047971892045, 73.06930062598059);
        controller.setMapMode(MapMode.DEFAULT);
        bool isBuildingsEnabled = controller.isBuildingEnabled;
        print("isBuildingsEnabled: $isBuildingsEnabled");
        bool isTrafficEnabled = controller.isTrafficEnabled;
        print("isTrafficEnabled: $isTrafficEnabled");
        bool isPOIsEnabled = controller.isPOIsEnabled;
        print("isPOIsEnabled: $isPOIsEnabled");
}
```


**Draw Marker and Shapes**
```tsx
    void _callback( TplMapsViewController: controller ){
     _controller = controller;
    };
    void addMarker(){
     _controller.addMarker(33.705349, 73.069788);
    };
    void addPolyLine(){
    _controller.addPolyLine(33.705349, 73.069788, 33.705349, 73.069788);
    };
    
    void addCircle(){
    _controller.addCircle(33.705349, 73.069788);
    };
    
    void removeMarkers(){
    _controller.removeAllMarker();
    };
    
    void removePolyline(){
    _controller.removePolyline();
    };
    
    void removeAllCircles(){
    _controller.removeAllCircles();
    };
    
     ....
    _controller.setZoomEnabled(true);
    _controller.showBuildings(false);
    _controller.showBuildings(false);
    _controller.showZoomControls(false);
    _controller.setTrafficEnabled(false);
    _controller.enablePOIs(true);
    _controller.setMyLocationEnabled(true);
    _controller.myLocationButtonEnabled(true);
    _controller.showsCompass(false);
    _controller.setCameraPositionAnimated(33.69804797189, 73.0693006259, 14.0);
    _controller.setMapMode(MapMode.DEFAULT);
    _controller.isBuildingEnabled;
    _controller.isTrafficEnabled;
    _controller.isPOIsEnabled;
    
    ;


```



**Gestures Controls**


```tsx
    return TplMapsView(
        tPlMapsViewMarkerCallBack: _markerCallback,
    );
    void _markerCallback(String callback){
        log(callback);
    };
```

**Setup Places API**

```tsx

    TPlSearchViewController tPlSearchViewController = TPlSearchViewController
        ("Atrium Mall" , 24.8607 , 67.0011 , (retrieveItemsCallback) {

         // You will be get json list response

            print(retrieveItemsCallback);

         },);

    tPlSearchViewController.getSearchItems();
```

**Initialize Reverse Geocding Params with location to get Address,For example**


```tsx

    TPlSearchViewController tPlSearchViewController = TPlSearchViewController
        (null , 24.8607 , 67.0011 , (retrieveItemsCallback) {

            // you will get the address here of the passing location

                print(retrieveItemsCallback);

            },);

        tPlSearchViewController.getReverseGeocoding();

```

**Setup Routing API**

```tsx

        Initialize TPL Routing with Starting and Destination LatLng

        TPLRoutingViewController tplRoutingViewController =
        TPLRoutingViewController(24.820159, 67.123933, 24.830831, 67.080857 ,
        (tplRoutingCallBack) => {

        // You will be get json list response

        log(tplRoutingCallBack)

        },);

    tplRoutingViewController.getSearchItems();

```

#### Contributing
Please report your issues and bugs on daniyal.khan@tplmaps.com

### License
MIT
