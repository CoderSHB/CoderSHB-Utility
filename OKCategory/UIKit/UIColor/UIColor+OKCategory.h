//
//  UIColor+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 随机色
#define OKRamdomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f]

/// 颜色(RGB)
#define OKRGB_COLOR(r, g, b) [UIColor colorWithRed: (r)/255.0f green: (g)/255.0f blue: (b)/255.0f alpha: 1.0f]
#define OKRGBA_COLOR(r, g, b, a)   [UIColor colorWithRed: r/255.0f green: g/255.0f blue: b/255.0f alpha: a]
/// 16进制颜色
#define OKHEX_COLOR(hexColor) [UIColor ok_colorWithHexString: @#hexColor]
#define OKHEX_ALPHA_COLOR(hexColor, a) [UIColor ok_colorWithHexString: @#hexColor alpha: a];


@interface UIColor (OKCategory)

/// 获取随机色
+ (UIColor *)ok_randomColor;

/// 反转颜色
- (UIColor *)ok_invertedColor;

+ (UIColor *)ok_colorWithHexString:(NSString *)hexString;

+ (UIColor *)ok_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)ok_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(int)height;

/**
 *  获取图片颜色最多的一种颜色
 *
 *  @param image 图片
 *
 *  @return 图片颜色
 */
+ (nullable UIColor *)ok_fetchColorAtImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END