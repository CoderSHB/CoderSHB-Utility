//
//  UIImage+Utility.h
//  UIImage+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageMarkPosition) {
  ImageMarkPositionTopRightCorner    = 0,
  ImageMarkPositionTopLeftCorner     = 1,
  ImageMarkPositionBottomRightCorner = 2,
  ImageMarkPositionBottomLeftCorner  = 3,
};

@interface UIImage (Utility)
/**
 *  图片拉伸
 *
 *  @param imageName 需要拉伸的图片名
 *
 *  @return 返回一张已经拉伸好的图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

/**
 *  将图片(根据图片名)截取成圆形图片
 *
 *  @param imageName   需要截取图片的图片名
 *  @param borderWidth 图片边框大小
 *  @param borderColor 图片边框的颜色
 *
 *  @return 返回一张圆形图片
 */
+ (UIImage *)circleImageWithName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  将图片(根据图片)截取成圆形图片
 *
 *  @param image       需要截取图片
 *  @param borderWidth 图片边框大小
 *  @param borderColor 图片边框的颜色
 *
 *  @return 返回一张圆形图片
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  自定义位置生成水印图片
 *
 *  @param bgName        背景图片名称
 *  @param markImageName 水印图片名称
 *  @param markPosition  自定义水印图片显示的位置
 *
 *  @return 返回一张水印图片(两张图片合并在一起的图片)
 */
+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(CGPoint)markPosition;

/**
 *  根据markPosition的传入值生成指定位置上的水印图片
 *
 *  @param bgName        背景图片名称
 *  @param markImageName 水印图片名称
 *  @param markPosition  水印图片显示的位置
 *  @param padding       指定水印图片距离边框的距离
 *
 *  @return 返回一张水印图片(两张图片合并在一起的图片)
 */
+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(ImageMarkPosition)markPosition padding:(CGFloat)padding;

/**
 *  自定义位置生成文字水印图片
 *
 *  @param bgName       背景图片名称
 *  @param markString   水印文字内容
 *  @param attrs        水印文字的属性
 *  @param rect         自定义水印图片显示的位置
 *
 *  @return 返回一张自定义位置的文字水印图片
 */
+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markString:(NSString *)markString attributes:(NSDictionary *)attrs markRect:(CGRect)rect;

/**
 *  根据传入的背景图片名,水印图片的名字和位置,水印文字的内容和位置生成一张合成图片
 *
 *  @param bgName        背景图片名称
 *  @param markImageName 水印图片的名称
 *  @param markPosition  水印图片的位置
 *  @param markString    水印文字的内容
 *  @param attrs         水印文字的属性
 *  @param rect          水印图片的位置
 *
 *  @return 返回一张合成水印图片和水印文字的图片
 */
+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(CGPoint)markPosition markString:(NSString *)markString attributes:(NSDictionary *)attrs markRect:(CGRect)rect;

/**
 *  根据view返回一张view的快照
 *
 *  @param view 要生成快照的view
 *
 *  @return 传入view的快照
 */
+ (UIImage *)snapshotWithView:(UIView *)view;

@end
