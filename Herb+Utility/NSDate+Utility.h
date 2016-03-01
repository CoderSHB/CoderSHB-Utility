//
//  NSDate+Utility.h
//  NSDate+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个(格式为yyyy-MM-dd)的当前时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  返回一个(格式为yyyy-MM-dd)的时间
 */
/**
 *  根据传入的时间格式返回格式化之后的时间
 *
 *  @param fmt 时间格式 e.g yyyy-MM-dd
 *
 *  @return 返回格式化之后的时间
 */
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;

/**
 *  根据传入的时间字符串和时间格式 得出返回(刚刚,几分钟前,几小时前,昨天,月日时间,年月日)字符串时间格式
 *
 *  @param dateString 传入的时间字符串
 *  @param dateFormat 传入的时间格式
 *
 *  @return 返回格式化处理之后的字符串时间
 */
+ (NSString *)stringWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/**
 *  获取格式化好的今日日期
 *
 *  @param dateString 日期字符串 yyyy-MM-dd
 *
 *  @return 格式化的当天日期   yyyy-MM-dd
 */
+(NSString *)stringWithDateOfToday;

@end
