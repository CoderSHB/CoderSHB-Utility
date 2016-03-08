//
//  NSLocale+Addition.m
//
//  Created by SHB on 15/12/18.
//  Copyright © 2015年 CoderSHB. All rights reserved.
//

#import "NSLocale+Addition.h"

#define kBLOCK_SAFE_EXEC(block, ...)   if(block){block(__VA_ARGS__);};

@implementation NSLocale (Addition)

+ (OCLocaleLanguageType)currentLanguageType {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *languageString = [languages firstObject];
    
    if ([languageString containsString:@"en"]) {
        // 英文
        return OCLocaleLanguageType_en;
    } else if ([languageString containsString:@"zh-Hans"]) {
        // 简体中文
        return OCLocaleLanguageType_Hans;
    } else if ([languageString containsString:@"zh-Hant"]) {
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

        kBLOCK_SAFE_EXEC(han_sBlock);
    } else if (kCurrentLanguageType == OCLocaleLanguageType_Hant) {
        
        kBLOCK_SAFE_EXEC(han_tBlock);
    } else {
        
        kBLOCK_SAFE_EXEC(enBlock);
    }
}

@end