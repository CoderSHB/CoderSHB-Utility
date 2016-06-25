//
//  UIImageView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (OKCategory)

/**
 *  @brief 倒影
 */
- (void)ok_reflect;

/**
 *  @brief 创建imageview动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 *
 *  @return imageview
 */
+ (nullable UIImageView *)ok_imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration;

/**
 *  @brief 画图片水印
 *
 *  @param image 原图片
 *  @param mark  水印图片
 *  @param rect  水印位置
 */
- (void)ok_setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;

/**
 *  @brief 添加文字水印
 *
 *  @param image      原图片
 *  @param markString 水印文字
 *  @param point      水印位置
 *  @param color      水印颜色
 *  @param font       水印字体
 */
- (void)ok_setImage:(UIImage *)image
    withStringWaterMark:(NSString *)markString
                atPoint:(CGPoint)point
                  color:(UIColor *)color
                   font:(UIFont *)font;

/**
 *  @brief 添加文字水印
 *
 *  @param image      原图片
 *  @param markString 水印文字
 *  @param rect       水印位置
 *  @param color      水印颜色
 *  @param font       水印字体
 */
- (void)ok_setImage:(UIImage *)image
    withStringWaterMark:(NSString *)markString
                 inRect:(CGRect)rect
                  color:(UIColor *)color
                   font:(UIFont *)font;



@end

NS_ASSUME_NONNULL_END