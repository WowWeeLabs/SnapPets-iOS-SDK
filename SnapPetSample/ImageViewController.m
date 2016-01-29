//
//  ImageViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 28/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.imageView.image = self.imageObject;
}

@end
