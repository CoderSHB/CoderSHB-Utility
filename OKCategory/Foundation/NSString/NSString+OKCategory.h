//
//  NSString+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OKCategory)

- (BOOL)ok_isNull;
- (BOOL)ok_isEmpty;
- (BOOL)ok_isEmptyAfterTrim;

/// 是否以英文字母开头
- (BOOL)ok_isStartsWithACapitalLetter;

/// 计算字符个数
- (NSUInteger)ok_countNumberOfWords;

/// 获取字符串(或汉字)首字母
- (NSString *)ok_firstCharacter;

/// 反转字符串
- (NSString *)ok_reverseString;

/// 移除字串
- (NSString *)ok_removeSubString:(NSString *)subString;

- (BOOL)ok_containsOnlyLetters;
- (BOOL)ok_containsOnlyNumbers;
- (BOOL)ok_containsOnlyNumbersAndLetters;

- (CGFloat)ok_widthWithFont:(UIFont *)font containerHeight:(CGFloat)containerHeight;
- (CGFloat)ok_heightWithFont:(UIFont *)font containerWidth:(CGFloat)containerWidth;

/**
 *  计算字符串高度
 *
 *  @param font          字体大小
 *  @param containerSize 字体显示的区域
 *
 *  @return 字符串占用的区域
 */
- (CGSize)ok_sizeWithFont:(UIFont *)font containerSize:(CGSize)containerSize;

@end

@interface NSString (OKCategory_SafeAccess)

/**
 *  是否包含string <兼容iOS7以下>
 */
- (BOOL)ok_containsString:(NSString *)string;

/**
 *  截取字符串
 *
 *  @param range 截取长度
 *
 *  @return 截取之后的字符串
 */
- (NSString *)ok_substringWithRange:(NSRange)range;

@end

#pragma mark - NSString OKTrims

@interface NSString (OKCategory_Trims)

/**
 *  去除字符串空格
 */
- (NSString *)ok_trimmingWhitespace;

/**
 *  去除字符串空格与空行
 */
- (NSString *)ok_trimmingWhitespaceAndNewlines;

/**
 *  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)ok_stringByStrippingHTML;

/**
 *  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)ok_stringByRemovingScriptsAndStrippingHTML;

@end

@interface NSString (OKCategory_Base64)
#pragma mark - URL Encoding and Decoding

- (NSString *)ok_URLEncode;

- (NSString *)ok_URLEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)ok_URLDecode;

- (NSString *)ok_URLDecodeUsingEncoding:(NSStringEncoding)encoding;

+ (NSString *)ok_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)ok_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)ok_base64EncodedString;
- (NSString *)ok_base64DecodedString;
- (NSData *)ok_base64DecodedData;

@end

#pragma mark OKCategory_Encrypt

@interface NSString (OKCategory_Encrypt)
- (NSString *)ok_MD5;
@end

NS_ASSUME_NONNULL_END
