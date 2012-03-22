//
//  ViewController.h
//  UDPClientServerClient-iOS
//
//  Created by Daniel Shein on 3/22/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UDPCLient.h"

@interface ViewController : UIViewController
{
    UDPClient *client;
}

- (IBAction)sendPacket:(id)sender;

@end
