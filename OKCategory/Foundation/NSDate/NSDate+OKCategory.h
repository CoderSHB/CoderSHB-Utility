//
//  NSDate+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - seconds
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_MINUTE;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_HOUR;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_DAY;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_WEEK;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_MONTH;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDS_TWENTY_EIGHT_DAYS;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDKS_THIRTY_DAYS;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDKS_THIRTY_ONE_DAYS;
FOUNDATION_EXTERN const NSTimeInterval OK_SECONDKS_YEAR;

@interface NSDate (OKCategory)

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述
- (NSString *)minuteDescription;/*精确到分钟的日期描述*/
- (NSString *)formattedTime;
- (NSString *)formattedDateDescription;//格式化日期描述

- (double)  timeIntervalSince1970InMilliSecond;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)formattedTimeFromTimeInterval:(long long)time;
// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;
/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL)isInFuture;
- (BOOL)isInPast;
- (BOOL)isLeapYear;

// Date roles
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;

// Adjusting dates
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@property (readonly) NSInteger daysInYear;
/// 获取该日期是该年的第几周
@property (readonly) NSInteger weekOfYear;
/// 返回当前月一共有几周(可能为4,5,6)
@property (readonly) NSInteger weeksOfMonth;
/// 获取该月的第一天的日期
@property (readonly) NSDate *begindayOfMonth;
/// 获取该月的最后一天的日期
@property (readonly) NSDate *lastdayOfMonth;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

// Formatting hints
typedef enum {
    DateFormatHintNone,
    DateFormatHintRFC822,
    DateFormatHintRFC3339
} DateFormatHint;

// A category to parse internet date & time strings
@interface NSDate (OKInternetDateTime)

// Get date from RFC3339 or RFC822 string
// - A format/specification hint can be used to speed up,
//   otherwise both will be attempted in order to get a date
+ (NSDate *)dateFromInternetDateTimeString:(NSString *)dateString
                                formatHint:(DateFormatHint)hint;

// Get date from a string using a specific date specification
+ (nullable NSDate *)dateFromRFC3339String:(NSString *)dateString;
+ (nullable NSDate *)dateFromRFC822String:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END