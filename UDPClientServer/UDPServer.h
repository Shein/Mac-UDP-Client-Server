//
//  UDPServer.h
//  UDPClientServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef WIN32
#include <WinSock2.h>
#else
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#endif
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <signal.h>

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


@protocol UDPServerDelegate <NSObject>

@required
-(void)receivedHandState:(NSValue*)_handStateValue;

@end

@interface UDPServer : NSObject {
   	int m_socket;
   	struct sockaddr_in m_sockaddr;
    
    CFSocketRef cfSocket;
    CFRunLoopSourceRef cfSource;
    
    id<UDPServerDelegate> delegate;
}

@property (nonatomic, assign) id<UDPServerDelegate> delegate;

-(id)initWithPortNumber:(int)_portNumber;
-(void)sendHandSateToDelegate:(HandState)_handState;

//Callback method for UDP
void receivedPacket (CFSocketRef s, CFSocketCallBackType callbacktype, CFDataRef address, const void *data, void *info);

@end
