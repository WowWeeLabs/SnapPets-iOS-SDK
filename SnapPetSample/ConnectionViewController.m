//
//  ConnectionViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 25/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "ConnectionViewController.h"
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.deviceList = [NSMutableArray new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Register to notification center to monitor if scanning snappet completed
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSnappetRobotFinderNotification:)
                                                 name:SnappetRobotFinderNotificationID object:nil];
    CBCentralManagerState _state = [[SnappetRobotFinder sharedInstance] cbCentralManagerState];
    // Clear previous found devices list
    [[SnappetRobotFinder sharedInstance] clearFoundSnappetList];
    
    [self startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Always remember to remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SnappetRobotFinderNotificationID object:nil];
}

- (IBAction)refreshButtonPressed:(id)sender {
    [self stopScan];
//    [self.deviceList removeAllObjects];
    [[SnappetRobotFinder sharedInstance] clearFoundSnappetList];
    [self.tableView reloadData];
    [self startScan];
}

#pragma mark - Private
- (void)startScan {
    self.loadingIndicator.hidden = NO;
    [self.loadingIndicator startAnimating];
    
    // Scan snappet for 8 seconds
    [[SnappetRobotFinder sharedInstance] scanForSnappetsForDuration:8];
}

- (void)stopScan {
    self.loadingIndicator.hidden = YES;
    [[SnappetRobotFinder sharedInstance] stopScanForSnappets];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self stopScan];
    
    // If no snappet is connected yet, the array is empty
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count == 0) {
        SnappetRobot* robot = [[SnappetRobotFinder sharedInstance].snappetsFound objectAtIndex:indexPath.row];
        // Register the delegate to receive callback
        robot.delegate = self;
        // Connect to snappet
        [robot connect];
        
        self.loadingIndicator.hidden = NO;
        [self.loadingIndicator startAnimating];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SnappetRobotFinder sharedInstance].snappetsFound.count;
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"connectionCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"connectionCell"];
    }
    SnappetRobot* robot = [[SnappetRobotFinder sharedInstance].snappetsFound objectAtIndex:indexPath.row];
    cell.textLabel.text = robot.name;
    
    // The label color is the actual snappet color
    UIColor* petColor;
    switch (robot.colorId) {
        case kSnappetColorBlue:
            petColor = [UIColor colorWithRed:20.0f/255.0f green:0.0/255.0f blue:250.0f/255.0f alpha:1.0f];
            break;
        case kSnappetColorPink:
            petColor = [UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            break;
        case kSnappetColorOrage:
            petColor = [UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
            break;
        case kSnappetColorSilver:
            petColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
            break;
        case kSnappetAquaBlue:
            petColor = [UIColor colorWithRed:12.0f/255.0f green:247.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
            break;
        default:
            petColor = [UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            break;
    }
    [cell.textLabel setTextColor:petColor];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        SnappetRobot* connectedRobot = [[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
        if([robot.uuid.UUIDString isEqualToString:connectedRobot.uuid.UUIDString]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    return cell;
}

#pragma mark - SnappetRobotFinder callback
- (void)onSnappetRobotFinderNotification: (NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    if(info){
        NSNumber *code = [info objectForKey: @"code"];
        //id data = [info objectForKey: @"data"];
        if (code.intValue == SnappetRobotFinderNote_SnappetFound){
            NSLog(@"Snappet found");
        } else if (code.intValue == SnappetRobotFinderNote_SnappetListCleared) {
            NSLog(@"Snappet list cleared");
        } else if (code.intValue == SnappetRobotFinderNote_BluetoothError) {
            NSLog(@"Snappet bluetooth error");
        } else if (code.intValue == SnappetRobotFinderNote_BluetoothIsOff) {
            NSLog(@"Snappet bluetooth is off");
        } else if (code.intValue == SnappetRobotFinderNote_BluetoothIsAvailable) {
            NSLog(@"Snappet bluetooth is on");
        }
    }
    self.loadingIndicator.hidden = YES;
    [self.tableView reloadData];
}

#pragma mark - SnappetRobotDelegate
-(void) SnappetDeviceReady:(SnappetRobot *)snappet {
    self.loadingIndicator.hidden = YES;
    NSLog(@"Snappet connected: %@", snappet.name);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) SnappetDeviceDisconnected:(SnappetRobot *)snappet error:(NSError *)error {
    self.loadingIndicator.hidden = YES;
    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:nil message:@"Device disconnected" preferredStyle:UIAlertControllerStyleAlert];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:_alert animated:YES completion:nil];
}

-(void) SnappetDeviceFailedToConnect:(SnappetRobot *)snappet error:(NSError *)error {
    self.loadingIndicator.hidden = YES;
    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"Connect failed" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:_alert animated:YES completion:nil];
}

@end
