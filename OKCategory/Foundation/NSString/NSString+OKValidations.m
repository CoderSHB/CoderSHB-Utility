//
//  NSString+OKValidations
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//


#import "NSString+OKValidations.h"

@implementation NSString (OKValidations)

#pragma mark - 正则相关
- (BOOL)__isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)ok_isValidChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ok_isValidEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

- (BOOL)ok_isValidIPAddress {
    NSString *ipRegex = @"^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$";
    NSPredicate *ipPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegex];
    return [ipPredicate evaluateWithObject:self];
}

- (BOOL)ok_isValidURL {
    NSString *regex = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [urlTest evaluateWithObject:self];
}

/// 是否是有效的小灵通号码
- (BOOL)ok_isValidPHSNumber {
    // 大陆地区固话及小灵通 010,020,021,022,023,024,025,027,028,029 七位或八位
    NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    return [self __isValidateByRegex:PHS];
}

/// 是否是有效的移动手机号
- (BOOL)ok_isValidMobileNumber {
    // 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    return [self __isValidateByRegex:CM];
}

/// 是否是有效的联通手机号
- (BOOL)ok_isValidUnicomNumber {
    // 联通：130,131,132,152,155,156,185,186,1709
    NSString *CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    return [self __isValidateByRegex:CU];
}

/// 是否是有效的电信手机号
- (BOOL)ok_isValidTelecomNumber {
    // 电信：133,1349,153,180,189,1700
    NSString *CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    return [self __isValidateByRegex:CT];
}

/// 是否是有效的手机号码
- (BOOL)ok_isValidPhoneNumber {
    //手机号以13、15、18、170开头，8个 \d 数字字符
    //小灵通 区号：010,020,021,022,023,024,025,027,028,029 还有未设置的新区号xxx
    //除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";
    NSString *phsRegex      = @"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";

    return [self __isValidateByRegex:mobileNoRegex] ||
           [self __isValidateByRegex:phsRegex];
}


/// 是否是有效的固话号码
- (BOOL)ok_isValidTelphoneNumber {
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^\\d{3,4}-\\d{7,8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    
    return (numberofMatch > 0) ? YES : NO;
}

- (BOOL)ok_isValidCarNumber {
//    NSString    *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
//    NSPredicate *carTest  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
//    return [carTest evaluateWithObject:self];

    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    //其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";
    return [self __isValidateByRegex:carRegex];
    
}

- (BOOL)ok_isValidIDCardNumberBySimple {
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self __isValidateByRegex:regex];
}

- (BOOL)ok_isValidIDCardNumber {
    
    if (self.length != 18) {
        return NO;
    }
    
    NSArray *wight = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSArray *remainders = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    int sum = 0;
    for (int i = 0; i < self.length - 1; i++) {
        unichar ch = [self characterAtIndex:i];
        sum += ((ch - 48) * [wight[i] intValue]);
    }
    
    NSString *last = [self substringFromIndex:self.length - 1];
    // 取余
    int m = sum % 11;
    
    return [[remainders objectAtIndex:m] isEqualToString:[last uppercaseString]];
}

- (BOOL)ok_isValidMacAddress{
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self __isValidateByRegex:macAddRegex];
}
- (BOOL)ok_isValidPostalcode {
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self __isValidateByRegex:postalRegex];
}

- (BOOL)ok_isValidTaxNumber {
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self __isValidateByRegex:taxNoRegex];
}

- (BOOL)ok_isValidPassword {
    NSString *pwdRegex = @"^[\\w~\\!\\@\\#\\$\\%\\^\\&\\*\\?\\(\\)\\+\\-=\\[\\]\\{\\|`\\};:'\"\\,\\.\\/]{6,32}$";
    return [self __isValidateByRegex:pwdRegex];
}

@end
