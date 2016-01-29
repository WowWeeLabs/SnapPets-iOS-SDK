//
//  MainViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 20/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

typedef NS_ENUM(NSInteger, TimerLevel) {
    TimerLevel_0 = 0,
    TimerLevel_3 = 3,
    TimerLevel_7 = 7,
    TimerLevel_10 = 10,
};

@interface MainViewController : UIViewController <SnappetRobotDelegate>

- (IBAction)snapButtonPressed:(id)sender;
- (IBAction)cancelTimeLapsePressed:(id)sender;
- (IBAction)timerButtonPressed:(id)sender;
- (IBAction)saveToAlbumButtonPressed:(id)sender;
- (void)startLiveTimeLapseWithInterval:(int)second IsRepeated:(bool)isrepeat;

@property(nonatomic, weak) IBOutlet UIProgressView *progressView;
@property(nonatomic, weak) IBOutlet UIButton *timerButton;
@property(nonatomic, weak) IBOutlet UILabel *countDownLabel;
@property(nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property(nonatomic, weak) IBOutlet UILabel *receivingLabel;
@property(nonatomic, weak) IBOutlet UILabel *hintsLabel;
@property(nonatomic, weak) IBOutlet UIButton *cancelTimeLapseButton;
@property(nonatomic, weak) IBOutlet UIButton *saveToAlbumButton;

@property(nonatomic, strong) SnappetRobot* connectedRobot;
@property(nonatomic, strong) NSMutableData *receivedData;
@property(nonatomic, assign) int photoLength;
@property(nonatomic, strong) UIImage* capturedImage;

@property(nonatomic, assign) TimerLevel takePhotoTimerLevel;
@property(nonatomic, assign) int takePhotoInterval;
@property(nonatomic, assign) int timeLeftToTakePhoto;
@property(nonatomic, assign) BOOL isRepeatingTakePhoto;
@end

