//
//  UIFont+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (OKCategory)

/// 正常英文字体
+ (UIFont *)ok_HelveticaNeue:(CGFloat)fontsize;
/// 斜体字
+ (UIFont *)ok_HelveticaNeueItalic:(CGFloat)fontsize;
/// 粗体字
+ (UIFont *)ok_HelveticaNeueBold:(CGFloat)fontsize;
/// 超轻体
+ (UIFont *)ok_HelveticaNeueUltraLight:(CGFloat)fontsize;
/// 浓黑（粗）体
+ (UIFont *)ok_HelveticaNeueCondensedBlack:(CGFloat)fontsize;
/// 粗斜体
+ (UIFont *)ok_HelveticaNeueBoldItalic:(CGFloat)fontsize;
/// 浓粗体
+ (UIFont *)ok_HelveticaNeueCondensedBold:(CGFloat)fontsize;
/// 中
+ (UIFont *)ok_HelveticaNeueMedium:(CGFloat)fontsize;
/// 细
+ (UIFont *)ok_HelveticaNeueLight:(CGFloat)fontsize;
/// 薄
+ (UIFont *)ok_HelveticaNeueThin:(CGFloat)fontsize;
/// 薄斜体
+ (UIFont *)ok_HelveticaNeueThinItalic:(CGFloat)fontsize;
/// 细斜体
+ (UIFont *)ok_HelveticaNeueLightItalic:(CGFloat)fontsize;
/// 超轻斜体
+ (UIFont *)ok_HelveticaNeueUltraLightItalic:(CGFloat)fontsize;
/// 中斜体
+ (UIFont *)ok_HelveticaNeueMediumItalic:(CGFloat)fontsize;

+ (UIFont *)ok_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName;
+ (UIFont *)ok_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale;

- (UIFont *)ok_adjustFontForTextStyle:(NSString *)style;
- (UIFont *)ok_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END