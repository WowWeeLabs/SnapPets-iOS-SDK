//
//  SettingViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 26/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.connectedSnappet = (SnappetRobot*)[[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
    self.connectedSnappet.delegate = self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0) {
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"Input new name" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [_alert addTextFieldWithConfigurationHandler:^(UITextField* textfield) {
            textfield.placeholder = self.connectedSnappet.name;
        }];
        [_alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            if(_alert.textFields.firstObject.text.length > 0) {
                [self.connectedSnappet snappetWriteDisplayName:_alert.textFields.firstObject.text];
                
                [tableView reloadData];
            }
        }]];
        [_alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:_alert animated:YES completion:nil];
    }
    else if(indexPath.row == 2) {
        [self.connectedSnappet snappetDeleteAllPhoto];
    }
    else if(indexPath.row == 3) {
        [self.connectedSnappet disconnect];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"nameChange"];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nameChange"];
            }
            
            cell.textLabel.text = @"Rename Snappet";
            cell.detailTextLabel.text = self.connectedSnappet.name;
            
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"systemDetails"];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"systemDetails"];
            }
            cell.textLabel.text = @"System version";
            cell.detailTextLabel.text = self.connectedSnappet.bleModuleSoftwareVersion;

            return cell;
        }
            break;
        case 2:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"deletePhoto"];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deletePhoto"];
            }
            cell.textLabel.text = @"Delete photo in snappet";
            
            return cell;
        }
            break;
        case 3:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"disconnect"];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"disconnect"];
            }
            cell.textLabel.text = @"Press to disconnect Snappet";

            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - SnappetRobotDelegate
-(void) SnappetDeviceDisconnected:(SnappetRobot *)snappet error:(NSError *)error {
    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:nil message:@"Device disconnected" preferredStyle:UIAlertControllerStyleAlert];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:_alert animated:YES completion:nil];
}

-(void) Snappet:(SnappetRobot *)snappet didReceiveGenericAccessDeviceName:(NSString *)deviceName {
    NSLog(@"Snappet didReceiveGenericAccessDeviceName: %@", deviceName);
}

-(void) Snappet:(SnappetRobot *)snappet didReceiveModuleParameterDeviceName:(NSString *)deviceName {
    NSLog(@"Snappet didReceiveModuleParameterDeviceName: %@", deviceName);
}

-(void) Snappet:(SnappetRobot *)snappet deletedPhoto:(NSArray *)photoIds {
    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:nil message:@"All photo in snappet have been deleted." preferredStyle:UIAlertControllerStyleAlert];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:_alert animated:YES completion:nil];
}

@end
