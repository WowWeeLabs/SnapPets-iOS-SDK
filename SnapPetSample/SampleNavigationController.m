//
//  SampleNavigationController.m
//  SnapPetSample
//
//  Created by Alex Lam on 25/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "SampleNavigationController.h"

@implementation SampleNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //    [self.navigationController.view addSubview:HUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    if([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return(NSInteger)[self.topViewController performSelector:@selector(supportedInterfaceOrientations) withObject:nil];
    }
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate
{
    if([self.visibleViewController respondsToSelector:@selector(shouldAutorotate)])
    {
        BOOL autoRotate = (BOOL)[self.visibleViewController
                                 performSelector:@selector(shouldAutorotate)
                                 withObject:nil];
        return autoRotate;
        
    }
    return NO;
}


@end
