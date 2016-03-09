//
//  UINavigationController+Utility.h
//
//  Created by SHB on 15/11/27.
//  Copyright © 2015年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Utility)

/// UINavigationController 栈中是否包含某个UIViewController
- (BOOL)stackContainViewController:(nonnull Class)controllerClass;

/**
 *  从UINavigationController stack 中 移除顶部VC前面几个UIViewController
 *
 *  @param count 移除的UIViewController的个数
 */
- (void)removeViewControllerFromStackWithCount:(NSUInteger)count;

/**
 *  移除UINavigationController stack中指定的UIViewController
 *
 *  @param ControllerClass 移除的viewController
 */
- (void)removeViewControllerFromStack:(nonnull Class)controllerClass;

/**
 *  移除UINavigationController stack中多个指定的UIViewController
 *
 *  @param ControllerClass 移除的viewController
 */
- (void)removeViewControllersFromStack:(nonnull Class)controllerClass, ...;

/**
 *  移除UINavigationController stack顶部UIViewController
 *
 *  @param controllerClass 移除到哪个UIViewController
 */
- (void)removeViewControllersFromStackToViewController:(nonnull Class)controllerClass;

/**
 *  返回UINavigationController 中指定的UIViewController的前一个UIViewController
 *
 *  @param controllerClass 指定UIViewController
 */
- (void)popBeforeViewController:(nonnull Class)controllerClass animated:(BOOL)animated;

/**
 *  pop UIViewController 并且移除顶部VC前面几个UIViewController
 *
 *  @param count 移除的个数
 *
 *  @return the popped controller.
 */
- (nullable UIViewController *)popViewControllerWithRemoveCount:(NSUInteger)count animated:(BOOL)animated;

@end
