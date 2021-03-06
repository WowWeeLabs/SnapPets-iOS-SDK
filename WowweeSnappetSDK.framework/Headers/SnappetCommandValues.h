//
//  SnappetCommandValues.h
//  BluetoothRobotControlLibrary
//
//  Created by Forrest Chan on 17/11/14.
//  Copyright (c) 2014 WowWee Group Limited. All rights reserved.
//

@import Foundation;

FOUNDATION_EXPORT NSUInteger const SNAPPET_BLUETOOTH_PRODUCT_ID;
FOUNDATION_EXPORT NSUInteger const SNAPPET_BLUETOOTH_DFU_PRODUCT_ID;
FOUNDATION_EXPORT NSString *const SNAPPET_BLUETOOTH_CUSTOM_DATA_IDENTIFIER;

typedef NS_OPTIONS(uint8_t, kSnappetCommand) {
    kMipSetIRRemoteEnabledDisabled = 0x10, // kMipSetIRRemoteValue
    kMipGetIRRemoteEnabledDisabled = 0x11,
};

typedef NS_OPTIONS(NSUInteger, kSnappetActivationStatus) {
    kSnappetActivation_FactoryDefault               = 0,        // => 00000000
    kSnappetActivation_Activate                     = (1 << 0), // => 00000001
    kSnappetActivation_ActivationSentToFlurry       = (1 << 1), // => 00000010
    kSnappetActivation_HackerUartUsed               = (1 << 2), // => 00000100
    kSnappetActivation_HackerUartUsedSentToFlurry   = (1 << 3), // => 00001000
};

typedef NS_OPTIONS(uint8_t, kSnappetTakePhotoMode) {
    kSnappetTakePhotoMode_Normal = 0x00, // kMipSetIRRemoteValue
    kSnappetTakePhotoMode_Timelapse = 0x01,
};

@interface SnappetCommandValues : NSObject

@end

