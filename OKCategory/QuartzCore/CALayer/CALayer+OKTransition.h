//
//  CALayer+OKTransition.h
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

/// 动画类型
typedef NS_ENUM (NSInteger, OKTransitionAnimType){
    /// 水波
    OKTransitionAnimTypeRippleEffect = 0,
    /// 吸走
    OKTransitionAnimTypeSuckEffect,
    /// 翻开书本
    OKTransitionAnimTypePageCurl,
    /// 正反翻转
    OKTransitionAnimTypeOglFlip,
    /// 正方体
    OKTransitionAnimTypeCube,
    /// push推开
    OKTransitionAnimTypeReveal,
    /// 合上书本
    OKTransitionAnimTypePageUnCurl,
    /// 随机
    OKTransitionAnimTypeRamdom,
};

/// 动画方向
typedef NS_ENUM (NSInteger, OKTransitionSubType) {
    OKTransitionSubtypesFromTop = 0,
    OKTransitionSubtypesFromLeft,
    OKTransitionSubtypesFromBotoom,
    OKTransitionSubtypesFromRight,
    OKTransitionSubtypesFromRamdom,
};

/// 动画曲线
typedef NS_ENUM (NSInteger, OKTransitionCurve) {
    //默认
    OKTransitionCurveDefault,
    //缓进
    OKTransitionCurveEaseIn,
    //缓出
    OKTransitionCurveEaseOut,
    //缓进缓出
    OKTransitionCurveEaseInEaseOut,
    //线性
    OKTransitionCurveLinear,
    //随机
    OKTransitionCurveRamdom,
};

@interface CALayer (OKTransition)

/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subtype  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
- (CATransition *)ok_transitionWithAnimType:(OKTransitionAnimType)animType
                                    subType:(OKTransitionSubType)subType
                                      curve:(OKTransitionCurve)curve
                                   duration:(CGFloat)duration;


@end

NS_ASSUME_NONNULL_END