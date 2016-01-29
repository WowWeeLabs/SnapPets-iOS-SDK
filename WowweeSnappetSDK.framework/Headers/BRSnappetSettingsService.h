//
//  BRSnappetSettingsService.h
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
#ifndef snappetSettingsKVOContext
#define snappetSettingsKVOContext "snappetSettings"
#endif

// KeyPath
//FOUNDATION_EXPORT NSString *const thumbnailQualityKeyPathKVO;
//FOUNDATION_EXPORT NSString *const thumbnailResolutionKeyPathKVO;
//FOUNDATION_EXPORT NSString *const photoQualityKeyPathKVO;
//FOUNDATION_EXPORT NSString *const photoResolutionKeyPathKVO;
//FOUNDATION_EXPORT NSString *const longPressKeyPathKVO;
//FOUNDATION_EXPORT NSString *const longPressDurationKeyPathKVO;
//FOUNDATION_EXPORT NSString *const sleepTimeKVO;
//FOUNDATION_EXPORT NSString *const cmosPoweroffTimeKVO;

FOUNDATION_EXPORT NSString *const appendPhotoHeaderKeyPathKVO;
FOUNDATION_EXPORT NSString *const overridePhotosOnFlashKeyPathKVO;
FOUNDATION_EXPORT NSString *const shortPressKeyPathKVO;
FOUNDATION_EXPORT NSString *const ledEnabledKeyPathKVO;
FOUNDATION_EXPORT NSString *const snappetActivationStatusKVO;
FOUNDATION_EXPORT NSString *const cmosSensorFrequencyKVO;
FOUNDATION_EXPORT NSString *const chargingStatusKVO;
FOUNDATION_EXPORT NSString *const largeSizePhotoInfoKVO;
FOUNDATION_EXPORT NSString *const timeoutKVO;
FOUNDATION_EXPORT NSString *const chargingResponseKVO;


@interface BRSnappetSettingsService : BRBaseService

//@property (nonatomic, strong) NSNumber *thumbnailQuality;
//@property (nonatomic, strong) NSNumber *thumbnailResolution;
//@property (nonatomic, strong) NSNumber *photoQuality;
//@property (nonatomic, strong) NSNumber *photoResolution;
//@property (nonatomic, strong) NSNumber *longPressDuration;
//@property (nonatomic, strong) NSNumber *sleepTime;
//@property (nonatomic, strong) NSNumber *cmosPoweroffTime;
//@property (nonatomic, strong) NSNumber *longPress;

@property (nonatomic, strong) NSNumber *appendPhotoHeader;
@property (nonatomic, strong) NSNumber *overridePhotosOnFlash;
@property (nonatomic, strong) NSNumber *shortPress;
@property (nonatomic, strong) NSNumber *ledEnabled;
@property (nonatomic, strong) NSNumber *activationStatus;
@property (nonatomic, strong) NSNumber *cmosSensorFrequency;
@property (nonatomic, strong) NSData *chargingStatus;
@property (nonatomic, strong) NSData *largeSizePhotoInfo;
@property (nonatomic, strong) NSData *timeout;

@property (nonatomic, assign) bool isNotifying;
@property (nonatomic, strong) NSData *chargingResponse;

#pragma mark - NOTIFY
- (void)turnOff;
- (void)turnOn;

#pragma mark - READ
//- (void)readThumbnailQuality;
//- (void)readThumbnailResolution;
//- (void)readPhotoQuality;
//- (void)readPhotoResolution;
//- (void)readLongPressAction;
//- (void)readLongPressDuration;
//- (void)readSleepTime;
//- (void)readCmosPoweroffTime;

- (void)readAppendPhotoHeader;
- (void)readOverridePhotosOnFlash;
- (void)readShortPressAction;
- (void)readLEDEnabled;
- (void)readActivationStatus;
- (void)readCmosSensorFrequency;
- (void)readChargingStatus;
- (void)readLargeSizePhotoInfo;
- (void)readTimeout;

#pragma mark - WRITE
//- (void)setThumbnailQuality:(uint8_t)quality withCallback:(void (^)(NSError *))callback;        // quality (0 - 100)
//- (void)setThumbnailResolution:(kSnappetPhotoResolution)resolution withCallback:(void (^)(NSError *))callback;
//- (void)setPhotoQuality:(uint8_t)quality withCallback:(void (^)(NSError *))callback;        // quality (0 - 100)
//- (void)setPhotoResolution:(kSnappetPhotoResolution)resolution withCallback:(void (^)(NSError *))callback;
//- (void)setLongPressAction:(kSnappetPressAction)pressAction withCallback:(void (^)(NSError *))callback;
//- (void)setLongPressDuration:(int)duration withCallback:(void (^)(NSError *))callback;
//- (void)setSleepTime:(uint8_t)sleepTime withCallback:(void (^)(NSError *))callback;
//- (void)setCmosPowerOffTime:(uint8_t)cmosPowerOffTime withCallback:(void (^)(NSError *))callback;

- (void)appendPhotoHeader:(BOOL)append withCallback:(void (^)(NSError *))callback;
- (void)overridePhotosOnFlash:(BOOL)override withCallback:(void (^)(NSError *))callback;
- (void)setShortPressAction:(kSnappetPressAction)pressAction withCallback:(void (^)(NSError *))callback;
- (void)setLEDEnabled:(BOOL)LEDEnabled withCallback:(void (^)(NSError *))callback;
- (void)setActivationStatus:(uint8_t)activationStatus withCallback:(void (^)(NSError *))callback;
- (void)setCmosSensorFrequency:(uint8_t)frequency withCallback:(void (^)(NSError *))callback;
- (void)setLargeSizePhotoInfo:(uint8_t)quality resolution:(kSnappetPhotoResolution)resolution withCallback:(void (^)(NSError *))callback;
- (void)setTimeout:(uint8_t)connectModeTimeout cmosPoweroffTimeout:(uint8_t)cmosPoweroffTimeout withCallback:(void (^)(NSError *))callback;
@end
