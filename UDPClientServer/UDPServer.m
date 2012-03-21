//
//  UDPServer.m
//  UDPClientServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import "UDPServer.h"

@implementation UDPServer
@synthesize delegate;


- (id)initWithPortNumber:(int)portNumber
{
    self = [super init];
    if (self)
    {
        //Create Socket
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
        
        //Create context with 'self' reference in info pointer and add to runloop callback
        CFSocketContext socketContext = {0, self, NULL, NULL, NULL};
        cfSocket = CFSocketCreateWithNative(NULL, sockHandle,
                                            kCFSocketDataCallBack, receivedPacket, &socketContext); // CFSocketRef
        cfSource = CFSocketCreateRunLoopSource(NULL, cfSocket, 0); //   
        CFRunLoopAddSource(CFRunLoopGetCurrent(), cfSource, kCFRunLoopDefaultMode);
        
    }
    return self;
}

void receivedPacket (CFSocketRef s, CFSocketCallBackType callbacktype, CFDataRef address, const void *data, void *info) {
    
    NSData *localData = (NSData*)data;
    unsigned char *message;
    message = (unsigned char*)[localData bytes];
    //Convert received packet to HandState and call message to delegate method
    HandState _handState;
    [(NSData*)data getBytes:&_handState length:sizeof(HandState)];
    id _self = (id)info;
    [_self sendHandSateToDelegate:_handState];
}

-(void)sendHandSateToDelegate:(HandState)_handState{
    if (delegate != nil && [delegate respondsToSelector:@selector(receivedHandState:)]) {
        [delegate performSelector:@selector(receivedHandState:) withObject:[NSValue valueWithBytes:&_handState objCType:@encode(HandState) ]];
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
