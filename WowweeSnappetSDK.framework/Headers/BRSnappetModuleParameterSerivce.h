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

//Avaliable for firmware start from v0.14, and bootloader v0.4

/** KVO **/
// Context
#ifndef snappetModuleParameterKVOContext
#define snappetModuleParameterKVOContext "snappetModuleParameter"
#endif

// KeyPath
FOUNDATION_EXPORT NSString *const sdeviceNameKeyPathKVO;
FOUNDATION_EXPORT NSString *const snappetProductIdKeyPathKVO;
FOUNDATION_EXPORT NSString *const snappetCustomBroadcastDataKeyPathKVO;
FOUNDATION_EXPORT NSString *const userPhoneNameKeyPathKVO;

@interface BRSnappetModuleParameterSerivce : BRBaseService

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, assign) NSUInteger snappetProductId;
@property (nonatomic, strong) NSDictionary *snappetCustomBroadcastData;
@property (nonatomic, strong) NSString* userPhoneName;

#pragma mark - READ
- (void) readDisplayName;
- (void) readBroadcastData;
- (void) readProductIdentifier;
- (void) readUserPhoneName;

#pragma mark - WRITE
- (void) writeDeviceName:(NSString*) deviceName withCallback:(void (^)(NSError *))callback;
- (void) setBroadcastDataToDefaultWithCallback:(void (^)(NSError *))callback;
- (void) setBroadcastData:(NSDictionary *)broadcastData withCallback:(void (^)(NSError *))callback;
- (void) setProductIdentifier:(uint16_t)productIdentifier withCallback:(void (^)(NSError *))callback;
- (void) setUserPhoneName:(NSString *)userPhoneName withCallback:(void (^)(NSError *))callback;
@end
