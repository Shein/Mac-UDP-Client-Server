//
//  UDPClient.h
//  UDPClientServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <netinet/in.h>
#include <arpa/inet.h>

typedef enum HandPose
{
	OPEN_HAND,
	GRAB,
	THUMB_UP,
	NO_HAND
} HandPose;

typedef struct HandState
{
	float x;
	float y;
	float z;
	HandPose fingerPose;
    float confidence;
} HandState;


@interface UDPClient : NSObject {
    CFSocketRef cfSocket;
    struct sockaddr_in sa;
}

-(id)initWithDestinationIP:(char *)_ip andPort:(int)_port;
-(void)sendString:(NSString*)_string;
-(void)sendHandState:(struct HandState*)_handState;
@end
