#import "TplmapsflutterpluginPlugin.h"
#if __has_include(<tplmapsflutterplugin/tplmapsflutterplugin-Swift.h>)
#import <tplmapsflutterplugin/tplmapsflutterplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tplmapsflutterplugin-Swift.h"
#endif

@implementation TplmapsflutterpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTplmapsflutterpluginPlugin registerWithRegistrar:registrar];
}
@end
