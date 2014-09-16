#pragma once
#import <Foundation/Foundation.h>

@protocol SMJobBlessHelperProtocol
- (void)commandString:(NSString *)input withReply:(void (^)(NSString *error))reply;
@end

@interface SMJobBlessHelper : NSObject <SMJobBlessHelperProtocol, NSXPCListenerDelegate>
+ (SMJobBlessHelper *) GetSMJobBlessHelperTool;
@end
