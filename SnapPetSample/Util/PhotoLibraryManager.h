//
//  PhotoLibraryManager.h
//  SnapPets
//
//  Created by Katy Pun on 23/12/14.
//  Copyright (c) 2014 ___WOWWEE___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoLibraryManager : NSObject

@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NSMutableArray *imageThumbnailList;
@property (nonatomic, strong) NSMutableArray *imagenameList;
@property (nonatomic, strong) NSMutableArray *imagenameThumbnailList;
@property (nonatomic, assign) int imageCount;
@property (nonatomic, assign) int latestPhotoIndex;
@property (nonatomic, assign) int numOfPhotoInSnappet;
@property (nonatomic, assign) int currentPhotoId;

+ (PhotoLibraryManager *)sharedInstance;

- (void)checkImageCount;
- (void)loadPhoto;
- (void)deletePhotoWithIndex:(int)_index;
// Generate new image filename as saving path
- (NSString*)getNextImagePath;
+ (NSString *) applicationDocumentsDirectory;
+ (NSString *) applicationDocumentsFullImageDirectory;
+ (NSString *) applicationDocumentsThumbnailDirectory;
// Save input image to app document directory
- (NSString*)saveImage:(UIImage *)img;
// Export image to camera roll
- (void)saveToCameraRoll:(UIImage *)img;
- (NSString*)saveImageToTmp:(UIImage *)img;

@end
