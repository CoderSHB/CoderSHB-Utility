//
//  NSDictionary+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (OKCategory)

/**
 *  @brief  将NSDictionary转换成XML字符串
 *
 *  @return XML 字符串
 */
- (NSString *)ok_XMLString;

/**
 *  @brief  将NSDictionary转换成JSON字符串
 *
 *  @return JSON字符串
 */
- (nullable NSString *)ok_JSONString;

/**
 *  @brief 将JSON字符串转换成NSDictionary
 *
 *  @param json json字符串
 *
 *  @return 转换后的字典
 */
+ (nullable NSDictionary *)ok_dictionaryWithJSONString:(NSString *)json;

- (BOOL)ok_containsObjectForKey:(id)key;

- (NSDictionary *)ok_objectsForKeys:(NSArray *)keys;

- (NSDictionary *)ok_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)ok_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

@end

#pragma mark - NSDictionary OKURL

@interface NSDictionary (OKURL)

/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param  query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)ok_dictionaryWithURLQuery:(NSString *)query;

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)ok_URLQueryString;

@end

#pragma mark - NSDictionary OKSafeAccess

@interface NSDictionary (OKSafeAccess)

- (BOOL)ok_hasKey:(NSString *)key;

- (nullable NSString *)ok_stringForKey:(id)key;

- (nullable NSNumber *)ok_numberForKey:(id)key;

- (nullable NSDecimalNumber *)ok_decimalNumberForKey:(id)key;

- (nullable NSArray *)ok_arrayForKey:(id)key;

- (nullable NSDictionary *)ok_dictionaryForKey:(id)key;

- (NSInteger)ok_integerForKey:(id)key;

- (NSUInteger)ok_unsignedIntegerForKey:(id)key;

- (BOOL)ok_boolForKey:(id)key;

- (int16_t)ok_int16ForKey:(id)key;

- (int32_t)ok_int32ForKey:(id)key;

- (int64_t)ok_int64ForKey:(id)key;

- (char)ok_charForKey:(id)key;

- (short)ok_shortForKey:(id)key;

- (float)ok_floatForKey:(id)key;

- (double)ok_doubleForKey:(id)key;

- (long long)ok_longLongForKey:(id)key;

- (unsigned long long)ok_unsignedLongLongForKey:(id)key;

- (nullable NSDate *)ok_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

- (CGFloat)ok_CGFloatForKey:(id)key;

- (CGPoint)ok_pointForKey:(id)key;

- (CGSize)ok_sizeForKey:(id)key;

- (CGRect)ok_rectForKey:(id)key;
@end

#pragma mark - NSMutableDictionary OKSafeAccess

@interface NSMutableDictionary (OKSafeAccess)

- (void)ok_setValue:(id)value forKey:(NSString *)key;
- (void)ok_setObject:(id)value forKey:(NSString *)key;

- (void)setPoint:(CGPoint)point forKey:(NSString *)key;
- (void)setSize:(CGSize)size forKey:(NSString *)key;
- (void)setRect:(CGRect)rect forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END