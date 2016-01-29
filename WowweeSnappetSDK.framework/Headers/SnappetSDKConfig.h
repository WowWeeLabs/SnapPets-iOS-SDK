//
//  SnappetSDKConfig.h
//  WowWeeSnappetSDK
//
//  Created by Forrest Chan on 17/11/14.
//  Copyright (c) 2014 WowWee Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAI.h"

// These can be overridden by defining them before importing the SDK

#ifndef GOOGLE_ANALYRICS_ID
#define GOOGLE_ANALYTICS_ID @"UA-54753853-1"
#endif

#ifndef ENABLE_GOOGLE_ANALYTICS_TRACKING
#define ENABLE_GOOGLE_ANALYTICS_TRACKING 0
#endif

#ifndef GOOGLE_ANALYTICS_LOG_LEVEL
//#define GOOGLE_ANALYTICS_LOG_LEVEL kGAILogLevelVerbose
#define GOOGLE_ANALYTICS_LOG_LEVEL kGAILogLevelNone
#endif

typedef enum {
    MRFScanOptionMask_ShowAllDevices       = 0,
    MRFScanOptionMask_FilterByProductId    = 1 << 0,
    MRFScanOptionMask_FilterByServices     = 1 << 1,
    MRFScanOptionMask_FilterByDeviceName   = 1 << 2,
} SnappetRobotFinderScanOptions;

#ifndef SNAPPET_SCAN_OPTIONS
//#define SNAPPET_SCAN_OPTIONS MRFScanOptionMask_ShowAllDevices | MRFScanOptionMask_FilterByProductId | MRFScanOptionMask_FilterByServices
#define SNAPPET_SCAN_OPTIONS MRFScanOptionMask_ShowAllDevices | MRFScanOptionMask_FilterByProductId
#endif

@interface SnappetSDKConfig : NSObject
@end
