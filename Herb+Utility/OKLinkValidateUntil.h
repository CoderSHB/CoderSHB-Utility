//
//  OKLinkValidateUntil.h
//  OKLinkMagent
//
//  Created by 李昊 on 14/12/26.
//  Copyright (c) 2014年 OKLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKLinkValidateUntil : NSObject

/** 符号验证 */
+ (BOOL) validatePunctuate:(NSString *)punctuate;

/** 邮箱验证 */
+ (BOOL) validateEmail:(NSString *)email;

/** 手机号码验证 */
+ (BOOL) validateMobile:(NSString *)mobile;

/** 用户名 */
+ (BOOL) validateUserName:(NSString *)name;

/** 密码 */
+ (BOOL) validatePassword:(NSString *)passWord;

/** 昵称 */
+ (BOOL) validateNickname:(NSString *)nickname;

/** 身份证号 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/** 是否IP地址 */
+ (BOOL) validateIP:(NSString*)addr;

/** 验证码 */
+ (BOOL) validateCode:(NSString *)verificationCode;


/**
 *  浮点型
 */
+(BOOL) validateFloatDigits:(NSString*)floatValue;

/**
 *   int 型
 */
+(BOOL) validateIntDigits:(NSString*)floatValue;

/**
 *  验证输入金额
 *
 */
+ (BOOL)validateString:(NSString *)string;

/**
 *  验证中英文混合字符串的长度
 *
 *  @param string    中英文字符串内容
 *  @param minLength 最小限制字符数
 *  @param maxLenght 最大限制字符数
 *
 *  @return 验证是否通过
 */
+ (BOOL)validateString:(NSString *)string minLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLenght;

/**
 *  校验输入价格
 */
+ (BOOL)validatePrice:(NSString *)floatValue;

@end
