//
//  NSLocale+Addition.m
//
//  Created by SHB on 15/12/18.
//  Copyright © 2015年 Sunshine. All rights reserved.
//

#import "NSLocale+Addition.h"

@implementation NSLocale (Addition)

+ (OCLocaleLanguageType)currentLanguageType {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *languageString = [languages firstObject];
    
    if ([languageString ok_containsString:@"en"]) {
        // 英文
        return OCLocaleLanguageType_en;
    } else if ([languageString ok_containsString:@"zh-Hans"]) {
        // 简体中文
        return OCLocaleLanguageType_Hans;
    } else if ([languageString ok_containsString:@"zh-Hant"]) {
        // 繁体中文
        return OCLocaleLanguageType_Hant;
    }
    return OCLocaleLanguageType_Hans;
}

+ (void)localLanguageOperationWithHan:(void (^)())hanBlock en:(void (^)())enBlock {
    [self localLanguageOperationWithHans:hanBlock hant:hanBlock en:enBlock];
}

+ (void)localLanguageOperationWithHans:(void (^)())han_sBlock hant:(void (^)())han_tBlock en:(void (^)())enBlock {
    if (kCurrentLanguageType == OCLocaleLanguageType_Hans) {
        if (han_sBlock) {
            han_sBlock();
        }
    } else if (kCurrentLanguageType == OCLocaleLanguageType_Hant) {
        if (han_tBlock) {
            han_tBlock();
        }
    } else {
        if (enBlock) {
            enBlock();
        }
    }
}

@end