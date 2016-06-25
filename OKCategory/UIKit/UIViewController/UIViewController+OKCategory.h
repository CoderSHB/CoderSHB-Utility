//
//  UIViewController+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^OKBackButtonHandler)(UIViewController *vc);

@interface UIViewController (OKCategory)

/// UIViewController 是否可见
- (BOOL)ok_isVisible;

/**
 *  获取当前显示的ViewController
 */
+ (nullable UIViewController *)ok_fetchCurrentViewController;

/**
 *  视图层级
 *
 *  @return 视图层级字符串
 */
- (NSString *)ok_recursiveDescription;

- (void)ok_backButtonTouched:(OKBackButtonHandler)backButtonHandler;


- (void)ok_addChildViewController:(UIViewController *)controller atFrame:(CGRect)frame;
- (void)ok_addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame;

- (void)ok_removeChildViewController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END