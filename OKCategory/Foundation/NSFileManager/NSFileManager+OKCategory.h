//
//  NSFileManager+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (OKCategory)

/**
 *  程序目录(Applications目录，即AppName.app 目录)，
 *  应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，
 *  所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。
 */
+ (NSString *)ok_applicationPath;
+ (NSURL *)ok_applicationURL;

/**
 *  文档目录(Documents目录)
 *  苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 */
+ (NSString *)ok_documentPath;
+ (NSURL *)ok_documentsURL;

/**
 *  文档目录(Library目录)
 *  存储程序的默认设置或其它状态信息
 */
+ (NSString *)ok_libraryPath;
+ (NSURL *)ok_libraryURL;

/**
 *  文档目录(Library/Caches目录)
 *  存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 */
+ (NSString *)ok_cachesPath;
+ (NSURL *)ok_cachesURL;

/**
 *  Preferences 目录包含应用程序的偏好设置文件
 *  您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
 */

+ (NSString *)ok_libraryPreferencePath;
+ (NSURL *)ok_libraryPreferenceURL;

/**
 *  提供一个即时创建临时文件的地方
 *  尽管 iCloud 不会备份这些文件，但在应用在使用完这些数据之后要注意随时删除，避免占用用户设备的空间
 */
+ (NSString *)ok_tmpPath;
+ (NSURL *)ok_tmpURL;

+ (nullable NSArray *)getAllFilesInPath:(NSString *)path;

+ (BOOL)ok_fileIsExistsAtPath:(NSString *)filePath;
+ (BOOL)ok_directoryIsExistsAtPath:(NSString *)dirpath;
+ (BOOL)ok_deleteFile:(NSString *)filePath;

/**
 *  @brief 创建文件(仅在不存在的情况下创建)
 *
 *  @param parentPath 目录位置
 *  @param FileName   文件名
 *
 *  @return 创建状态
 */
+ (BOOL)ok_createFileAtPath:(NSString *)parentPath fileName:(NSString *)fileName;

/**
 *  @brief 创建目录(仅在不存在的情况下创建)
 *
 *  @param parentPath 目录位置
 *  @param dirName    目录名
 *
 *  @return 创建状态
 */
+ (BOOL)ok_createDirectoryAtPath:(NSString *)parentPath name:(NSString *)dirName;

/**
 *  @brief 获取本地磁盘可用空间大小
 */
+ (double)ok_availableDiskSpace;

/**
 *  @brief 根据文件路径获取目录
 */
+ (NSString *)ok_getDocumentFromFilePath:(NSString *)filePath;

/**
 *  @brief 根据文件路径获取文件名(包括文件后缀)
 */
+ (NSString *)ok_getFileNameFromFilePath:(NSString *)filePath;

/**
 *  @brief 根据文件路径获取文件后缀
 */
+ (NSString *)ok_getFileExtensionFromFilePath:(NSString *)filePath;

/**
 *  计算文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 文件夹存储空间
 */
+ (unsigned long long)ok_sizeOfFolder:(NSString *)folderPath;

@end

#pragma mark - 文件的操作

@interface NSFileManager (OKFileHandleCategory)

#pragma mark 文件操作

/**
 *  @brief 剪切某个目录下的某个文件到另一个目录下
 *
 *  @param fileName     源文件名
 *  @param path         源路径
 *  @param destFileName 目标文件名
 *  @param destPath     目标路径
 *
 *  @return 移动状态
 */
+ (BOOL)ok_moveFile:(NSString *)fileName
             atPath:(NSString *)path
         toDestFile:(NSString *)destFileName
         atDestPath:(NSString *)destPath
              error:(NSError **)error;

/**
 *  @brief 复制某个目录下的某个文件到另一个目录下
 *
 *  @param fileName     源文件名
 *  @param path         源路径
 *  @param destFileName 目标文件名
 *  @param destPath     目标路径
 *
 *  @return 复制状态
 */
+ (BOOL)ok_copyFile:(NSString *)fileName
             atPath:(NSString *)path
         toDestFile:(NSString *)destFileName
         atDestPath:(NSString *)destPath
              error:(NSError **)error;

/**
 *  @brief 删除某个目录下的某个文件
 *
 *  @param fileName 目标文件名
 *  @param path     目标路径
 *
 *  @return 删除状态
 */
+ (BOOL)ok_deleteFile:(NSString *)fileName atPath:(NSString *)path error:(NSError **)error;

#pragma mark 文件读写

/**
 *  @brief 读取文件
 *
 *  @param fileName 文件名
 *  @param path     文件路径
 *
 *  @return 文件内容
 */
+ (nullable NSData *)ok_readFile:(NSString *)fileName atPath:(NSString *)path;

/**
 *  @brief 写入文件(先清除原有的文件内容，再写入新的文件内容)
 *
 *  @param data     写入内容
 *  @param fileName 文件名
 *  @param path     文件路径
 */
+ (void)ok_writeData:(NSData *)data fileName:(NSString *)fileName atPath:(NSString *)path;

/**
 *  @brief 追加写入文件
 *
 *  @param data     追加的内容
 *  @param fileName 文件名
 *  @param path     文件路径
 */
+ (void)ok_appendWriteData:(NSData *)data fileName:(NSString *)fileName atPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END