/*
 * Copyright 2010-2014 WowWee Group Ltd, All Rights Reserved.
 *
 * Licensed under the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

@import CoreBluetooth;

#import "SnappetRobot.h"
#import "BluetoothRobotFinder.h"

FOUNDATION_EXPORT NSString *const SnappetRobotFinderNotificationID;
FOUNDATION_EXPORT bool const SNAPPET_ROBOT_FINDER_DEBUG_MODE;

/**
 These are the values that can be sent from SnappetRobotFinder
 */
typedef enum : NSUInteger {
    SnappetRobotFinderNote_SnappetFound = 1,
    SnappetRobotFinderNote_SnappetListCleared,
    SnappetRobotFinderNote_BluetoothError,
    SnappetRobotFinderNote_BluetoothIsOff,
    SnappetRobotFinderNote_BluetoothIsAvailable,
} SnappetRobotFinderNote;

@interface SnappetRobotFinder : BluetoothRobotFinder <CBCentralManagerDelegate>

/**

 */
@property (nonatomic, strong, readonly) NSMutableArray *snappetsFound;
@property (nonatomic, strong, readonly) NSMutableArray *snappetsConnected;
@property (nonatomic, assign, readonly) CBCentralManagerState cbCentralManagerState;

// Log level
@property (nonatomic, assign) SnappetLogLevel logLevel;

/**
 Starts the BLE scanning
 */
-(void)scanForSnappets;
-(void)scanForSnappetsInBackground;

/**
 Starts the BLE scanning for a specified number of seconds. Normally you should use this method because endlessly scanning is very battery intensive.
 */
-(void)scanForSnappetsForDuration:(NSUInteger)seconds;
-(void)stopScanForSnappets;
-(void)clearFoundSnappetList;

/**
 Quick access to first connected Snappet in snappetsConnected list
 @return snappetsConnected[0] or nil if snappetsConnected is empty
 */
-(SnappetRobot *)firstConnectedSnappet;

@end