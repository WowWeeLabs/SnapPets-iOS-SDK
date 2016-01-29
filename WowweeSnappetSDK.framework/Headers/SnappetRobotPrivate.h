//
//  SnappetRobotPrivate.h
//  WowWeeSnappetSDK
//
//  Created by Forrest Chan on 17/11/14.
//  Copyright (c) 2014 WowWee Group Ltd. All rights reserved.
//

@import UIKit;
@import Foundation;
@import CoreBluetooth;

#import "BluetoothRobot.h"
#import "BluetoothRobotPrivate.h"
#import "SnappetRobot.h"

@interface SnappetRobot()

#pragma mark Private Api Calls
-(void) setSnappetProductActivated;
@end

@protocol SnappetRobotPrivateDelegate <SnappetRobotDelegate>
@optional
#pragma mark - Lower level bluetooth chip delegate calls
// If didReceiveRawCommandBytes is implemented then higher level MIP commands are not passed, this takes priority
-(void) SnappetRobotBluetooth:(SnappetRobot *)mip didReceiveRobotCommand:(RobotCommand *)command;
-(void) SnappetRobotBluetooth:(SnappetRobot *)mip didReceiveRawCommandData:(NSData *)data;

@end
