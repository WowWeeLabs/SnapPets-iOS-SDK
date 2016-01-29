//
//  SnappetRobotConstants.h
//  bttester
//
//  Created by Forrest Chan on 18/11/14.
//  Copyright (c) 2013 WOWWEE GROUP LIMITED. All rights reserved.
//

@import Foundation;

#ifndef SnappetRobotConstants_h
#define SnappetRobotConstants_h

// Snappet Photo Service
#define kSnappetPhotoServiceString                                      "SnappetPhoto"
#define kSnappetPhotoServiceUUID                                        0xFF00
#define kSnappetPhotoCharacteristic_ButtonPressedNotificationString     "ButtonPressedNotification"
#define kSnappetPhotoCharacteristic_ButtonPressedNotificationUUID       0xFF01
#define kSnappetPhotoCharacteristic_NewPhotoNotificationString          "NewPhotoNotification"
#define kSnappetPhotoCharacteristic_NewPhotoNotificationUUID            0xFF02
#define kSnappetPhotoCharacteristic_PhotoFullNotificationString         "PhotoFullNotification"
#define kSnappetPhotoCharacteristic_PhotoFullNotificationUUID           0xFF03
#define kSnappetPhotoCharacteristic_ListPhotosString                    "ListPhotos"
#define kSnappetPhotoCharacteristic_ListPhotosUUID                      0xFF04
#define kSnappetPhotoCharacteristic_GetPhotoString                      "GetPhoto"
#define kSnappetPhotoCharacteristic_GetPhotoUUID                        0xFF05
#define kSnappetPhotoCharacteristic_PhotoBlobString                     "PhotoBlob"
#define kSnappetPhotoCharacteristic_PhotoBlobUUID                       0xFF06
#define kSnappetPhotoCharacteristic_DeletePhotoString                   "DeletePhoto"
#define kSnappetPhotoCharacteristic_DeletePhotoUUID                     0xFF07
#define kSnappetPhotoCharacteristic_DeleteAllPhotoString                "DeleteAllPhoto"
#define kSnappetPhotoCharacteristic_DeleteAllPhotoUUID                  0xFF08
#define kSnappetPhotoCharacteristic_TakePhotoToFlashString              "TakePhotoToFlash"
#define kSnappetPhotoCharacteristic_TakePhotoToFlashUUID                0xFF09
#define kSnappetPhotoCharacteristic_TakePhotoString                     "TakePhoto"
#define kSnappetPhotoCharacteristic_TakePhotoUUID                       0xFF0A
#define kSnappetPhotoCharacteristic_StopTransferString                  "StopTransfer"
#define kSnappetPhotoCharacteristic_StopTransferUUID                    0xFF0B

// Snappet Settings Service
#define kSnappetSettingsServiceString                                   "SnappetSettings"
#define kSnappetSettingsServiceUUID                                     0xFF10
#define kSnappetSettingsCharacteristic_SetLargeSizePhotoInfoString      "LargeSizePhotoInfo"
#define kSnappetSettingsCharacteristic_SetLargeSizePhotoInfoUUID        0xFF14
#define kSnappetSettingsCharacteristic_AppendPhotoHeaderString          "AppendPhotoHeader"
#define kSnappetSettingsCharacteristic_AppendPhotoHeaderUUID            0xFF15
#define kSnappetSettingsCharacteristic_OverridePhotoOnFlashString       "OverridePhotoOnFlash"
#define kSnappetSettingsCharacteristic_OverridePhotoOnFlashUUID         0xFF16
#define kSnappetSettingsCharacteristic_ShortPressString                 "ShortPress"
#define kSnappetSettingsCharacteristic_ShortPressUUID                   0xFF17
#define kSnappetSettingsCharacteristic_EnableLEDString                  "EnableLED"
#define kSnappetSettingsCharacteristic_EnableLEDUUID                    0xFF19
#define kSnappetSettingsCharacteristic_ActivationStatusString           "ActivationStatus"
#define kSnappetSettingsCharacteristic_ActivationStatusUUID             0xFF1B
#define kSnappetSettingsCharacteristic_CmosSensorFrequencyString        "CmosSensorFrequency"
#define kSnappetSettingsCharacteristic_CmosSensorFrequencyUUID          0xFF1C
#define kSnappetSettingsCharacteristic_TimeoutString                    "SleepTime"
#define kSnappetSettingsCharacteristic_SleepTimeUUID                    0xFF1D
#define kSnappetSettingsCharacteristic_CmosPowerOffTimeString           "CmosPowerOffTime"
#define kSnappetSettingsCharacteristic_TimeoutUUID                      0xFF1D
#define kSnappetSettingsCharacteristic_ChargingStatusString             "ChargingStatus"
#define kSnappetSettingsCharacteristic_ChargingStatusUUID               0xFF1F
//#define kSnappetSettingsCharacteristic_ThumbnailQualityString           "ThumbnailQuality"
//#define kSnappetSettingsCharacteristic_ThumbnailQualityUUID             0xFF11
//#define kSnappetSettingsCharacteristic_ThumbnailResolutionString        "ThumbnailResolution"
//#define kSnappetSettingsCharacteristic_ThumbnailResolutionUUID          0xFF12
//#define kSnappetSettingsCharacteristic_PhotoQualityString               "PhotoQuality"
//#define kSnappetSettingsCharacteristic_PhotoQualityUUID                 0xFF13
//#define kSnappetSettingsCharacteristic_PhotoResolutionString            "PhotoResolution"
//#define kSnappetSettingsCharacteristic_PhotoResolutionUUID              0xFF14
//#define kSnappetSettingsCharacteristic_LongPressString                  "LongPress"
//#define kSnappetSettingsCharacteristic_LongPressUUID                    0xFF18
//#define kSnappetSettingsCharacteristic_LongPressDurationString          "LongPressDuration"
//#define kSnappetSettingsCharacteristic_LongPressDurationUUID            0xFF1A
//#define kSnappetSettingsCharacteristic_SleepTimeString                  "SleepTime"
//#define kSnappetSettingsCharacteristic_SleepTimeUUID                    0xFF1D
//#define kSnappetSettingsCharacteristic_CmosPowerOffTimeString           "CmosPowerOffTime"
//#define kSnappetSettingsCharacteristic_CmosPowerOffTimeUUID             0xFF1E



// Snappet Security Service
#define kSnappetSecurityServiceString                                   "SnappetSecurity"
#define kSnappetSecurityServiceUUID                                     0xFF20
#define kSnappetSecurityCharacteristic_ASCIIPinCodeEnabledString        "ASCIIPinCodeEnabled"
#define kSnappetSecurityCharacteristic_ASCIIPinCodeEnabledUUID          0xFF21
#define kSnappetSecurityCharacteristic_SetASCIIPinCodeString            "SetASCIIPinCode"
#define kSnappetSecurityCharacteristic_SetASCIIPinCodeUUID              0xFF22
#define kSnappetSecurityCharacteristic_AuthenticateWithPinCodeString    "AuthenticateWithPinCode"
#define kSnappetSecurityCharacteristic_AuthenticateWithPinCodeUUID      0xFF23
#define kSnappetSecurityCharacteristic_ResetPinCodeAndEraseFlashString  "ResetPinCodeAndEraseFlash"
#define kSnappetSecurityCharacteristic_ResetPinCodeAndEraseFlashUUID    0xFF24

// Snappet Module Settings Service
#define kSnappetModuleServiceString                                     "SnappetModule"
#define kSnappetModuleServiceUUID                                       0xFF30
#define kSnappetModuleCharacteristic_RebootString                       "Reboot"
#define kSnappetModuleCharacteristic_RebootUUID                         0xFF31

// Snappet Change Name  (OLD firmware)
#define kSnappetGenericAccessServiceString                             "GenericAccess"
#define kSnappetGenericAccessServiceUUID                                0xFF50
#define kSnappetGenericDeviceNameString                                 "DeviceName"
#define kSnappetGenericDeviceNameUUID                                   0xFF51

// Snappet Module Parameter Service
#define kSnappetModuleParameterServiceString                                        "SnappetModuleParameter"
#define kSnappetModuleParameterServiceUUID                                           0xFF90
#define kSnappetModuleParameterDeviceNameString                                     "DeviceName"
#define kSnappetModuleParameterDeviceNameUUID                                        0xFF91
#define kSnappetModuleParameterProductIDCharacteristicString                         "setOrReadProductID"
#define kSnappetModuleParameterProductIDCharacteristicUUID                           0xFF96
#define kSnappetModuleParameterCustomBroadcastDataCharacteristicString               "setOrReadCustomBroadcastData"
#define kSnappetModuleParameterCustomBroadcastDataCharacteristicUUID                 0xFF98
#define kSnappetModuleParameterUserPhoneNameString                                   "userPhoneName"
#define kSnappetModuleParameterUserPhoneNameUUID                                     0xFF9B


typedef enum : uint8_t {
    kSnappetPhotoThumbnail = 0x01,
    kSnappetPhotoLargeSize = 0x02,
} kSnappetPhotoSize;

typedef enum : uint8_t {
    kSnappetShortPress = 0x01,
    kSnappetLongPress = 0x02,
} kSnappetPressType;

typedef enum : uint8_t {
    kSnappetPhotoResolutionVGA = 0x01,
    kSnappetPhotoResolutionQVGA = 0x02,
} kSnappetPhotoResolution;

typedef enum : uint8_t {
    kSnappetPressDoNothing = 0x00,
    kSnappetPressDoCaptureSaveNotify = 0x01,
    kSnappetPressDoNotify = 0x02,
} kSnappetPressAction;

typedef enum : uint8_t {
    kSnappetRebootApplication = 0x01,
    kSnappetRebootDFU = 0x02,
    kSnappetRebootDTM = 0x03,
//    kSnappetRebootQAQC = 0x04,
    kSnappetRebootSleep = 0x04,     // TEMP for testing
    kSnappetRebootPowerOff = 0x05,  // TEMP for testing
    kSnappetDeepSleep = 0x06
} kSnappetRebootMode;

typedef enum : uint8_t {
    kSnappetNotCharging = 0x00,
    kSnappetCharging = 0x01,
    kSnappetFullyCharge = 0x02
} kSnappetChargingStatus;

typedef enum :uint8_t {
    kSnappetResponseStartCharging = 0x00,
    kSnappetResponseDisconnectCharging = 0x01,
    kSnappetResponseBatteryFull = 0x02
} kSnappetChargingResponse;

typedef enum : uint8_t {
    kSnappetPhotoQualityLow = 0,
    kSnappetPhotoQualityHigh = 100
} kSnappetPhotoQuality;

typedef enum: uint8_t {
    kSnappetColorBlue = 1,
    kSnappetColorPink = 2,
    kSnappetColorOrage = 3,
    kSnappetColorSilver = 4,
    kSnappetAquaBlue = 5
} kSnappetColorIndex;
#endif
