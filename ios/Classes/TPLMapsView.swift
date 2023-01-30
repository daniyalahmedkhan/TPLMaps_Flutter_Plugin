//
//  TPLMapsView.swift
//  tplmapsflutterplugin
//
//  Created by Zaeem EhsanUllah on 23/02/2022.
//

import UIKit
import Flutter
import TPLMaps
class TPLMapsView: NSObject, FlutterPlatformView, TPLMaps.TPLMapViewDelegate {
    
    
    var map : TPLMaps.TPLMapView
    var myLocationButtonEnabled: Bool = false
   // private var map: TPLMaps.TPLMapView
    init(
                frame: CGRect,
                viewIdentifier viewId: Int64,
                arguments args: Any?,
                binaryMessenger messenger: FlutterBinaryMessenger?
            ) {
                self.map = TPLMaps.TPLMapView.init()
                //self.map.zoomEnabled = true
                
                super.init()
                self.map.delegate = self
                if let args = args as? [String : Any?] {
                    let isZoomEnabled : Bool = args["isZoomEnabled"] as! Bool
                    let isShowBuildings : Bool = args["isShowBuildings"] as! Bool
                    let showZoomControls : Bool = args["showZoomControls"] as! Bool
                    let isTrafficEnabled : Bool = args["isTrafficEnabled"] as! Bool
                    let enablePOIs : Bool = args["enablePOIs"] as! Bool
                    let mapMode: Int = args["mapMode"] as! Int
                    let showsCompass: Bool = args["showsCompass"] as! Bool
                    myLocationButtonEnabled = args["myLocationButtonEnabled"] as! Bool
                    let setMyLocationEnabled: Bool = args["setMyLocationEnabled"] as! Bool
                    let allGesturesEnabled: Bool = args["allGesturesEnabled"] as! Bool
                    print("myLocationButtonEnabled: \(myLocationButtonEnabled)")
                    print("setMyLocationEnabled: \(setMyLocationEnabled)")
                    self.map.zoomEnabled = isZoomEnabled
                    self.map.showsBuildings = isShowBuildings
                    self.map.zoomControlsEnabled = showZoomControls
                    self.map.showsCompass = showsCompass
                    self.map.allGesturesEnabled = allGesturesEnabled
                    self.map.trafficEnabled = isTrafficEnabled
                    self.map.showsPointsOfInterest = enablePOIs
                    
                    self.map.showsUserLocation = setMyLocationEnabled;
                    self.map.myLocationButtonEnabled = myLocationButtonEnabled
                    if(mapMode == 1){
                        self.map.mapMode = MapViewTheme.DAY
                    }
                    else{
                        self.map.mapMode = MapViewTheme.NIGHT
                    }
                }
                
                let mapChannel = FlutterMethodChannel(name: "plugins/map",
                    binaryMessenger: messenger!)
                
                mapChannel.setMethodCallHandler({
                      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                    switch (call.method){
                    case "setCameraPositionAnimated":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let latitude = args["latitude"] as! Double
                        let longitude = args["longitude"] as! Double
                        let zoom = args["zoom"] as! Double
                        self.setCameraPositionAnimated(self.map, latitude: latitude, longitude: longitude, zoom: zoom)
                        break

                     case "setZoomLevel":
                       guard let args = call.arguments as? [String : Any] else {return}
                       let zoom = args["zoom"] as! Double
                       self.animateToZoom(self.map, zoom: zoom)
                       break

                    case "addMarker":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let latitude = args["latitude"] as! Double
                        let longitude = args["longitude"] as! Double
                        self.addMarker(self.map, latitude: latitude, longitude: longitude)
                        break
                    case "addMarkerCustomMarker":
                         guard let args = call.arguments as? [String : Any] else {return}
                         let latitude = args["latitude"] as! Double
                         let longitude = args["longitude"] as! Double
                         let width = args["width"] as! Int
                         let height = args["height"] as! Int
                         self.addCustomMarker(self.map, latitude: latitude, longitude: longitude)
                         break
                    case "setZoomEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setZoomEnabled(self.map, isEnable: isEnable)
                        break;
                    case "showBuildings":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.showBuildings(self.map, isEnable: isEnable)
                    case "enablePOIs":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.enablePOIs(self.map, isEnable: isEnable)
                    case "showZoomControls":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.showZoomControls(self.map, isEnable: isEnable)
                    case "setTrafficEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setTrafficEnabled(self.map, isEnable: isEnable)
                    case "showsCompass":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.showsCompass(self.map, isEnable: isEnable)
                    case "allGesturesEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setAllGesturesEnabled(self.map, isEnable: isEnable)
                    case "myLocationButtonEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setMyLocationButtonEnabled(self.map, isEnable: isEnable)
                    case "setMyLocationEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setMyLocationEnabled(self.map, isEnable: isEnable)
                    case "setMapMode":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let mapMode: Int = args["mapMode"] as! Int
                        var mapViewTheme: MapViewTheme = MapViewTheme.DAY
                        if(mapMode == 1){
                            mapViewTheme = MapViewTheme.DAY
                        }
                        else if(mapMode == 2){
                            mapViewTheme = MapViewTheme.NIGHT
                        }
                        self.setMapMode(self.map, theme: mapViewTheme)
                    default:
                        result(FlutterMethodNotImplemented)
                        return
                    }
                    
                })
                //createNativeView(view: _view)
                // iOS views can be created here
                //createNativeView(view: _view)
            }
        func view() -> UIView {
            return map
        }
    func setZoomEnabled(_ mapView: TPLMapView, isEnable: Bool){
        mapView.zoomEnabled = isEnable
    }
    func showBuildings(_ mapView: TPLMapView, isEnable: Bool){
        mapView.showsBuildings = isEnable
    }
    func enablePOIs(_ mapView: TPLMapView, isEnable: Bool){
        mapView.showsPointsOfInterest = isEnable
    }
    func showZoomControls(_ mapView: TPLMapView, isEnable: Bool){
        mapView.zoomControlsEnabled = isEnable
    }
    func setTrafficEnabled(_ mapView: TPLMapView, isEnable: Bool){
        mapView.trafficEnabled = isEnable
    }
    func showsCompass(_ mapView: TPLMapView, isEnable: Bool){
        mapView.showsCompass = isEnable
    }
    func setAllGesturesEnabled(_ mapView: TPLMapView, isEnable: Bool){
        mapView.allGesturesEnabled = isEnable
    }
    func setMyLocationButtonEnabled(_ mapView: TPLMapView, isEnable: Bool){
        myLocationButtonEnabled = isEnable
        mapView.myLocationButtonEnabled = isEnable
    }
    func setMyLocationEnabled(_ mapView: TPLMapView, isEnable: Bool){
        print("setMyLocationEnabled: \(isEnable)")
        mapView.showsUserLocation = isEnable
    }
    func setMapMode(_ mapView: TPLMapView, theme: MapViewTheme){
        mapView.mapMode = theme
    }
    func addMarker(_ mapView: TPLMapView, latitude: Double, longitude: Double){
        let coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker:TPLMaps.Marker = TPLMaps.Marker.markerWithPosition(CLLocationCoordinate2D: coord)
        mapView.addMarker(Marker: marker)
    }

    func addCustomMarker(_ mapView: TPLMapView, latitude: Double, longitude: Double){
         let coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
         let marker:TPLMaps.Marker = TPLMaps.Marker.markerWithPosition(CLLocationCoordinate2D: coord)
         marker.icon = UIImage(named: "custom.png")
         mapView.addMarker(Marker: marker)
    }

    func setCameraPositionAnimated(_ mapView: TPLMapView, latitude: Double, longitude: Double, zoom: Double){

        let coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.setCameraPositionAnimated(TPLMaps.CameraPosition.init(location: coord, zoom: Float(zoom)))

        //let marker:TPLMaps.Marker = TPLMaps.Marker.markerWithPosition(CLLocationCoordinate2D: coord)

        //let marker2:TPLMaps.Marker = TPLMaps.Marker.markerWithPosition(CLLocationCoordinate2D: coord2)

        //mapView.addMarker(Marker: marker)
        //mapView.addMarker(Marker: marker2)
    }

        func animateToZoom(_ mapView: TPLMapView, zoom: Double){
            mapView.animateToZoom(zoom: Float(zoom))
        }

    func mapViewDidCompleteLoading(_ mapView: TPLMapView) {
        
        
    }
}
