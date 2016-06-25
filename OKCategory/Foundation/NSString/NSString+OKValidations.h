//
//  NSString+OKValidations
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (OKValidations)

/// 判断是否为中文字符串
- (BOOL)ok_isValidChinese;

/// 是否是有效的Email地址
- (BOOL)ok_isValidEmail;

/// 是否是有效的IP地址
- (BOOL)ok_isValidIPAddress;

/// 是否是有效的URL地址
- (BOOL)ok_isValidURL;

/// 是否是有效的小灵通号码
- (BOOL)ok_isValidPHSNumber;
/// 是否是有效的移动手机号
- (BOOL)ok_isValidMobileNumber;
/// 是否是有效的联通手机号
- (BOOL)ok_isValidUnicomNumber;
/// 是否是有效的电信手机号
- (BOOL)ok_isValidTelecomNumber;
/// 是否是有效的手机号码
- (BOOL)ok_isValidPhoneNumber;
/// 是否是有效的固话号码
- (BOOL)ok_isValidTelphoneNumber;

/// 是否是有效的车牌号
- (BOOL)ok_isValidCarNumber;

/// 简单方式验证身份证
- (BOOL)ok_isValidIDCardNumberBySimple;
/// 严格验证身份证号 会根据每位的数进行运算
- (BOOL)ok_isValidIDCardNumber;

/// 是否是有效的MAC地址
- (BOOL)ok_isValidMacAddress;

// 是否是有效的邮编
- (BOOL)ok_isValidPostalcode;

/// 是否是有效的工商税号
- (BOOL)ok_isValidTaxNumber;

/// 是否是有效的密码[验证是否是6-32位]
- (BOOL)ok_isValidPassword;

@end
