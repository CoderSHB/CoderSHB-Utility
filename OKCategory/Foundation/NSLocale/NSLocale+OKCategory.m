//
//  NSLocale+OKCategory
//
//  Copyright © 2015年 OKCoin. All rights reserved.
//

#import "NSLocale+OKCategory.h"
#import "NSString+OKCategory.h"

@implementation NSLocale (OKCategory)

////////////////////////////////////////////////////////////////////////////////////////////////////

+ (OCLocaleLanguageType)ok_fetchCurrentLanguageType {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *languageString = [languages firstObject];
    
    if ([languageString ok_containsString:@"en"]) {
        // 英文
        return OCLocaleLanguageType_en;
    } else if ([languageString ok_containsString:@"zh-Hans"]) {
        // 简体中文
        return OCLocaleLanguageType_Hans;
    } else if ([languageString ok_containsString:@"zh-Hant"]
               || [languageString ok_containsString:@"zh-HK"]
               || [languageString ok_containsString:@"zh-TW"]
               ) {
        // 繁体中文
        return OCLocaleLanguageType_Hant;
    }
    return OCLocaleLanguageType_Hans;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)ok_localLanguageOperationWithHan:(void (^)())hanBlock en:(void (^)())enBlock {
    [self ok_localLanguageOperationWithHans:hanBlock hant:hanBlock en:enBlock];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)ok_localLanguageOperationWithHans:(void (^)())han_sBlock hant:(void (^)())han_tBlock en:(void (^)())enBlock {
    if (OKCurrentLanguageType == OCLocaleLanguageType_Hans) {
        if (han_sBlock) {
            han_sBlock();
        }
    } else if (OKCurrentLanguageType == OCLocaleLanguageType_Hant) {
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
