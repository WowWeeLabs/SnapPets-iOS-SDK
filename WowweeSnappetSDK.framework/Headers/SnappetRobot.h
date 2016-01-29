//
//  SnappetRobot.h
//  BluetoothRobotControlLibrary
//
//  Created by Forrest Chan on 17/11/14.
//  Copyright (c) 2013 WowWee Group Limited. All rights reserved.
// 

@import UIKit;
@import Foundation;
@import CoreBluetooth;

#import "BluetoothRobot.h"
#import "SnappetCommandValues.h"
#import "SnappetRobotConstants.h"
#import "BluetoothRobotPrivate.h"

@protocol SnappetRobotDelegate;

FOUNDATION_EXPORT NSString *const SNAPPET_CONNECTED_NOTIFICATION_NAME;
FOUNDATION_EXPORT NSString *const SNAPPET_DISCONNECTED_NOTIFICATION_NAME;

typedef NS_ENUM(NSInteger, SnappetLogLevel) {
    SnappetLogLevelDebug,
    SnappetLogLevelErrors,
    SnappetLogLevelNone
};

@interface SnappetRobot : BluetoothRobot
@property (readwrite) NSNumber *snappetRSSI;

/** Event manager handles handling basic events which do not require app interaction **/
@property (nonatomic, strong) NSDate *snappetFirmwareVersionDate;
@property (nonatomic, assign) NSUInteger snappetFirmwareVersionId;
@property (nonatomic, strong) NSNumber *snappetHardwareVersion;
@property (nonatomic, assign) NSInteger batteryLevel;
@property (nonatomic, readonly, assign) kSnappetActivationStatus toyActivationStatus;

@property (nonatomic, assign) bool disableReceivedCommandProcessing;

@property (nonatomic, assign) SnappetLogLevel logLevel;
@property (nonatomic, assign) uint8_t takePhotoMode;
/** Delegate for receiving callbacks */
@property (nonatomic, weak) id<SnappetRobotDelegate> delegate;
@property (nonatomic, assign) NSInteger colorId;

#pragma mark - Snappet Protocal Methods
- (void)snappetReadNumberOfPhotos;
- (void)snappetReadTakePhotoMode;
- (void)snappetGetPhoto:(kSnappetPhotoSize)size photoID:(uint8_t)photoID;   // Photo ID starts from 0x01 to number of photos
- (void)snappetTakePhotoAndSaveToFlash;
- (void)snappetTakePhotoWithTimerMode:(short)seconds limit:(uint8_t)limit;
- (void)snappetTakePhotoWithoutSavingToFlash:(kSnappetPhotoResolution)resolution quality:(uint8_t)quality;     // quality (1-100)
- (void)snappetDeletePhoto:(uint8_t)photoID;
- (void)snappetDeleteAllPhoto;
- (void)snappetStopTransfer;
- (void)snappetStopTimeMode;
- (void)snappetReboot:(kSnappetRebootMode)rebootMode;

#pragma mark - Snappet Settings Protocol Service
//- (void)snappetReadThumbnailQuality;
//- (void)snappetReadThumbnailResolution;
//- (void)snappetReadPhotoQuality;
//- (void)snappetReadPhotoResolution;
//- (void)snappetReadLongPressAction;
//- (void)snappetReadLongPressDuration;
//- (void)snappetReadSleepTime;
//- (void)snappetReadCmosPoweroffTime;

- (void)snappetReadAppendPhotoHeader;
- (void)snappetReadOverridePhotoOnFlash;
- (void)snappetReadShortPressAction;
- (void)snappetReadLEDEnabled;
- (void)snappetReadActivationStatus;
- (void)snappetReadCmosSensorFrequency;
- (void)snappetReadChargingStatus;
- (void)snappetReadLargeSizePhotoInfo;
- (void)snappetReadTimeout;

//- (void)snappetSetThumbnailQuality:(uint8_t)quality;
//- (void)snappetSetThumbnailResolution:(kSnappetPhotoResolution)resolution;
//- (void)snappetSetPhotoQuality:(uint8_t)quality;
//- (void)snappetSetPhotoResolution:(kSnappetPhotoResolution)resolution;
//- (void)snappetSetLongPressAction:(kSnappetPressAction)pressAction;
//- (void)snappetSetLongPressDuration:(int)duration;
//- (void)snappetSetSleepTime:(uint8_t)sleepTime;
//- (void)snappetSetCmosPoweroffTime:(uint8_t)cmosPoweroffTime;

- (void)snappetAppendPhotoHeader:(BOOL)append;
- (void)snappetOverridePhotosOnFlash:(BOOL)override;
- (void)snappetSetShortPressAction:(kSnappetPressAction)pressAction;
- (void)snappetSetLEDEnabled:(BOOL)LEDEnabled;
- (void)snappetSetProductActivated;
- (void)snappetResetProductActivation;
- (void)snappetSetProductActivationUploaded;
- (void)snappetSetProductionActivationHackerActivated;
- (void)snappetSetProductionActivationHackerUploaded;
- (void)snappetSetCmosSensorFrequency:(uint8_t)frequency;
- (void)snappetSetLargeSizePhotoInfo:(uint8_t)quality resolution:(kSnappetPhotoResolution)resolution;
- (void)snappetSetTimeout:(uint8_t)connectModeTimeout cmosPoweroffTimeout:(uint8_t)cmosPoweroffTimeout;

#pragma mark - Snappet Security Protocol Service
- (void)snappetReadASCIIPinCodeEnabled;
- (void)snappetSetASCIIPinCodeEnabled:(BOOL)pinEnabled;
- (void)snappetSetASCIIPinCode:(short)digit1 digit2:(short)digit2 digit3:(short)digit3 digit4:(short)digit4;
- (void)snappetAuthenticateWithASCIIPinCode:(short)digit1 digit2:(short)digit2 digit3:(short)digit3 digit4:(short)digit4;
- (void)snappetResetASCIIPinCodeAndEraseFlash;

#pragma mark - Snappet Generic Access Service
- (void)snappetReadDeviceName;
- (void)snappetWriteDeviceName:(NSString*)deviceName;

#pragma mark - Snappet Module Parameter Service
- (void)snappetReadDisplayName;
- (void)snappetReadBroadcastData;
- (void)snappetReadProductIdentifier;
- (void)snappetReadUserPhoneName;
- (void)snappetWriteDisplayName:(NSString*)displayName;
- (void)snappetSetBroadcastDataToDefault;
- (void)snappetSetBroadcastData:(NSDictionary *)broadcastData;
- (void)snappetSetProductIdentifier:(uint16_t)productIdentifier;
- (void)snappetSetUserPhoneName:(NSString *)userPhoneName;

@end

#pragma mark - Delegate Callbacks
@protocol SnappetRobotDelegate <NSObject>
@optional
/** Connection Methods **/
-(void) SnappetDeviceReady:(SnappetRobot *)snappet;
-(void) SnappetDeviceDisconnected:(SnappetRobot *)snappet error:(NSError *)error;
-(void) SnappetDeviceFailedToConnect:(SnappetRobot *)snappet error:(NSError *)error;
-(void) SnappetDeviceReconnecting:(SnappetRobot *)snappet;
-(void) SnappetDeviceWentToSleep:(SnappetRobot *)snappet batteryEmpty:(bool)batteryEmpty;

-(void) Snappet:(SnappetRobot *)snappet didReceiveButtonPressed:(kSnappetPressType)pressType;
-(void) Snappet:(SnappetRobot *)snappet didReceiveNewPhoto:(uint8_t)photoId;
-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoFull:(NSDate *)timestamp;
-(void) Snappet:(SnappetRobot *)snappet didReceiveNumberOfPhoto:(int)numberOfPhoto;
-(void) Snappet:(SnappetRobot *)snappet didReceiveTakePhotoMode:(uint8_t)mode;
-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoLength:(int)photoLength checksum:(uint8_t)checksum;
-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoBlob:(NSData *)blobData;
-(void) Snappet:(SnappetRobot *)snappet deletedPhoto:(NSArray *)photoIds;

//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsThumbnailQuality:(int)thumbnailQuality;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsThumbnailResolution:(int)resolution;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsPhotoQuality:(int)photoQuality;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsPhotoResolution:(int)photoResolution;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsLongPress:(int)state;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsLongPressDuration:(int)duration;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsSleepTime:(int)sleepTime;
//-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingCmosPoweroffTime:(int)cmosPoweroffTime;

-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsAppendPhotoHeader:(int)appendHeader;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsPhotoOnFlash:(int)override;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsShortPress:(int)state;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsEnableLED:(int)enableLED;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsActivationStatus:(int)status;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingsCmosFrequency:(int)frequency;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingChargingStatus:(kSnappetChargingStatus)chargingStatus;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingLargePhotoInfo:(kSnappetPhotoQuality)quality resolution:(kSnappetPhotoResolution)resolution;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingTimeout:(int)connectModeTimeout cmosPoweroffTimeout:(int)cmosPoweroffTimeout;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSettingChargingResponse:(int)response;

-(void) Snappet:(SnappetRobot *)snappet didReceiveSecurityPinEnable:(int)enable;
-(void) Snappet:(SnappetRobot *)snappet didReceiveSecurityAuthenticateResponse:(int)response;
-(void) Snappet:(SnappetRobot *)snappet didReceiveGenericAccessDeviceName:(NSString *)deviceName;

-(void) Snappet:(SnappetRobot *)snappet didReceiveModuleParameterDeviceName:(NSString *)deviceName;
-(void) Snappet:(SnappetRobot *)snappet didReceiveModuleParameterCustomBroadcastData:(NSDictionary *)customBroadcastData;
-(void) Snappet:(SnappetRobot *)snappet didReceiveModuleParameterProductId:(NSUInteger)productId;
-(void) Snappet:(SnappetRobot *)snappet didReceiveModuleParameterUserPhoneName:(NSString *)userPhoneName;
@end




