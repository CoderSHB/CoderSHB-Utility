//
//  UINavigationController+Utility.m
//
//  Created by SHB on 15/11/27.
//  Copyright © 2015年 CoderSHB. All rights reserved.
//

#import "UINavigationController+Utility.h"

@implementation UINavigationController (Utility)

- (BOOL)stackContainViewController:(nonnull Class)controllerClass {
    
    NSAssert(controllerClass, @"controllerClass 不能为空");
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    for (int i = 0; i < stackArray.count; i++) {
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isMemberOfClass:controllerClass]) {
            return YES;
        }
    }
    return NO;
}

- (void)removeViewControllerFromStackWithCount:(NSUInteger)count {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    NSAssert(count < stackArray.count-1, @"删除的vc数目比栈中的数目多");
    
    if (count >= stackArray.count) {
        return;
    }
    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger removeIndex = stackArray.count - 2;
        [stackArray removeObjectAtIndex:removeIndex];
    }
    
    [self setViewControllers:stackArray];
}

- (void)removeViewControllerFromStack:(nonnull Class)controllerClass {
    
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

- (void)removeViewControllersFromStack:(nonnull Class)controllerClass, ...{

    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    va_list args;
    va_start(args, controllerClass);

    if (controllerClass) {
        Class otherClass = controllerClass;
        do {
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

- (void)removeViewControllersFromStackToViewController:(nonnull Class)controllerClass {
    
    NSMutableArray *stackArray = [self.viewControllers mutableCopy];
    
    NSUInteger index = 0;
    for (int i = 1; i < stackArray.count - 1; i++) {
        UIViewController *stackVC = stackArray[i];
        if ([stackVC isMemberOfClass:controllerClass]) {
            index = i;
            break;
        }
    }
    
    NSAssert(index != 0, @"未找到对应ViewController");
    
    if (index != 0) {
        [self removeViewControllerFromStackWithCount:(stackArray.count - 1 - index)];
    }
    
}

- (void)popBeforeViewController:(nonnull Class)controllerClass animated:(BOOL)animated {
    
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
        [self popToViewController:viewcontroller animated:animated];
        
    } else if (count == 1) {
        [self popToRootViewControllerAnimated:animated];
    } else {
        [self popViewControllerAnimated:animated];
    }
}

- (nullable UIViewController *)popViewControllerWithRemoveCount:(NSUInteger)count animated:(BOOL)animated {
    
    NSAssert(count >= 0, @"索引必须>=0");
    if (count > 0) {
        [self removeViewControllerFromStackWithCount:count];
    }
    return [self popViewControllerAnimated:animated];
}

@end
