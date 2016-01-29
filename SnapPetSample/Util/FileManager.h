//
//  FileManager.h
//  SnapPetSample
//
//  Created by Alex Lam on 25/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (NSString*)defaultDirectory;
+ (NSArray*)loadDirectoryFilePaths;
+ (NSArray*)loadDirectoryFilePathsInDirectory:(NSString*)_directory;
+ (NSString*)generatePathName:(NSString*)_filename;
+ (NSString*)generatePathName:(NSString*)_filename inDirectory:(NSString*)_directory;
+ (void)deletePathName:(NSString*)_filename;
+ (void)deletePathName:(NSString*)_filename inDirectory:(NSString*)_directory;

@end
