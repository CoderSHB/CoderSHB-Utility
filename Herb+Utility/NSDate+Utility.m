//
//  NSDate+Utility.m
//  NSDate+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)

- (BOOL)isToday
{
  NSCalendar *calendar = [NSCalendar currentCalendar];
  int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
  
  NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
  NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
  
  return
  (selfCmps.year == nowCmps.year) &&
  (selfCmps.month == nowCmps.month) &&
  (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterday
{
  NSDate *nowDate = [[NSDate date] dateWithYMD];
  NSDate *selfDate = [self dateWithYMD];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
  return cmps.day == 1;
}

- (BOOL)isThisYear
{
  NSCalendar *calendar = [NSCalendar currentCalendar];
  int unit = NSCalendarUnitYear;
  
  NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
  
  NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
  
  return nowCmps.year == selfCmps.year;
}

- (NSDate *)dateWithYMD
{
  return [self dateWithDateFormat:@"yyyy-MM-dd"];
}

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = dateFormat;
  
  NSString *selfStr = [fmt stringFromDate:self];
  
  return [fmt dateFromString:selfStr];
}

- (NSDateComponents *)deltaWithNow
{
  NSCalendar *calendar = [NSCalendar currentCalendar];
  int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
  
  return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

+ (NSString *)stringWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = dateFormat;
  
  NSDate *createDate = [fmt dateFromString:dateString];
  
  if ([createDate isThisYear]) {
    if ([createDate isToday]) {
      NSDateComponents *cmps = [createDate deltaWithNow];
      if (cmps.hour >= 1) {
        return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
      } else if (cmps.minute >= 1) {
        return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
      } else {
        return @"刚刚";
      }
    } else if ([createDate isYesterday]) {
      fmt.dateFormat = @"昨天 HH:mm";
      return [fmt stringFromDate:createDate];
    } else {
      fmt.dateFormat = @"MM-dd HH:mm";
      return [fmt stringFromDate:createDate];
    }
  } else {
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:createDate];
  }
}

+ (NSString *)stringWithDateOfToday
{
  NSDate *nowDate=[NSDate date];
  
  NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
  [dateformatter setDateFormat:@"yyyy-MM-dd"];
  
  NSString *locationString=[dateformatter stringFromDate:nowDate];
  
  return locationString;
}

@end
