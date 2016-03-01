//
//  OKLinkValidateUntil.m
//  OKLinkMagent
//
//  Created by 李昊 on 14/12/26.
//  Copyright (c) 2014年 OKLink. All rights reserved.
//
#import "OKLinkValidateUntil.h"

@implementation OKLinkValidateUntil
//标点符号
+ (BOOL)validatePunctuate:(NSString *)punctuate{
    NSString *punctuateRegex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
    NSPredicate *punctuateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", punctuateRegex];
    return ![punctuateTest evaluateWithObject:punctuate];
}

//邮箱
+(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    //    NSString *userNameRegex = @"^[A-Za-z0-9]{3,20}+$";
    //    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    //    BOOL B = [userNamePredicate evaluateWithObject:name];
    return name.length < 60;
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[\\w~\\!\\@\\#\\$\\%\\^\\&\\*\\?\\(\\)\\+\\-=\\[\\]\\{\\|`\\};:'\"\\,\\.\\/]{6,20}$";
//    ^[\w~\!\@\#\$\%\^\&\*\?\(\)\+\-=\[\]\{\\|`\\};:'"\,\.\/]{6,20}$
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
//    BOOL flag;
//    if (identityCard.length <= 0) {
//        flag = NO;
//        return flag;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:identityCard];
    if (identityCard.length != 18) {
        return NO;
    }
    
    NSArray *wight = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSArray *remainders = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    int sum = 0;
    for (int i = 0; i < identityCard.length - 1; i++) {
        unichar ch = [identityCard characterAtIndex:i];
        sum += ((ch - 48) * [wight[i] intValue]);
    }
    
    NSString *last = [identityCard substringFromIndex:identityCard.length - 1];
    // 取余
    int m = sum % 11;
    
    return [[remainders objectAtIndex:m] isEqualToString:[last uppercaseString]];
}

//是否IP地址
+ (BOOL) validateIP:(NSString*)addr{
    NSString *ipRegex = @"^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$";
    NSPredicate *ipPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ipRegex];
    return [ipPredicate evaluateWithObject:addr];
}
+ (BOOL) validateCode:(NSString *)verificationCode{
    NSString *validateCodeRegex = @"^\\d{6}$";
    NSPredicate *validateCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",validateCodeRegex];
    return [validateCodePredicate evaluateWithObject:verificationCode];
}
/**
 *  验证 是否是浮点型
 */
+(BOOL) validateFloatDigits:(NSString*)floatValue{
    NSString *regex =@"^\\-?\\d+((\\.)\\d+)?$";
    NSPredicate *floatPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [floatPredicate evaluateWithObject:floatValue];
}
//  整型
+(BOOL) validateIntDigits:(NSString*)floatValue{
    NSString *regex =@"^\\d+(\\.\\d+)?$";
    NSPredicate *floatPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [floatPredicate evaluateWithObject:floatValue];
}
/**
 *  校验输入字符合法性 -lx
 */
+ (BOOL)validateString:(NSString *)string{
    BOOL vali =NO;
    //正整数
    if ([OKLinkValidateUntil validateIntDigits:string]) {
        //整数金额大于5000000
        if ([string integerValue]>5000000) {
            vali=NO;
            return vali;
        }else{
            vali =YES;
            return vali;
        }
       
    }
     //浮点型
    if ([OKLinkValidateUntil validateFloatDigits:string]) {
        if ([string length] - [string rangeOfString:@"."].location >2) {
            OKLog(@"小数位超限");
            vali =NO;
        }else {
            vali =YES;
        }
        //输入特殊的数
        if ([string isEqualToString:@"0.0"]) {
            vali =NO;
            OKLog(@"0.0");
        }
        //小于输入的最小金额
        if ([string doubleValue]<1) {
            vali=NO;
            OKLog(@"小于可输入的最小值");
        }
      
    }
    //最后一位为小数点时
    if ([[string substringWithRange:NSMakeRange(string.length-1, 1)] isEqualToString:@"."]){
        vali=YES;
    }
    //有两位小数点
    int number =0;
    for (int i=1; i<=string.length; i++) {
        NSString * str=[string substringWithRange:NSMakeRange(i-1, 1)];
        if ([str isEqualToString:@"."]) {
            number =number +1;
        }else{
        }
    }
    if (number ==2){
        vali=NO;
        OKLog(@"有两个小数点");

    }
    return vali;
}

+ (BOOL)validateString:(NSString *)string minLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLenght {
    NSString *regex = @"^[\u4e00-\u9fa5]";
    NSUInteger length = [string length];
    int currentStringLength = 0;
    for (int i = 0;i < length;i++) {//逐步判断string中的每个字符是否为汉字，是，占两个字符，不是，占一个字符
        NSString *subString= [string substringWithRange:NSMakeRange( i, 1)];
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([passWordPredicate evaluateWithObject:subString]) {
            currentStringLength += 2;
        }else {
            currentStringLength += 1;
        }
    }
    if (currentStringLength >= minLength && currentStringLength <= maxLenght) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)validatePrice:(NSString *)floatValue
{
    NSString *regex =@"^[1-9]\\d*$";
    NSPredicate *floatPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [floatPredicate evaluateWithObject:floatValue];
}

@end
