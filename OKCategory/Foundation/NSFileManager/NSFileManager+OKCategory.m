//
//  NSFileManager+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSFileManager+OKCategory.h"

@implementation NSFileManager (OKCategoryPrivate)

+ (NSURL *)__URLForDirectory:(NSSearchPathDirectory)directory {
    return [[NSFileManager defaultManager] URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)__pathForDirectory:(NSSearchPathDirectory)directory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    return ([paths count] > 0 ? [paths objectAtIndex:0] : @"undefined");
}

@end

@implementation NSFileManager (OKCategory)

+ (NSString *)ok_applicationPath {
    return [self __pathForDirectory:NSApplicationDirectory];
}

+ (NSURL *)ok_applicationURL {
    return [self __URLForDirectory:NSApplicationDirectory];
}

+ (NSString *)ok_documentPath {
    return [self __pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)ok_documentsURL {
    return [self __URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)ok_libraryPath {
    return [self __pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)ok_libraryURL {
    return [self __URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)ok_cachesPath {
    return [self __pathForDirectory:NSCachesDirectory];
}

+ (NSURL *)ok_cachesURL {
    return [self __URLForDirectory:NSCachesDirectory];
}

+ (NSString *)ok_libraryPreferencePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return paths.count > 0 ? [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"] : @"undefined";
}

+ (NSURL *)ok_libraryPreferenceURL {
    return [NSURL fileURLWithPath:[self ok_libraryPreferencePath] isDirectory:YES];
}

+ (NSString *)ok_tmpPath {
    return NSTemporaryDirectory();
}

+ (NSURL *)ok_tmpURL {
    return [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
}

+ (NSArray *)getAllFilesInPath:(NSString *)path {
    NSError *error    = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (error || fileList.count == 0) {
        return nil;
    }
    return fileList;
}

+ (BOOL)ok_fileIsExistsAtPath:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)ok_directoryIsExistsAtPath:(NSString *)dirpath {
    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:dirpath isDirectory:&isDir];
    return isDir;
}

+ (BOOL)ok_deleteFile:(NSString *)filePath {
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)ok_createFileAtPath:(NSString *)parentPath fileName:(NSString *)fileName {

    NSString *dir = [parentPath stringByAppendingPathComponent:fileName];
    if ([self ok_fileIsExistsAtPath:dir]) {
        return YES;
    }
    return [[NSFileManager defaultManager]createFileAtPath:dir contents:nil attributes:nil];
}

+ (BOOL)ok_createDirectoryAtPath:(NSString *)parentPath name:(NSString *)dirName {

    NSString *dir = [parentPath stringByAppendingPathComponent:dirName];
    if ([self ok_directoryIsExistsAtPath:dir]) {
        return YES;
    }
    return [[NSFileManager defaultManager] createDirectoryAtPath:dir
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:NULL];
}

+ (double)ok_availableDiskSpace {
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[self ok_documentPath] error:nil];

    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

+ (NSString *)ok_getDocumentFromFilePath:(NSString *)filePath {
    return [filePath stringByDeletingLastPathComponent];
}

+ (NSString *)ok_getFileNameFromFilePath:(NSString *)filePath {
    return [filePath lastPathComponent];
}

+ (NSString *)ok_getFileExtensionFromFilePath:(NSString *)filePath {
    return [filePath pathExtension];
}

+ (unsigned long long)ok_sizeOfFolder:(NSString *)folderPath {
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}

@end

@implementation NSFileManager (OKFileHandleCategory)

+ (BOOL)ok_moveFile:(NSString *)fileName
             atPath:(NSString *)path
         toDestFile:(NSString *)destFileName
         atDestPath:(NSString *)destPath
              error:(NSError **)error {
    
    [NSFileManager ok_createDirectoryAtPath:path name:fileName];

    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSString *destFilePath = [destPath stringByAppendingPathComponent:destFileName];
    return [[NSFileManager defaultManager] moveItemAtPath:filePath
                                                   toPath:destFilePath
                                                    error:error];
}

+ (BOOL)ok_copyFile:(NSString *)fileName
             atPath:(NSString *)path
         toDestFile:(NSString *)destFileName
         atDestPath:(NSString *)destPath
              error:(NSError **)error {
    
    [NSFileManager ok_createDirectoryAtPath:path name:fileName];

    NSString *filePath     = [path stringByAppendingPathComponent:fileName];
    NSString *destFilePath = [destPath stringByAppendingPathComponent:destFileName];

    return [[NSFileManager defaultManager] copyItemAtPath:filePath
                                                   toPath:destFilePath
                                                    error:error];
}

+ (BOOL)ok_deleteFile:(NSString *)fileName atPath:(NSString *)path error:(NSError **)error {

    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:error];
}

#pragma mark 文件读写

+ (NSData *)ok_readFile:(NSString *)fileName atPath:(NSString *)path {
    
    NSData *data;
    if (fileName && path) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];

        if ([fileManager fileExistsAtPath:filePath]) {
            data = [NSData dataWithContentsOfFile:filePath];
        }
    }
    return data;
}

+ (void)ok_writeData:(NSData *)data fileName:(NSString *)fileName atPath:(NSString *)path {
    if (data && fileName && path) {
        
        NSString *filePath = [path stringByAppendingPathComponent:fileName];

        [NSFileManager ok_createFileAtPath:path fileName:fileName];
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle truncateFileAtOffset:0];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }
}

+ (void)ok_appendWriteData:(NSData *)data fileName:(NSString *)fileName atPath:(NSString *)path {
    if (data && fileName && path) {

        NSString *filePath = [path stringByAppendingPathComponent:fileName];

        [NSFileManager ok_createFileAtPath:path fileName:fileName];

        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }
}

@end
