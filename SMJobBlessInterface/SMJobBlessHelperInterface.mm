#import "SMJobBlessHelperInterface.h"
#import <syslog.h>

@implementation SMJobBlessHelper

// Implement the one method in the NSXPCListenerDelegate protocol.
- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
{
    syslog (LOG_NOTICE, "new incoming connection");
#pragma unused(listener)
    // Configure the new connection and resume it. Because this is a singleton object, we set 'self' as the exported object and configure the connection to export the 'SMJobBlessHelperProtocol' protocol that we implement on this object.
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(SMJobBlessHelperProtocol)];
    newConnection.exportedObject = self;
    [newConnection resume];
    
    return YES;
}

// This method sends the response back to the host application.
- (void)commandString:(NSString *)input withReply:(void (^)(NSString *replyString))reply
{
    syslog (LOG_NOTICE, "Response Received in helper tool.");
#pragma unused(input)
    // Create an error object to pass back, if appropriate.
    NSString *replyStr = @"Hi there, host application!";
    // Invoke the reply block, which will send a response back to the main application to let it know that we are finished.
    reply(replyStr);
}

+ (SMJobBlessHelper *) GetSMJobBlessHelperTool {
    static dispatch_once_t onceToken;
    static SMJobBlessHelper *shared;
    dispatch_once(&onceToken, ^{
        shared = [SMJobBlessHelper new];
    });
    return shared;
}

@end
