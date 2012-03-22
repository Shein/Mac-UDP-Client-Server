//
//  UDPClient.m
//  UDPClientServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//


#import "UDPClient.h"

@implementation UDPClient

-(id)initWithDestinationIP:(char *)_ip andPort:(int)_port{
    
    self = [super init];
    if (self) {
        cfSocket = CFSocketCreate(NULL, 0, SOCK_DGRAM, IPPROTO_UDP, kCFSocketNoCallBack, NULL, NULL);
        if (!cfSocket)
        {
            // snip: some error handling
        }
        
        memset(&sa, 0, sizeof(sa));
        sa.sin_len = sizeof(sa);
        sa.sin_family = AF_INET;
        sa.sin_port = htons(_port);
        inet_aton(_ip, &sa.sin_addr);    
    }
    
    return self;
    
}

-(void)sendData:(NSData*)_data
{
    CFDataRef cfPackedData = (CFDataRef)_data;
    
    CFDataRef cfAddr = CFDataCreate(NULL, (unsigned char *)&sa, sizeof(sa));
    CFSocketError sendPacketResult = CFSocketSendData(cfSocket, cfAddr, cfPackedData, 0.0);
    if (sendPacketResult != kCFSocketSuccess)
    {
        // try again in 5 seconds
    }

}

@end
