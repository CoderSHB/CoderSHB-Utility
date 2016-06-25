//
//  NSString+OKChinese
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OKChinese)

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)ok_isContainChinese;

- (NSString*)ok_pinyinWithPhoneticSymbol;
- (NSString*)ok_pinyin;
- (NSArray*)ok_pinyinArray;
- (NSString*)ok_pinyinWithoutBlank;
- (NSArray*)ok_pinyinInitialsArray;
- (NSString*)ok_pinyinInitialsString;

@end

NS_ASSUME_NONNULL_END