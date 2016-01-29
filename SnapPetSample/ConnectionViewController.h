//
//  ConnectionViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 25/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

@interface ConnectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SnappetRobotDelegate> {
    
}

- (IBAction)refreshButtonPressed:(id)sender;

@property (nonatomic, weak) IBOutlet UITableView* tableView;
//@property (nonatomic, strong) NSMutableArray* deviceList;
@property (nonatomic, strong) NSTimer* connectionTimer;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* loadingIndicator;

@end
