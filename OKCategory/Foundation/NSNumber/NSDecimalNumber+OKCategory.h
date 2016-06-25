//
//  NSDecimalNumber+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDecimalNumber (OKCategory)
/**
 *  @brief  四舍五入 NSRoundPlain
 *
 *  @param scale 限制位数
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)ok_roundToScale:(NSUInteger)scale;

/**
 *  @brief  四舍五入
 *
 *  @param scale        限制位数
 *  @param roundingMode NSRoundingMode
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)ok_roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode;

- (NSDecimalNumber*)ok_decimalNumberWithPercentage:(float)percent;
- (NSDecimalNumber*)ok_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage;
- (NSDecimalNumber*)ok_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage
                                              roundToScale:(NSUInteger)scale;

- (NSDecimalNumber*)ok_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue;
- (NSDecimalNumber*)ok_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue
                                          roundToScale:(NSUInteger)scale;

@end
