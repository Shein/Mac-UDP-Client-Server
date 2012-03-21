//
//  AppDelegate.h
//  UDPClientServerTestAppServer
//
//  Created by Daniel Shein on 3/21/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UDPServer.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, UDPServerDelegate>
{
    UDPServer *server;
}

@property (assign) IBOutlet NSWindow *window;

@end
