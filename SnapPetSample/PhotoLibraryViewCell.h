//
//  PhotoLibraryViewCell.h
//  SnapPetSample
//
//  Created by Alex Lam on 28/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoLibraryViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel* tickLabel;
@property (nonatomic, weak) IBOutlet UIImageView* photoImageView;

@end
