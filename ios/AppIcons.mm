#import "AppIcons.h"

@implementation AppIcons
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setAppIcon:(NSString *)iconName
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  if(![[UIApplication sharedApplication] supportsAlternateIcons]) {
    reject(@"UNSUPPORTED", nil, nil);
  }
  
  [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
      reject(@"ERROR", error.localizedDescription, nil);
      return;
    }
    
    resolve(nil);
  }];
}

RCT_EXPORT_METHOD(resetAppIcon:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  if(![[UIApplication sharedApplication] supportsAlternateIcons]) {
    reject(@"UNSUPPORTED", nil, nil);
  }
  
  [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
      reject(@"ERROR", error.localizedDescription, nil);
      return;
    }
    
    resolve(nil);
  }];
}
@end
