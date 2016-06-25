//
//  UIView+OKCorner
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (OKCorner)

- (void)ok_cornerRadiusStyleWithValue:(CGFloat)value;
- (void)ok_roundedWidthStyle;
- (void)ok_roundedHeightStyle;

/// 对左上角和右上角加圆角
- (void)ok_roundedCornersOnTopWithRadious:(CGFloat)radious;

/// 对左上角加圆角
- (void)ok_roundedCornersOnTopLeftWithRadious:(CGFloat)radious;

/// 对右上角加圆角
- (void)ok_roundedCornersOnTopRightWithRadious:(CGFloat)radious;

/// 对左下角和右下角加圆角
- (void)ok_roundedCornersOnBottomWithRadious:(CGFloat)radious;

/// 对左下角加圆角
- (void)ok_roundedCornersOnBottomLeftWithRadious:(CGFloat)radious;

/// 对右下角加圆角
- (void)ok_roundedCornersOnBottomRightWithRadious:(CGFloat)radious;

/// 对所有角加圆角
- (void)ok_roundedCornersOnAllSideWithRadious:(CGFloat)radious;

@end

NS_ASSUME_NONNULL_END