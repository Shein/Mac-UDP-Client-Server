//
//  ViewController.m
//  UDPClientServerClient-iOS
//
//  Created by Daniel Shein on 3/22/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    client = [[UDPClient alloc] initWithDestinationIP:"192.168.0.13" andPort:11112];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (IBAction)sendPacket:(id)sender {
    
    HandState *_handState = (HandState*)malloc(sizeof(HandState));
    
    _handState->x = 1.0;
    _handState->y = 1.0;
    _handState->z = 1.0;
    _handState->fingerPose = THUMB_UP;
    
    [client sendHandState:_handState];
}

@end
