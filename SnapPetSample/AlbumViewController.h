//
//  AlbumViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 27/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WowweeSnappetSDK/WowweeSnappetSDK.h>

@interface AlbumViewController : UICollectionViewController <SnappetRobotDelegate>

- (IBAction)editButtonPressed;

@property (nonatomic, strong) NSMutableArray* m_arrSelected;

@end
