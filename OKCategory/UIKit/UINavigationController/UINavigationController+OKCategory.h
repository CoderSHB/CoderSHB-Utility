//
//  UINavigationController+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (OKCategory)

- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end

@interface UINavigationController (OKCategory_StackManager)

/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (nullable UIViewController *)rootViewController;

/**
 *  @brief UINavigationController 栈中是否包含某个UIViewController
 */
- (BOOL)stackContainViewController:(Class)controllerClass;

/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController;

/**
 *  @brief pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (nullable NSArray *)popToViewControllerWithLevel:(NSUInteger)level animated:(BOOL)animated;

/**
 *  @brief 返回UINavigationController 中指定的UIViewController的前一个UIViewController
 *
 *  @param controllerClass 指定UIViewController
 */
- (void)popBeforeViewController:(nonnull Class)controllerClass;

/**
 *  @brief 从UINavigationController stack 中 移除顶部VC前面几个UIViewController
 *
 *  @param count 移除的UIViewController的个数
 */
- (void)removeViewControllerFromStackWithCount:(NSUInteger)count;

/**
 *  @brief 移除UINavigationController stack中指定的UIViewController
 *
 *  @param ControllerClass 移除的viewController  类型
 */
- (void)removeViewControllerFromStack:(nonnull Class)controllerClass;

/**
 *  @brief 移除UINavigationController stack中多个指定的UIViewController
 *
 *  @param ControllerClass 移除的viewController  类型
 */
- (void)removeViewControllersFromStack:(nonnull Class)controllerClass, ...;

/**
 *  @brief 移除UINavigationController stack顶部UIViewController
 *
 *  @param controllerClass 移除到哪个UIViewController
 */
- (void)removeViewControllersFromStackToViewController:(nonnull Class)controllerClass;

@end


NS_ASSUME_NONNULL_END