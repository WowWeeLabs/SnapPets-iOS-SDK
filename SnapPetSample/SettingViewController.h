//
//  SettingViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 26/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

@interface SettingViewController : UIViewController <SnappetRobotDelegate>

@property (nonatomic, weak) SnappetRobot* connectedSnappet;

@end
