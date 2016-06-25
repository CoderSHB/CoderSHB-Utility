//
//  NSDateFormatter+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//


#import "NSDateFormatter+OKCategory.h"

@implementation NSDateFormatter (OKCategory)

+ (NSDateFormatter *)ok_dateFormatter {
    return [[self alloc] init];
}

+ (NSDateFormatter *)ok_defaultDateFormatter {
    return [self ok_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    return [self ok_dateFormatterWithFormat:format timeZone:timeZone locale:nil];
}

+ (NSDateFormatter *)ok_dateFormatterWithFormat:(NSString *)format
                                       timeZone:(NSTimeZone *)timeZone
                                         locale:(NSLocale *)locale {
    
    if (!format || [format isEqualToString:@""]) return nil;
    
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-tz-%@-fmt-%@-loc-%@", [timeZone abbreviation], format, [locale localeIdentifier]];
    NSMutableDictionary *dictionary    = [[NSThread currentThread] threadDictionary];
    NSDateFormatter     *dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (locale != nil) [dateFormatter setLocale:locale]; // this may change so don't cache
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change
    return dateFormatter;
}

+ (NSDateFormatter *)ok_dateFormatterWithDateStyle:(NSDateFormatterStyle)style {
    return [self ok_dateFormatterWithDateStyle:style timeZone:nil];
}

+ (NSDateFormatter *)ok_dateFormatterWithDateStyle:(NSDateFormatterStyle)style
                                          timeZone:(NSTimeZone *)timeZone {
    
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-dateStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone];
    return dateFormatter;
}

+ (NSDateFormatter *)ok_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style {
    return [self ok_dateFormatterWithTimeStyle:style timeZone:nil];
}

+ (NSDateFormatter *)ok_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style
                                          timeZone:(NSTimeZone *)timeZone {
    
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-timeStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone];
    return dateFormatter;
}

@end
