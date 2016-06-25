//
//  NSString+OKMIME
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OKMIME)

/**
 *  根据文件url 返回对应的MIMEType
 *
 *  @return MIMEType
 */
- (NSString *)ok_MIMEType;

/**
 *  根据文件url后缀 返回对应的MIMEType
 *
 *  @return MIMEType
 */
+ (NSString *)ok_MIMETypeForExtension:(NSString *)extension;

/**
 *  常见MIME集合
 *
 *  @return 常见MIME集合
 */
+ (NSDictionary *)ok_MIMEDict;

@end

NS_ASSUME_NONNULL_END