//
//  BRSnappetSecurityService.h
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
#ifndef snappetSecurityKVOContext
#define snappetSecurityKVOContext "snappetSecurity"
#endif
// KeyPath
FOUNDATION_EXPORT NSString *const pinCodeEnabledKeyPathKVO;
FOUNDATION_EXPORT NSString *const authenticateResponseKeyPathKVO;

@interface BRSnappetSecurityService : BRBaseService

@property (nonatomic, assign) bool isNotifying;

@property (nonatomic, strong) NSNumber *pinCodeEnabled;
@property (nonatomic, strong) NSData *authenticateResponse;

#pragma mark - NOTIFY
- (void)turnOff;
- (void)turnOn;

#pragma mark - READ
- (void)readASCIIPinCodeEnabled;

#pragma mark - WRITE
- (void)setASCIIPinCodeEnabled:(BOOL)pinEnabled withCallback:(void (^)(NSError *))callback;
- (void)setASCIIPinCode:(short)digit1 digit2:(short)digit2 digit3:(short)digit3 digit4:(short)digit4 withCallback:(void (^)(NSError *))callback; 
- (void)authenticateWithASCIIPinCode:(short)digit1 digit2:(short)digit2 digit3:(short)digit3 digit4:(short)digit4 withCallback:(void (^)(NSError *))callback;
- (void)resetASCIIPinCodeAndEraseFlash;

@end
