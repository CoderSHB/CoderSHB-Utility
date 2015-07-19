//
//  NSString+Utility.h
//  NSString+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Utility)

/**
 *  计算文件夹大小
 */
- (long long)fileSize;

/**
 *  计算字符串的尺寸
 *
 *  @param font    字符串字体的大小
 *  @param maxSize 定义字符串显示的范围
 *
 *  @return 返回字符串的size
 */
- (CGSize)sizeOfStringWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  计算字符串的高度
 * 
 *  @param font  字符串的字体
 *  @param width 字符串显示的宽度,高度默认为MAXFLOAT
 *
 *  @return 字符串的高度
 */
- (CGFloat)heightOfStringWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否为空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;

/**
 *  将汉字字符串转为拼音字符串
 *
 *  @param string 传入的汉字字符串
 *
 *  @return 返回拼音字符串
 */
+ (NSString *)transformPinyinFromString:(NSString *)string;

@end
