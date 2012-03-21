//
//  AppDelegate.m
//  UDPClientServerTestAppServer
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
    server = [[UDPServer alloc] initWithPortNumber:11112];
    server.delegate = self;
}

-(void)receivedHandState:(NSValue*)_handStateValue
{
    HandState handState;
    [_handStateValue getValue:&handState];
    NSLog(@"Received handstate: %d", handState.fingerPose);
}

@end
