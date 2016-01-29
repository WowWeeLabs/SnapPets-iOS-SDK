//
//  MainViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 20/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoLibraryManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.connectedRobot = nil;
    
    self.takePhotoTimerLevel = TimerLevel_0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.connectedRobot = [[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
        self.connectedRobot.delegate = self;
    }
    else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)snapButtonPressed:(id)sender {
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count == 0) {
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"No Snappet!" message:@"Please connect to snappet first." preferredStyle:UIAlertControllerStyleAlert];
        [_alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:_alert animated:YES completion:nil];
        return;
    }

    if(self.takePhotoTimerLevel == TimerLevel_0) {
        [self takePhoto];
    }
    else {
        int timeDelay = 3;
        switch (self.takePhotoTimerLevel) {
            case TimerLevel_3:
                timeDelay = 3;
                break;
            case TimerLevel_7:
                timeDelay = 7;
                break;
            case TimerLevel_10:
                timeDelay = 10;
                break;
            default:
                break;
        }
        [self startLiveTimeLapseWithInterval:timeDelay IsRepeated:NO];
    }
}

- (IBAction)saveToAlbumButtonPressed:(id)sender {
    if(self.photoImageView.image != nil) {
        [[PhotoLibraryManager sharedInstance] saveToCameraRoll:self.photoImageView.image];
    }
}

- (IBAction)timerButtonPressed:(id)sender {
    switch (self.takePhotoTimerLevel) {
        case TimerLevel_0:
            self.takePhotoTimerLevel = TimerLevel_3;
            [self.timerButton setTitle:@"Timer 3s" forState:UIControlStateNormal];
            break;
        case TimerLevel_3:
            self.takePhotoTimerLevel = TimerLevel_7;
            [self.timerButton setTitle:@"Timer 7s" forState:UIControlStateNormal];
            break;
        case TimerLevel_7:
            self.takePhotoTimerLevel = TimerLevel_10;
            [self.timerButton setTitle:@"Timer 10s" forState:UIControlStateNormal];
            break;
        case TimerLevel_10:
            self.takePhotoTimerLevel = TimerLevel_0;
            [self.timerButton setTitle:@"Timer 0s" forState:UIControlStateNormal];
            break;
    }
}

- (IBAction)cancelTimeLapsePressed:(id)sender {
    [self resetPhoto];
    
    self.receivingLabel.hidden = YES;
    self.hintsLabel.hidden = NO;
    self.progressView.hidden = YES;
    
    self.countDownLabel.hidden = YES;
    self.cancelTimeLapseButton.hidden = YES;
    self.cancelTimeLapseButton.enabled = NO;
    
    self.takePhotoInterval = 0;
    self.isRepeatingTakePhoto = NO;
    self.timeLeftToTakePhoto = 0;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(takePhoto) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateCountDownEverySecond) object:nil];
}

// Take photo with specified time interval in second. Can continously take another photo when isRepeated is true.
- (void)startLiveTimeLapseWithInterval:(int)second IsRepeated:(bool)isrepeat {
    self.takePhotoInterval = second;
    self.timeLeftToTakePhoto = second;
    self.isRepeatingTakePhoto = isrepeat;
    
    [self resetPhoto];
    self.countDownLabel.hidden = NO;
    self.cancelTimeLapseButton.hidden = NO;
    self.cancelTimeLapseButton.enabled = YES;
    
    // Perform takephoto action after certain delay
    [self performSelector:@selector(takePhoto) withObject:nil afterDelay:self.takePhotoInterval];
    [self updateCountDownEverySecond];
}

- (void)updateCountDownEverySecond {
    self.countDownLabel.text = [NSString stringWithFormat:@"%d", self.timeLeftToTakePhoto];
    
    self.timeLeftToTakePhoto--;
    if(self.timeLeftToTakePhoto >= 0) {
        [self performSelector:@selector(updateCountDownEverySecond) withObject:nil afterDelay:1];
    }
}

- (void)resetPhoto {
    // Empty the data buffer and reset view to display received image
    self.receivedData = [NSMutableData new];
    self.photoLength = 0;
    [self.photoImageView setImage:nil];
    self.saveToAlbumButton.hidden = YES;
    [self.progressView setProgress:0 animated:NO];
}

- (void)takePhoto {
    // Perform take photo funciton after confirming snappet is connected
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        SnappetRobot* robot = (SnappetRobot*)[[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
        // Take photo and transfer to app without saving in snappet
        [robot snappetTakePhotoWithoutSavingToFlash:kSnappetPhotoResolutionVGA quality:kSnappetPhotoQualityHigh];
    }
    else {
        // Display warning message if no snappet connected
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"No Snappet!" message:@"Please connect to snappet first." preferredStyle:UIAlertControllerStyleAlert];
        [_alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:_alert animated:YES completion:nil];
    }
}

#pragma mark - SnappetRobotDelegate
-(void) Snappet:(SnappetRobot *)snappet didReceiveButtonPressed:(kSnappetPressType)pressType {
    if(pressType == kSnappetShortPress) {
        [self takePhoto];
    }
}

-(void) Snappet:(SnappetRobot *)snappet didReceiveNewPhoto:(uint8_t)photoId {
}

-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoFull:(NSDate *)timestamp {
}

-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoLength:(int)photoLength checksum:(uint8_t)checksum {
    [self resetPhoto];
    // Snappet reports the incoming photo size before delivering the image binary data
    self.photoLength = photoLength;
    self.progressView.hidden = NO;
    self.receivingLabel.hidden = NO;
    self.hintsLabel.hidden = YES;
}

-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoBlob:(NSData *)blobData {
    // Append received data
    [self.receivedData appendData:blobData];
    
    int receivedLength = (int)[self.receivedData length];
    float progressRate = receivedLength / (float)self.photoLength;
    [self.progressView setProgress:progressRate animated:YES];
    
    // Image transfer completed
    if(receivedLength == self.photoLength) {
        NSMutableData* finalData = [NSMutableData new];
        // Append image header data as JPG
        NSData* headerData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jpgheader.dat" ofType:nil]];
        [finalData appendData:headerData];
        [finalData appendData:self.receivedData];
        
        // Convert data to UIImage for display
        UIImage* image = [UIImage imageWithData:finalData];
        if(!image) {
            NSLog(@"invalid image data received");
        }
        else {
            // Display the received image
            [self.photoImageView setImage:image];
            self.saveToAlbumButton.hidden = NO;
        }
        // Save to app document directory
        [[PhotoLibraryManager sharedInstance] saveImage:image];

        self.hintsLabel.hidden = NO;
        self.progressView.hidden = YES;
        self.receivingLabel.hidden = YES;
        
        // Take another picture if in time lapse mode
        if(self.isRepeatingTakePhoto) {
            [self startLiveTimeLapseWithInterval:self.takePhotoInterval IsRepeated:self.isRepeatingTakePhoto];
        }
        else {
            self.cancelTimeLapseButton.hidden = YES;
            self.cancelTimeLapseButton.enabled = NO;
        }
    }
}

@end
