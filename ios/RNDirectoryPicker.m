#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(DirectoryPicker, NSObject)

RCT_EXTERN_METHOD(pickFolder:
(RCTPromiseResolveBlock)resolve
rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(createFolder:
                  (NSString *)path
                  folderName:(NSString *)folderName
                  )

@end
