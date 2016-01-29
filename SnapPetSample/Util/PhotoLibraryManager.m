//
//  PhotoLibraryManager.m
//  SnapPets
//
//  Created by Katy Pun on 23/12/14.
//  Copyright (c) 2014 ___WOWWEE___. All rights reserved.
//

#import "PhotoLibraryManager.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface PhotoLibraryManager()
@property (nonatomic, strong) ALAssetsLibrary* library;
@end

@implementation PhotoLibraryManager

static PhotoLibraryManager *instance = nil;

+ (PhotoLibraryManager *)sharedInstance {
    if(!instance) {
        instance = [[PhotoLibraryManager alloc] init];
    }
    return instance;
}

-(id)init{
    if (self == nil){
        self = [PhotoLibraryManager new];
    }
    self.library = [[ALAssetsLibrary alloc] init];
    self.imageList = [NSMutableArray new];
    self.imageThumbnailList = [NSMutableArray new];
    self.imagenameList = [NSMutableArray new];
    self.imagenameThumbnailList = [NSMutableArray new];
    self.imageCount = 0;
    
    self.latestPhotoIndex = 0;
    BOOL isDirectory = YES;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:[PhotoLibraryManager applicationDocumentsFullImageDirectory] isDirectory:&isDirectory];
    if (!exists) {
        NSError* error;
        [[NSFileManager defaultManager] createDirectoryAtPath:[PhotoLibraryManager applicationDocumentsFullImageDirectory]
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    }
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[PhotoLibraryManager applicationDocumentsThumbnailDirectory] isDirectory:&isDirectory];
    if (!exists) {
        NSError* error;
        [[NSFileManager defaultManager] createDirectoryAtPath:[PhotoLibraryManager applicationDocumentsThumbnailDirectory]
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    }
    
    //image in snappet
    
    
    //image from app photo library
    NSString* imageListPath = [PhotoLibraryManager applicationDocumentsFullImageDirectory];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageListPath error:NULL];
    
    NSMutableArray *tmpArr = [NSMutableArray new];
    NSMutableArray *tmpNameArr = [NSMutableArray new];
    for (int i = 0; i < [files count]; i++){
        [tmpArr addObject: [NSNull null]];
        [tmpNameArr addObject:@""];
    }
    for (NSString* file in files) {
        if ([file.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [file.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            if ([file rangeOfString:@"Snappet_"].location == NSNotFound) {
                continue;
            }
            
            NSRange endRange = [file rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [file rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [file substringWithRange:searchRange];
            int fileNum = [fileNumString intValue];
            NSString *fullPath = [imageListPath stringByAppendingPathComponent:file];
            NSLog(@"%d %@",fileNum,fullPath);
            if (fileNum > [tmpArr count]){
                [tmpArr addObject:[UIImage imageWithContentsOfFile:fullPath]];
                [tmpNameArr addObject:fullPath];
            }else{
                [tmpArr replaceObjectAtIndex:fileNum-1 withObject:[UIImage imageWithContentsOfFile:fullPath] ];
                [tmpNameArr replaceObjectAtIndex:fileNum-1 withObject:fullPath];
            }
            
            
            if (fileNum > self.latestPhotoIndex){
                self.latestPhotoIndex = fileNum;
            }
        }
    }
    
    return self;
}

- (void)checkImageCount
{
     NSMutableArray* imagenameList = [NSMutableArray new];
    
    //image from app photo library
    NSString* imageListPath = [PhotoLibraryManager applicationDocumentsFullImageDirectory];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageListPath error:NULL];
    
    NSMutableArray *tmpNameArr = [NSMutableArray new];
    for (int i = 0; i < [files count]; i++){
        [tmpNameArr addObject:@""];
    }
    files = [files sortedArrayUsingComparator:^NSComparisonResult(NSString *firstString, NSString *secondString) {
        if (([firstString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [firstString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)
            && ([secondString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [secondString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)) {
            if ([firstString rangeOfString:@"Snappet_"].location == NSNotFound || [secondString rangeOfString:@"Snappet_"].location == NSNotFound) {
                return NO;
            }
            NSRange endRange = [firstString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [firstString rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [firstString substringWithRange:searchRange];
            int firstFileNum = [fileNumString intValue];
            
            endRange = [secondString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [secondString rangeOfString:@".jpg"];
            }
            searchRange = NSMakeRange(8, endRange.location - 8);
            fileNumString = [secondString substringWithRange:searchRange];
            int secondFileNum = [fileNumString intValue];
            return firstFileNum > secondFileNum;
        }
        return NO;
    }];
    for (NSString* file in files) {
        if ([file.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [file.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            if ([file rangeOfString:@"Snappet_"].location == NSNotFound) {
                continue;
            }
            
            NSRange endRange = [file rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [file rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [file substringWithRange:searchRange];
            int fileNum = [fileNumString intValue];
            NSString *fullPath = [imageListPath stringByAppendingPathComponent:file];
            NSLog(@"%d %@",fileNum,fullPath);
            if (fileNum > [tmpNameArr count]){
                [tmpNameArr addObject:fullPath];
            }else{
                [tmpNameArr replaceObjectAtIndex:fileNum-1 withObject:fullPath];
            }
        }
    }
    
    //sort by file name index
    for (int i = 0; i < [tmpNameArr count]; i++){
        if (![[tmpNameArr objectAtIndex:i] isEqualToString:@""]) {
            [imagenameList addObject:[tmpNameArr objectAtIndex:i]];
        }
    }
    self.imageCount = (int)[imagenameList count];
}

- (void)loadPhoto
{
    if (self.imageList == nil) {
        self.imageList = [NSMutableArray new];
        self.imageThumbnailList = [NSMutableArray new];
        self.imagenameList = [NSMutableArray new];
        self.imagenameThumbnailList = [NSMutableArray new];
    }else{
        [self.imageList removeAllObjects];
        [self.imageThumbnailList removeAllObjects];
        [self.imagenameList removeAllObjects];
        [self.imagenameThumbnailList removeAllObjects];
    }
    self.latestPhotoIndex = 0;
    
    //image in snappet
    
    
    //image from app photo library
    NSString* imageListPath = [PhotoLibraryManager applicationDocumentsFullImageDirectory];
    NSString* imageThumbnailListPath = [PhotoLibraryManager applicationDocumentsThumbnailDirectory];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageListPath error:NULL];
    NSArray *filesThumbnail = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageThumbnailListPath error:NULL];
    
    NSMutableArray *tmpArr = [NSMutableArray new];
    NSMutableArray *tmpThumbnailArr = [NSMutableArray new];
    NSMutableArray *tmpNameArr = [NSMutableArray new];
    NSMutableArray *tmpNameThumbnailArr = [NSMutableArray new];
    for (int i = 0; i < [files count]; i++){
        [tmpArr addObject: [NSNull null]];
        [tmpThumbnailArr addObject:[NSNull null]];
        [tmpNameArr addObject:@""];
        [tmpNameThumbnailArr addObject:@""];
    }
    files = [files sortedArrayUsingComparator:^NSComparisonResult(NSString *firstString, NSString *secondString) {
        if (([firstString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [firstString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)
            && ([secondString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [secondString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)) {
            if ([firstString rangeOfString:@"Snappet_"].location == NSNotFound || [secondString rangeOfString:@"Snappet_"].location == NSNotFound) {
                return NO;
            }
            NSRange endRange = [firstString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [firstString rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [firstString substringWithRange:searchRange];
            int firstFileNum = [fileNumString intValue];
            
            endRange = [secondString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [secondString rangeOfString:@".jpg"];
            }
            searchRange = NSMakeRange(8, endRange.location - 8);
            fileNumString = [secondString substringWithRange:searchRange];
            int secondFileNum = [fileNumString intValue];
            return firstFileNum > secondFileNum;
        }
        return NO;
    }];
    for (NSString* file in files) {
        if (([file.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [file.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)) {
            if ([file rangeOfString:@"Snappet_"].location == NSNotFound) {
                continue;
            }
            
            NSRange endRange = [file rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [file rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [file substringWithRange:searchRange];
            int fileNum = [fileNumString intValue];
            NSString *fullPath = [imageListPath stringByAppendingPathComponent:file];
            if (fileNum > [tmpArr count]){
//                NSLog(@"Load new image %d %@",fileNum,fullPath);
                [tmpArr addObject:[UIImage imageWithContentsOfFile:fullPath]];
                [tmpNameArr addObject:fullPath];
            }else{
//                NSLog(@"Replace image %d %@",fileNum,fullPath);
                [tmpArr replaceObjectAtIndex:fileNum-1 withObject:[UIImage imageWithContentsOfFile:fullPath]];
                [tmpNameArr replaceObjectAtIndex:fileNum-1 withObject:fullPath];
            }
            
            
            if (fileNum > self.latestPhotoIndex){
                self.latestPhotoIndex = fileNum;
            }
        }
    }
    
    filesThumbnail = [filesThumbnail sortedArrayUsingComparator:^NSComparisonResult(NSString *firstString, NSString *secondString) {
        if (([firstString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [firstString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)
            && ([secondString.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [secondString.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame)) {
            if ([firstString rangeOfString:@"Snappet_"].location == NSNotFound || [secondString rangeOfString:@"Snappet_"].location == NSNotFound) {
                return NO;
            }
            NSRange endRange = [firstString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [firstString rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [firstString substringWithRange:searchRange];
            int firstFileNum = [fileNumString intValue];
            
            endRange = [secondString rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [secondString rangeOfString:@".jpg"];
            }
            searchRange = NSMakeRange(8, endRange.location - 8);
            fileNumString = [secondString substringWithRange:searchRange];
            int secondFileNum = [fileNumString intValue];
            return firstFileNum > secondFileNum;
        }
        return NO;
    }];
    for (NSString* file in filesThumbnail) {
        if ([file.pathExtension compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame || [file.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            if ([file rangeOfString:@"Snappet_"].location == NSNotFound) {
                continue;
            }
            
            NSRange endRange = [file rangeOfString:@".png"];
            if(endRange.location == NSNotFound) {
                endRange = [file rangeOfString:@".jpg"];
            }
            NSRange searchRange = NSMakeRange(8, endRange.location - 8);
            NSString* fileNumString = [file substringWithRange:searchRange];
            int fileNum = [fileNumString intValue];
            NSString *fullPath = [imageThumbnailListPath stringByAppendingPathComponent:file];
            if (fileNum > [tmpThumbnailArr count]){
//                NSLog(@"Load New thumbnail: %d %@",fileNum,fullPath);
                [tmpThumbnailArr addObject:[UIImage imageWithContentsOfFile:fullPath]];
                [tmpNameThumbnailArr addObject:fullPath];
            }else{
//                NSLog(@"Replace thumbnail: %d %@",fileNum,fullPath);
                [tmpThumbnailArr replaceObjectAtIndex:fileNum-1 withObject:[UIImage imageWithContentsOfFile:fullPath]];
                [tmpNameThumbnailArr replaceObjectAtIndex:fileNum-1 withObject:fullPath];
            }
            
            if (fileNum > self.latestPhotoIndex){
                self.latestPhotoIndex = fileNum;
            }
        }
    }
    
    //sort by file name index
    for (int i = 0; i < [tmpArr count]; i++){
        if ([tmpArr objectAtIndex:i] != [NSNull null]){
            [self.imageList addObject:[tmpArr objectAtIndex:i]];
            [self.imagenameList addObject:[tmpNameArr objectAtIndex:i]];
        }
    }
    for (int i = 0; i < [tmpThumbnailArr count]; i++){
        if ([tmpThumbnailArr objectAtIndex:i] != [NSNull null]){
            [self.imageThumbnailList addObject:[tmpThumbnailArr objectAtIndex:i]];
            [self.imagenameThumbnailList addObject:[tmpNameThumbnailArr objectAtIndex:i]];
        }
    }
    NSLog(@"Count: %d", (int)[tmpArr count]);
}

- (void)deletePhotoWithIndex:(int)_index {
    [[NSFileManager defaultManager] removeItemAtPath:[self.imagenameList objectAtIndex:_index] error:NULL];
    [[NSFileManager defaultManager] removeItemAtPath:[self.imagenameThumbnailList objectAtIndex:_index] error:NULL];
    NSLog(@"Delete file: %@", [self.imagenameList objectAtIndex:_index]);
    NSString* str = [self.imagenameList objectAtIndex:_index];
    [self.imagenameList removeObject:str];
    UIImage* img = [self.imageList objectAtIndex:_index];
    [self.imageList removeObject:img];
    
    str = [self.imagenameThumbnailList objectAtIndex:_index];
    [self.imagenameThumbnailList removeObject:str];
    img = [self.imageThumbnailList objectAtIndex:_index];
    [self.imageThumbnailList removeObject:img];
}

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (NSString *) applicationDocumentsFullImageDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [NSString stringWithFormat:@"%@/fullimage", basePath];
}

+ (NSString *) applicationDocumentsThumbnailDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [NSString stringWithFormat:@"%@/thumbnail", basePath];
}

- (NSString*)getNextImagePath
{
    NSString* paths = [PhotoLibraryManager applicationDocumentsFullImageDirectory];
    NSMutableString *pth = [NSMutableString stringWithFormat:@"%@/Snappet_%d.jpg", paths, (self.latestPhotoIndex + 1)];

    return pth;
}

- (NSString*)getNextImageThumbnailPath
{
    NSString* paths = [PhotoLibraryManager applicationDocumentsThumbnailDirectory];
    NSMutableString *pth = [NSMutableString stringWithFormat:@"%@/Snappet_%d.jpg", paths, (self.latestPhotoIndex + 1)];
    
    return pth;
}

- (UIImage*)getThumnailImage:(UIImage*)img {
    UIImage *originalImage = img;
    float thumbnailWidth = [[UIScreen mainScreen] bounds].size.width/2;
    float widthRatio = thumbnailWidth / [img size].width;
    CGSize destinationSize = CGSizeMake([img size].width*widthRatio, [img size].height*widthRatio);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString*)saveImage:(UIImage *)img{
    if (img){
        NSString *filePath = [self getNextImagePath];
        NSString *fileThumbnailPath = [self getNextImageThumbnailPath];
        
        // Write image in background thread for faster respond time
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            UIImage* imgThumbnail = [self getThumnailImage:img];
//            NSData *data = UIImagePNGRepresentation(img);
//            NSData *dataThumbnail = UIImagePNGRepresentation(imgThumbnail);
            NSData *data = UIImageJPEGRepresentation(img, 1.0);
            NSData *dataThumbnail = UIImageJPEGRepresentation(imgThumbnail, 1.0);
            BOOL isSuccess = [data writeToFile:filePath atomically:YES];
            isSuccess = [dataThumbnail writeToFile:fileThumbnailPath atomically:YES];
            
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                [self.imageList addObject:[UIImage imageWithContentsOfFile:filePath]];
                [self.imageThumbnailList addObject:[UIImage imageWithContentsOfFile:fileThumbnailPath]];
                
                [self.imagenameList addObject:filePath];
                [self.imagenameThumbnailList addObject:fileThumbnailPath];
                self.latestPhotoIndex += 1;
            });
        });
        return filePath;
    }
    return nil;
}

- (NSString*)saveImageToTmp:(UIImage *)img {
    NSString* paths = [PhotoLibraryManager applicationDocumentsDirectory];
//    NSMutableString *pth = [NSMutableString stringWithFormat:@"%@/tmp.png", paths];
//    NSData *data = UIImagePNGRepresentation(img);
    
    NSMutableString *pth = [NSMutableString stringWithFormat:@"%@/tmp.jpg", paths];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    
    NSString *filePath = pth;
    [data writeToFile:filePath atomically:YES];

    return filePath;
}


- (void)saveToCameraRoll:(UIImage *)img {
    [self.library saveImage:img toAlbum:@"Snappets" withCompletionBlock:^(NSError *error) {
        if (error) {
//            [UIAlertView showWithTitle:[[LocalizationManager getInstance] getStringWithKey:@"save_error"]
//                               message:[NSString stringWithFormat:@"%@: %@", [[LocalizationManager getInstance] getStringWithKey:@"Failed with error"], error]
//                     cancelButtonTitle:[[LocalizationManager getInstance] getStringWithKey:@"close"]
//                     otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//                         
//                     }];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Success"
                                                                message:@"Photo has been saved to your photo album."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
            [alertView show];
//            [UIAlertView showWithTitle:[[LocalizationManager getInstance] getStringWithKey:@"save_success"]
//                               message:[[LocalizationManager getInstance] getStringWithKey:@"photo_has_been_saved_to_your_photo_album"]
//                     cancelButtonTitle:[[LocalizationManager getInstance] getStringWithKey:@"close"]
//                     otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//                         
//                     }];
        }
    }];
}

@end
