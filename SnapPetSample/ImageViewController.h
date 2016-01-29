//
//  ImageViewController.h
//  SnapPetSample
//
//  Created by Alex Lam on 28/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property(nonatomic, strong) UIImage* imageObject;
@property(nonatomic, weak) IBOutlet UIImageView* imageView;

@end
