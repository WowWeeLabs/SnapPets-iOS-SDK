//
//  BRSnappetGenericAccessSerivce.h
//  SnapPets
//
//  Created by Katy Pun on 5/1/15.
//  Copyright (c) 2015 ___WOWWEE___. All rights reserved.
//

@import Foundation;
#import "BRBaseService.h"
#import "SnappetRobotConstants.h"

/** KVO **/
// Context
#ifndef snappetGenericAccessKVOContext
#define snappetGenericAccessKVOContext "snappetGenericAccess"
#endif

// KeyPath
FOUNDATION_EXPORT NSString *const snappetDeviceNameKeyPathKVO;

@interface BRSnappetGenericAccessSerivce : BRBaseService

@property (nonatomic, strong) NSString *deviceName;

#pragma mark - READ
- (void)readDeviceName;

#pragma mark - WRITE
- (void)writeDeviceName:(NSString*) deviceName withCallback:(void (^)(NSError *))callback;
@end
