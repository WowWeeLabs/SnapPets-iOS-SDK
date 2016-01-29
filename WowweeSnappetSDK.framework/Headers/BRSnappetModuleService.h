//
//  BRSnappetModuleService.h
//  BluetoothRobotControlLibrary
//
//  Created by Forrest Chan on 19/11/14.
//  Copyright (c) 2014 WOWWEE GROUP LIMITED. All rights reserved.
//

@import Foundation;
#import "BRBaseService.h"
#import "SnappetRobotConstants.h"

/** KVO **/
// Context
#ifndef snappetModuleKVOContext
#define snappetModuleKVOContext "snappetModule"
#endif

@interface BRSnappetModuleService : BRBaseService

#pragma mark - WRITE
- (void)rebootToMode:(kSnappetRebootMode)mode withCallback:(void (^)(NSError *))callback;

@end
