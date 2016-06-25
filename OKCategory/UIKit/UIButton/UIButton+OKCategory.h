//
//  UIButton+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^UIButtonBlock)(UIButton *button);

//IB_DESIGNABLE
@interface UIButton (OKCategory)
//@property (nonatomic, copy) IBInspectable NSString *titleHexColor;

/// 设置按钮额外热区
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/**
 *  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)ok_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  在按钮中间替代title 显示加载动画
 */
- (void)ok_showIndicator;

/**
 *  移除加载动画并将title还原
 */
- (void)ok_hideIndicator;


- (void)ok_addAction:(UIButtonBlock)block;
- (void)ok_addAction:(UIButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

- (void)ok_startTime:(NSInteger)timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

@end

NS_ASSUME_NONNULL_END