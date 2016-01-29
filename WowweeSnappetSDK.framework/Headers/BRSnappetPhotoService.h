//
//  BRSnappetPhotoService.h
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
#ifndef snappetPhotoKVOContext
#define snappetPhotoKVOContext "snappetPhoto"
#endif
// KeyPath
FOUNDATION_EXPORT NSString *const numberOfPhotoKeyPathKVO;
FOUNDATION_EXPORT NSString *const takePhotoModeKeyPathKVO;
FOUNDATION_EXPORT NSString *const getPhotoDataKeyPathKVO;
FOUNDATION_EXPORT NSString *const buttonPressedNotificationKeyPathKVO;
FOUNDATION_EXPORT NSString *const photoNotificationKeyPathKVO;
FOUNDATION_EXPORT NSString *const photoFullNotificationKeyPathKVO;
FOUNDATION_EXPORT NSString *const deletePhotoKeyPathKVO;
FOUNDATION_EXPORT NSString *const takePhotoToFlashKeyPathKVO;
FOUNDATION_EXPORT NSString *const photoBlobKeyPathKVO;

FOUNDATION_EXPORT NSString *const SnappetGetPhotoNotificationID;
FOUNDATION_EXPORT NSString *const SnappetGetButtonPressedNotificationID;

@interface BRSnappetPhotoService : BRBaseService

@property (nonatomic, strong) NSNumber *takePhotoMode;
@property (nonatomic, strong) NSNumber *numberOfPhotos;
@property (nonatomic, assign) bool isNotifying;
@property (nonatomic, strong) NSData *getPhotoData;
@property (nonatomic, strong) NSData *buttonPressedNotificationData;
@property (nonatomic, strong) NSData *photoNotificationData;
@property (nonatomic, strong) NSDate *photoFullTimestamp;
@property (nonatomic, strong) NSData *deletePhotoData;
@property (nonatomic, strong) NSData *takePhotoToFlashData;
@property (nonatomic, strong) NSData *photoBlobData;

#pragma mark - NOTIFY
- (void)turnOff;
- (void)turnOn;

#pragma mark - READ
- (void)readNumberOfPhotos;
- (void)readTakePhotoMode;

#pragma mark - WRITE
- (void)getPhoto:(kSnappetPhotoSize)size photoID:(uint8_t)photoID withCallback:(void (^)(NSError *))callback;
- (void)deletePhoto:(uint8_t)photoID withCallback:(void (^)(NSError *))callback;
- (void)deleteAllPhotos;
- (void)takePhotoWithTimerMode:(short)seconds limit:(uint8_t)limit;
- (void)takePhotoAndSaveToFlash;
- (void)takePhotoWithoutSavingToFlash:(kSnappetPhotoResolution)resolution quality:(uint8_t)quality;     // quality (1-100)
- (void)stopTransfer;
- (void)stopTimerMode;

@end
