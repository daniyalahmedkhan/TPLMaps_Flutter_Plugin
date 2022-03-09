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
   // private var map: TPLMaps.TPLMapView
    init(
                frame: CGRect,
                viewIdentifier viewId: Int64,
                arguments args: Any?,
                binaryMessenger messenger: FlutterBinaryMessenger?
            ) {
                self.map = TPLMaps.TPLMapView.init()
                self.map.zoomEnabled = true
                
                super.init()
                self.map.delegate = self
                
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
                    case "addMarker":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let latitude = args["latitude"] as! Double
                        let longitude = args["longitude"] as! Double
                        self.addMarker(self.map, latitude: latitude, longitude: longitude)
                        
                        break
                    case "setZoomEnabled":
                        guard let args = call.arguments as? [String : Any] else {return}
                        let isEnable = args["isEnable"] as! Bool
                        self.setZoomEnabled(self.map, isEnable: isEnable)
                        break;
                    default:
                        result(FlutterMethodNotImplemented)
                        return
                    }
                    
                })
                //createNativeView(view: _view)
                // iOS views can be created here
                //createNativeView(view: _view)
            }
        
//        func createNativeView(view _view: UIView){
//                _view.backgroundColor = UIColor.blue
//                let nativeLabel = UILabel()
//                nativeLabel.text = "Native text from iOS"
//                nativeLabel.textColor = UIColor.white
//                nativeLabel.textAlignment = .center
//                nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
//                _view.addSubview(nativeLabel)
//            }
        func view() -> UIView {
            return map
        }
    func setZoomEnabled(_ mapView: TPLMapView, isEnable: Bool){
        mapView.zoomEnabled = isEnable
    }
    func addMarker(_ mapView: TPLMapView, latitude: Double, longitude: Double){
        let coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker:TPLMaps.Marker = TPLMaps.Marker.markerWithPosition(CLLocationCoordinate2D: coord)
        
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
    func mapViewDidCompleteLoading(_ mapView: TPLMapView) {
        
        
    }
}
