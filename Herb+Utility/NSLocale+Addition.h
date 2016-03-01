//
//  NSLocale+Addition.h
//
//  Created by SHB on 15/12/18.
//  Copyright © 2015年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCurrentLanguageType [NSLocale currentLanguageType]

/// 语言类型枚举
typedef NS_ENUM(NSInteger, OCLocaleLanguageType) {
    OCLocaleLanguageType_en = 0, //!< 英文
    OCLocaleLanguageType_Hans,   //!< 中文简体
    OCLocaleLanguageType_Hant    //!< 中文繁体
};

@interface NSLocale (Addition)

/*!
 *  获取手机语言类型 [default = OCLocaleLanguageType_Hans]
 */
+ (OCLocaleLanguageType)currentLanguageType;

/*!
 *  区分汉字和英文的操作
 *
 *  @param hanBlock 简体和繁体中文的操作
 *  @param enBlock  英文的操作
 */
+ (void)localLanguageOperationWithHan:(void (^)())hanBlock en:(void (^)())enBlock;

/*!
 *  根据本地语言的不同选择执行不同的操作
 *
 *  @param han_sBlock 简体中文的操作
 *  @param han_tBlock 繁体中文的操作
 *  @param enBlock    英文的操作
 */
+ (void)localLanguageOperationWithHans:(void (^)())han_sBlock hant:(void (^)())han_tBlock en:(void (^)())enBlock;

@end
