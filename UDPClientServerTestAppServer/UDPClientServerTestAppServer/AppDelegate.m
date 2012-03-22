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


-(void)receivedData:(NSData *)_data
{
    // Read into char *
//    unsigned char *message = (unsigned char*)[_data bytes];
//    NSLog(@"Got: %s", message);
    
    // Read into struct, i.e. HandState
    HandState handState;
    [(NSData*)_data getBytes:&handState length:sizeof(HandState)];
    NSLog(@"Received handstate: %d", handState.fingerPose);
}


@end
