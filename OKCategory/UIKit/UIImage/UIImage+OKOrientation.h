//
//  UIImage+Orientation
//
//  Copyright (c) 2015年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//CGFloat DegreesToRadiansForOrientation(CGFloat degrees) {return degrees * M_PI / 180;};
//CGFloat RadiansToDegreesForOrientation(CGFloat radians) {return radians * 180/M_PI;};

@interface UIImage (OKOrientation)

/**
 *  @brief  修正图片的方向
 *
 *  @return 修正方向后的图片
 */
- (UIImage *)ok_fixOrientation;

/**
 *  @brief  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)ok_imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  @brief  旋转图片
 *
 *  @param degrees 弧度
 *
 *  @return 旋转后图片
 */
- (UIImage *)ok_imageRotatedByRadians:(CGFloat)radians;

/**
 *  @brief  垂直翻转
 *
 *  @return  翻转后的图片
 */
- (UIImage *)ok_flipVertical;

/**
 *  @brief  水平翻转
 *
 *  @return 翻转后的图片
 */
- (UIImage *)ok_flipHorizontal;

/**
 *  @brief  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+ (CGFloat)ok_degreesToRadians:(CGFloat)degrees;

/**
 *  @brief  弧度转角度
 *
 *  @param radians 弧度
 *
 *  @return 角度
 */
+ (CGFloat)ok_radiansToDegrees:(CGFloat)radians;

@end
