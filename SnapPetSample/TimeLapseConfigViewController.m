//
//  TimeLapseConfigViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 26/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "TimeLapseConfigViewController.h"
#import "MainViewController.h"

@implementation TimeLapseConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.connectedRobot = [[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
        self.connectedRobot.delegate = self;
    }
}

- (IBAction)confirmButtonPressed:(id)sender {
    int hour = (int)[self.timePickerView selectedRowInComponent:0];
    int min = (int)[self.timePickerView selectedRowInComponent:1];
    int sec = (int)[self.timePickerView selectedRowInComponent:2];
    
    int totalSec = hour*60*60 + min*60 + sec;
    if(totalSec > 0) {
        if(self.stayConnectingSwitch.on) {
            UIViewController* vc = [self.navigationController.viewControllers objectAtIndex:0];
            if([vc isKindOfClass:[MainViewController class]]) {
                [(MainViewController*)vc startLiveTimeLapseWithInterval:totalSec IsRepeated:YES];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Start time lapse" message:@"Snappet will be disconnected and start taking photo. Confirm to do so?" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                uint8_t photoLimit = 20;
                [self.connectedRobot snappetTakePhotoWithTimerMode:(short)totalSec limit:photoLimit];
                [self performSelector:@selector(disconnectAndPop) withObject:nil afterDelay:1.0];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)disconnectAndPop {
    [self.connectedRobot disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)switchDidPressed:(id)sender {
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return 6;
    }
    return 60;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%lu", (long)row];
}

@end
