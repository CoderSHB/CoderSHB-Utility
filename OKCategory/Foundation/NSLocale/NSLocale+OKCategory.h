//
//  NSLocale+OKCategory
//
//  Copyright © 2015年 OKCoin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OKCurrentLanguageType [NSLocale ok_fetchCurrentLanguageType]

/// 语言类型枚举
typedef NS_ENUM (NSInteger, OCLocaleLanguageType) {
    OCLocaleLanguageType_Hans = 0, //!< 中文简体
    OCLocaleLanguageType_en,       //!< 英文
    OCLocaleLanguageType_Hant    //!< 中文繁体
};

NS_ASSUME_NONNULL_BEGIN

@interface NSLocale (OKCategory)

/**
 *  @brief 获取手机语言类型 [default = OCLocaleLanguageType_Hans]
 */
+ (OCLocaleLanguageType)ok_fetchCurrentLanguageType;

/**
 *  @brief 区分汉字和英文的操作
 *
 *  @param hanBlock 简体和繁体中文的操作
 *  @param enBlock  英文的操作
 */
+ (void)ok_localLanguageOperationWithHan:(void (^)())hanBlock en:(void (^)())enBlock;

/**
 *  @brief 根据本地语言的不同选择执行不同的操作
 *
 *  @param han_sBlock 简体中文的操作
 *  @param han_tBlock 繁体中文的操作
 *  @param enBlock    英文的操作
 */
+ (void)ok_localLanguageOperationWithHans:(void (^)())han_sBlock hant:(void (^)())han_tBlock en:(void (^)())enBlock;

@end

NS_ASSUME_NONNULL_END