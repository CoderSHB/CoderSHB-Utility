//
//  UINavigationController+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UINavigationController+OKCategory.h"

@implementation UINavigationController (OKCategory)
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    [self pushViewController:controller animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}

@end

@implementation UINavigationController (OKCategory_StackManager)

////////////////////////////////////////////////////////////////////////////////////////////////////

- (UIViewController *)rootViewController {
    if (self.viewControllers && [self.viewControllers count] > 0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)stackContainViewController:(nonnull Class)controllerClass {
    
    NSAssert(controllerClass, @"controllerClass 不能为空");
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    for (int i = 0; i < stackArray.count; i++) {
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isKindOfClass:controllerClass]) {
            return YES;
        }
    }
    return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)isOnlyContainRootViewController {
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray *)popToViewControllerWithLevel:(NSUInteger)level animated:(BOOL)animated {
    NSUInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)popBeforeViewController:(nonnull Class)controllerClass {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    NSInteger count = 0;
    
    for (int i = 0; i < stackArray.count - 1; i++) {
        
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isMemberOfClass:controllerClass]) {
            count = i;
        }
    }
    NSAssert(count > 0, @"未找到对应的UIViewController");
    if (count > 1) {
        
        UIViewController *viewcontroller = self.viewControllers[count-1];
        [self popToViewController:viewcontroller animated:YES];
        
    } else if (count == 1) {
        [self popToRootViewControllerAnimated:YES];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)removeViewControllerFromStackWithCount:(NSUInteger)count {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    NSAssert(count < stackArray.count-1, @"删除的vc数目比栈中的数目多");
    
    if (count >= stackArray.count) return;

    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger removeIndex = stackArray.count - 2;
        [stackArray removeObjectAtIndex:removeIndex];
    }
    
    [self setViewControllers:stackArray];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)removeViewControllerFromStack:(Class)controllerClass {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    for (int i = 0; i < stackArray.count - 1; i++) {
        
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isMemberOfClass:controllerClass]) {
            [stackArray removeObjectAtIndex:i];
            i--;
        }
    }
    [self setViewControllers:stackArray];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)removeViewControllersFromStack:(nonnull Class)controllerClass, ... {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    va_list args;
    va_start(args, controllerClass);
    
    if (controllerClass) {
        Class otherClass = controllerClass;
        do{
            // 移除viewController
            for (int i = 0; i < stackArray.count -1; i++) {
                UIViewController *stackVC = stackArray[i];
                if ([stackVC isMemberOfClass:otherClass]) {
                    [stackArray removeObjectAtIndex:i];
                    i--;
                }
            }
        } while ((otherClass = va_arg(args, Class)));
    }
    va_end(args);
    [self setViewControllers:stackArray];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)removeViewControllersFromStackToViewController:(nonnull Class)controllerClass {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    NSUInteger index = 0;
    for (int i = 1; i < stackArray.count - 1; i++) {
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isKindOfClass:controllerClass]) {
            index = i;
            break;
        }
    }
    
    NSAssert(index != 0, @"未找到对应ViewController");
    
    if (index != 0) {
        [self removeViewControllerFromStackWithCount:(stackArray.count - 1 - index)];
    }
    
}

@end