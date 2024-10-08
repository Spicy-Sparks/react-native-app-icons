
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAppIconsSpec.h"

@interface AppIcons : NSObject <NativeAppIconsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface AppIcons : NSObject <RCTBridgeModule>
#endif

@end
