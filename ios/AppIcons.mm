#import "AppIcons.h"

@implementation AppIcons
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setAppIcon:(NSString *)iconName
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![[UIApplication sharedApplication] supportsAlternateIcons]) {
            reject(@"UNSUPPORTED", nil, nil);
            return;
        }
        
        NSString* currentIcon = [[UIApplication sharedApplication] alternateIconName];
        
        if ([currentIcon isEqualToString:iconName]) {
            resolve(nil);
            return;
        }
        
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                reject(@"ERROR", error.localizedDescription, nil);
                return;
            }
            
            resolve(nil);
        }];
    });
}

RCT_EXPORT_METHOD(resetAppIcon:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![[UIApplication sharedApplication] supportsAlternateIcons]) {
            reject(@"UNSUPPORTED", nil, nil);
            return;
        }
        
        [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                reject(@"ERROR", error.localizedDescription, nil);
                return;
            }
            
            resolve(nil);
        }];
    });
}
@end
