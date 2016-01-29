//
//  TimeLapseConfigViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 26/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

@interface TimeLapseConfigViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, SnappetRobotDelegate>

- (IBAction)confirmButtonPressed:(id)sender;
- (IBAction)switchDidPressed:(id)sender;

@property(nonatomic, strong) SnappetRobot* connectedRobot;
@property (nonatomic, weak) IBOutlet UIPickerView* timePickerView;
@property (nonatomic, weak) IBOutlet UISwitch* stayConnectingSwitch;

@end
