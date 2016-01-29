//
//  AlbumViewController.m
//  SnapPetSample
//
//  Created by Alex Lam on 27/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "AlbumViewController.h"
#import "PhotoLibraryManager.h"
#import "PhotoLibraryViewCell.h"
#import "ImageViewController.h"

@interface AlbumViewController ()
@property(nonatomic, strong) NSMutableData* receivedData;
@property(nonatomic, assign) int photoLength;

@property(nonatomic, strong) SnappetRobot* connectingRobot;
@property(nonatomic, assign) int downloadPhotoIndex;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.m_arrSelected = [NSMutableArray new];
    // Load image from local storage (document directory)
    [[PhotoLibraryManager sharedInstance] loadPhoto];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([SnappetRobotFinder sharedInstance].snappetsConnected.count > 0) {
        self.connectingRobot = [[SnappetRobotFinder sharedInstance].snappetsConnected objectAtIndex:0];
        self.connectingRobot.delegate = self;
        // Retrieve the number of photo storing in snappet
        [self.connectingRobot snappetReadNumberOfPhotos];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.connectingRobot) {
        [self.connectingRobot stopTransfer];
    }
}

- (IBAction)editButtonPressed{
    if(self.collectionView.allowsMultipleSelection) {
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
        self.navigationItem.rightBarButtonItem = btn;
        
        
        NSArray* arr = [self.collectionView indexPathsForSelectedItems];
        arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger r1 = [obj1 row];
            NSInteger r2 = [obj2 row];
            if (r1 > r2) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if (r1 < r2) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        for(int i=[arr count]-1; i>=0; i--) {
            NSIndexPath* path = [arr objectAtIndex:i];
            [[PhotoLibraryManager sharedInstance] deletePhotoWithIndex:path.row];
        }
        
        self.collectionView.allowsMultipleSelection = NO;
        [self.collectionView reloadData];
    }
    else {
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(editButtonPressed)];
        self.navigationItem.rightBarButtonItem = btn;

        self.collectionView.allowsMultipleSelection = YES;
        [self.m_arrSelected removeAllObjects];
        for(int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
            [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
            PhotoLibraryViewCell *photoCell = (PhotoLibraryViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            photoCell.tickLabel.hidden = YES;
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return [[PhotoLibraryManager sharedInstance].imageList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoLibraryViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoviewcell" forIndexPath:indexPath];
    
    [photoCell.photoImageView setImage:[[PhotoLibraryManager sharedInstance].imageThumbnailList objectAtIndex:indexPath.row]];
    if ([[photoCell viewWithTag:100] isKindOfClass:[UIImageView class]]) {
        UIImageView *recipeImageView = (UIImageView *)[photoCell viewWithTag:100];
        recipeImageView.image = [[PhotoLibraryManager sharedInstance].imageThumbnailList objectAtIndex:indexPath.row];
    }
    photoCell.tickLabel.hidden = YES;
    
    return photoCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenBounds = [UIScreen mainScreen].bounds.size;
    if (screenBounds.height == 1024 || screenBounds.height == 2048) {
        return CGSizeMake(230.0f, 230.0f);
    }
    else
        return CGSizeMake(100.0f, 100.0f);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.collectionView.allowsMultipleSelection) {
        PhotoLibraryViewCell* cell = (PhotoLibraryViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.tickLabel.hidden = NO;
        
        [self.m_arrSelected addObject:[NSNumber numberWithLong:indexPath.row]];
    }
    else {
        ImageViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
        [controller setImageObject:[[PhotoLibraryManager sharedInstance].imageList objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.collectionView.allowsMultipleSelection) {
        PhotoLibraryViewCell* cell = (PhotoLibraryViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.tickLabel.hidden = YES;
        
        for(int i=0; i<[self.m_arrSelected count]; i++) {
            if(((NSNumber*)[self.m_arrSelected objectAtIndex:i]).integerValue == indexPath.row) {
                [self.m_arrSelected removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self viewDidLayoutSubviews];
}

#pragma mark - SnappetRobotDelegate
-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoLength:(int)photoLength checksum:(uint8_t)checksum {
    self.receivedData = [NSMutableData new];
    self.photoLength = photoLength;

    if (photoLength > 0 && [PhotoLibraryManager sharedInstance].numOfPhotoInSnappet > 0){
        //        [SVProgressHUD show];
    }
}

-(void) Snappet:(SnappetRobot *)snappet didReceivePhotoBlob:(NSData *)blobData {
    [_receivedData appendData:blobData];
    int receivedLength = (int)[_receivedData length];
    if(receivedLength > 0 && receivedLength == _photoLength) {
        NSMutableData *finalData = [NSMutableData new];
        NSData *headerData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jpgheader.dat" ofType:nil]];
        [finalData appendData:headerData];
        [finalData appendData:_receivedData];
        
        // Finish receiving photo
        UIImage *image = [UIImage imageWithData:finalData];
        
        // Save to app album
        [[PhotoLibraryManager sharedInstance] saveImage:image];
        // Delete from snappet afterward
        uint8_t photoIdByte = (uint8_t)(1);
        [self.connectingRobot snappetDeletePhoto:photoIdByte];
        
        // Reload the collection view to display new photo
        [self.collectionView reloadData];
        
        if ([PhotoLibraryManager sharedInstance].currentPhotoId+1 == [PhotoLibraryManager sharedInstance].numOfPhotoInSnappet) {
            // Downloaded all photo from snappet
            self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Download completed"];
        }else{
            self.downloadPhotoIndex++;
            // Get next photo from snappet
            [PhotoLibraryManager sharedInstance].currentPhotoId++;
            
            uint8_t photoIdByte = (uint8_t)(1);
            [self.connectingRobot snappetGetPhoto:kSnappetPhotoLargeSize photoID:photoIdByte];
            
            self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Downloaded %d/%d", self.downloadPhotoIndex, [PhotoLibraryManager sharedInstance].numOfPhotoInSnappet];
        }
    }
    
    
}


-(void) SnappetDeviceDisconnected:(SnappetRobot *)snappet error:(NSError *)error {
    self.connectingRobot = nil;
}

-(void) Snappet:(SnappetRobot *)snappet didReceiveNumberOfPhoto:(int)numberOfPhoto {
    [PhotoLibraryManager sharedInstance].numOfPhotoInSnappet = numberOfPhoto;
    // Start downloading images if any photo is in snappet storage
    if (numberOfPhoto > 0) {
        [PhotoLibraryManager sharedInstance].currentPhotoId = 0;
        uint8_t photoIdByte = (uint8_t)([PhotoLibraryManager sharedInstance].currentPhotoId+1);
        [self.connectingRobot snappetGetPhoto:kSnappetPhotoLargeSize photoID:photoIdByte];
        
        self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"About to download %d photos", numberOfPhoto];
        self.downloadPhotoIndex = 0;
    }
}

@end
