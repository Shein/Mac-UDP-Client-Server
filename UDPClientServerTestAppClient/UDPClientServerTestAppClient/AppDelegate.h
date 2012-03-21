//
//  AppDelegate.h
//  UDPClientServerTestAppClient
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "UDPClient.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    UDPClient *client;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)sendPacket:(id)sender;
@end
