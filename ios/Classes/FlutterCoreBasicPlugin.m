#import "FlutterCoreBasicPlugin.h"
#if __has_include(<flutter_core_basic/flutter_core_basic-Swift.h>)
#import <flutter_core_basic/flutter_core_basic-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_core_basic-Swift.h"
#endif

@implementation FlutterCoreBasicPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCoreBasicPlugin registerWithRegistrar:registrar];
}
@end
