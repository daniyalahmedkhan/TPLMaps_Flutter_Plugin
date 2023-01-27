import Flutter
import UIKit
public class SwiftTplmapsflutterpluginPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let factory = TPLMapViewFactory(messenger: registrar.messenger())
                registrar.register(factory, withId: "map")
    }
        
}
