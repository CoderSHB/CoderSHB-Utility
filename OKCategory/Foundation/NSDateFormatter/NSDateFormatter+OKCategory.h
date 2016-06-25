//
//  NSDateFormatter+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (OKCategory)

+ (NSDateFormatter *)ok_dateFormatter;

/**
 *  @brief 获取默认格式为`yyyy-MM-dd HH:mm:ss`的NSDateFormatter对象
 */
+ (NSDateFormatter *)ok_defaultDateFormatter;
+ (NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)dateFormat;

+ (nullable NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)format
                                                timeZone:(nullable NSTimeZone *)timeZone;

+ (nullable NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)format
                                                timeZone:(nullable NSTimeZone *)timeZone
                                                  locale:(nullable NSLocale *)locale;

+ (NSDateFormatter *)ok_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;

+ (NSDateFormatter *)ok_dateFormatterWithDateStyle:(NSDateFormatterStyle)style
                                          timeZone:(nullable NSTimeZone *)timeZone;

+ (NSDateFormatter *)ok_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;

+ (NSDateFormatter *)ok_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style
                                          timeZone:(nullable NSTimeZone *)timeZone;

@end

NS_ASSUME_NONNULL_END