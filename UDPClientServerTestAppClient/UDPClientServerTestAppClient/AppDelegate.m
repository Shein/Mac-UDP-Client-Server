//
//  AppDelegate.m
//  UDPClientServerTestAppClient
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    client = [[UDPClient alloc] initWithDestinationIP:"192.168.0.13" andPort:11112];
}

- (IBAction)sendPacket:(id)sender {

    HandState *_handState = (HandState*)malloc(sizeof(HandState));
    
    _handState->x = 1.0;
    _handState->y = 1.0;
    _handState->z = 1.0;
    _handState->fingerPose = GRAB;
    
    [client sendHandState:_handState];
}

@end
