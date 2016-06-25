//
//  NSNumber+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (OKCategory)

- (CGFloat)ok_CGFloatValue;

- (id)initWithCGFloat:(CGFloat)value;
+ (NSNumber *)numberWithCGFloat:(CGFloat)value;

/*!
 *  @brief 转罗马数字
 */
- (NSString *)ok_romanNumeber;

/*!
 *  @brief  四舍五入
 *
 *  @param  digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)ok_roundWithDigit:(NSUInteger)digit;

/*!
 *  @brief  取上整
 *
 *  @param  digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)ok_ceilWithDigit:(NSUInteger)digit;

/*!
 *  @brief  取下整
 *
 *  @param  digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)ok_floorWithDigit:(NSUInteger)digit;


@end

NS_ASSUME_NONNULL_END
