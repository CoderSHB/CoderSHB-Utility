//
//  NSString+Utility.m
//  NSString+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import "NSString+Utility.h"

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

@implementation NSString (SHB)

- (long long)fileSize
{
  NSFileManager *mgr = [NSFileManager defaultManager];
  BOOL isDirectory = NO;
  BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];

  if (fileExists == NO) return 0;

  if (isDirectory) {
    NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
    long long totalSize = 0;
    for (NSString *subpath in subpaths) {
      NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
      totalSize += [fullSubpath fileSize];
    }
    return totalSize;
  } else {
    NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
    return [attr[NSFileSize] longLongValue];
  }
}

- (CGSize)sizeOfStringWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
  NSDictionary *fontDict = @{NSFontAttributeName : font};
  
  if (iOS7) {
    CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    return rect.size;
  } else {
    return [self sizeWithFont:font constrainedToSize:maxSize];
  }
}

- (CGFloat)heightOfStringWithFont:(UIFont *)font width:(CGFloat)width
{
  NSDictionary *fontDict = @{NSFontAttributeName : font};
  CGSize maxSize = CGSizeMake(width, MAXFLOAT);
  
  if (iOS7) {
    CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    return rect.size.height;
  } else {
    return [self sizeWithFont:font constrainedToSize:maxSize].height;
  }
}

- (NSString *)trimString
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmptyString
{
  return (self == nil || self.length == 0);
}

- (void)saveToNSDefaultsWithKey:(NSString *)key
{
  [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)transformPinyinFromString:(NSString *)string
{
    NSMutableString *stringM = [NSMutableString stringWithString:string];
    CFMutableStringRef stringRef = (__bridge CFMutableStringRef)stringM;
    
    CFStringTransform(stringRef, nil, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(stringRef, nil, kCFStringTransformStripDiacritics, NO);
    
    string = (__bridge NSString *)stringRef;
    return string.lowercaseString;
}

@end
