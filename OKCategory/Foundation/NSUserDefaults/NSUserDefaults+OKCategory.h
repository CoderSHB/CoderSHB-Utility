//
//  NSUserDefaults+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (OKCategory)

/**
 *  @brief 读取信息
 */
+ (nullable id)ok_objectForKey:(NSString *)defaultName;

/**
 *  @brief 存储信息
 */
+ (void)ok_saveObject:(nullable id)value forKey:(NSString *)defaultName;

/**
 *  @brief 保存model
 */
+ (nullable id<NSCoding>)ok_modelForKey:(NSString *)defaultName;

/**
 *  @brief 存储model
 */
+ (void)ok_saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END