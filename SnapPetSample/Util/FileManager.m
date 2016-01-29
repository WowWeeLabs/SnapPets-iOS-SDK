//
//  FileManager.m
//  SnapPetSample
//
//  Created by Alex Lam on 25/1/2016.
//  Copyright © 2016 Wowwee. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (NSString*)defaultDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return documentsDirectory;
}

+ (NSArray*)loadDirectoryFilePaths {
    return [FileManager loadDirectoryFilePathsInDirectory:@""];
}

+ (NSArray*)loadDirectoryFilePathsInDirectory:(NSString*)_directory {
    NSString *documentsDirectory = [FileManager defaultDirectory];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", _directory]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        return [NSArray array];
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnumerator = [fm enumeratorAtURL:[NSURL URLWithString:documentsDirectory]
                                    includingPropertiesForKeys:@[ NSURLNameKey, NSURLIsDirectoryKey ]
                                                       options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                  errorHandler:nil];
    
    NSMutableArray *fileList = [NSMutableArray array];
    
    for (NSURL *theURL in dirEnumerator) {
        NSNumber *isDirectory;
        [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
        if (![isDirectory boolValue]) {
            [fileList addObject:[[theURL lastPathComponent] stringByReplacingOccurrencesOfString:@".plist" withString:@""]];
        }
    }
    return fileList;
}

+ (NSString*)generatePathName:(NSString*)_filename {
    return [FileManager generatePathName:_filename inDirectory:@""];
}

+ (NSString*)generatePathName:(NSString*)_filename inDirectory:(NSString*)_directory {
    NSError* error = nil;
    NSString *documentsDirectory = [FileManager defaultDirectory];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", _directory]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _filename]];
    return filePath;
}

+ (void)deletePathName:(NSString*)_filename {
    return [FileManager deletePathName:_filename inDirectory:@""];
}

+ (void)deletePathName:(NSString*)_filename inDirectory:(NSString*)_directory {
    NSError* error = nil;
    NSString *documentsDirectory = [FileManager defaultDirectory];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", _directory]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _filename]];
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:filePath]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (!success) {
            NSLog(@"Error removing file at path: %@", error.localizedDescription);
        }
    }
}

@end
