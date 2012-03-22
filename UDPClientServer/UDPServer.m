//
//  UDPServer.m
//  UDPClientServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import "UDPServer.h"

@interface UDPServer ()
-(void)sendDataToDelegate:(NSData*)_data;
@end

@implementation UDPServer
@synthesize delegate;


- (id)initWithPortNumber:(int)portNumber
{
    self = [super init];
    if (self)
    {
        // Create Socket
        int sockHandle = socket(AF_INET, SOCK_DGRAM, 0);
        struct sockaddr_in sa;
        sa.sin_family = AF_INET;
        sa.sin_addr.s_addr = htonl(INADDR_ANY);
        sa.sin_port = htons(portNumber);
        if (bind(sockHandle, (struct sockaddr *)&sa, sizeof(sa)) == - 1)
        {
            fprintf(stderr, "Could not bind socket.\n");
            return self;
        }
        
        // Create context with 'self' reference in info pointer and add to runloop callback
        CFSocketContext socketContext = {0, self, NULL, NULL, NULL};
        cfSocket = CFSocketCreateWithNative(NULL, sockHandle,
                                            kCFSocketDataCallBack, receivedPacket, &socketContext); // CFSocketRef
        cfSource = CFSocketCreateRunLoopSource(NULL, cfSocket, 0); //   
        CFRunLoopAddSource(CFRunLoopGetCurrent(), cfSource, kCFRunLoopDefaultMode);
        
    }
    return self;
}

void receivedPacket (CFSocketRef s, CFSocketCallBackType callbacktype, CFDataRef address, const void *data, void *info) 
{    
    id _self = (id)info;
    [_self sendDataToDelegate:(NSData*)data];
}

-(void)sendDataToDelegate:(NSData*)_data
{
    if (delegate != nil && [delegate respondsToSelector:@selector(receivedData:)]) {
        [delegate performSelector:@selector(receivedData:) withObject:_data];
    }
}


- (void)dealloc
{
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), cfSource, kCFRunLoopDefaultMode);
    CFRelease(cfSource);
    CFRelease(cfSocket);
    [super dealloc];
}

@end
