//
//  NSObject+OKRuntime
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OKRuntime)

/**
 *  @brief 交换方法实现
 *
 *  @param originalMethod 原始方法实现
 *  @param newMethod      新方法实现
 */
+ (void)ok_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 *  @brief 给类添加方法
 *
 *  @param newMethod 添加的方法
 *  @param aClass    要添加的类
 */
+ (void)ok_appendMethod:(SEL)newMethod fromClass:(Class)aClass;

/**
 *  @brief 替换一个类的方法
 *
 *  @param method 要替换的方法
 *  @param aClass 方法所在的类
 */
+ (void)ok_replaceMethod:(SEL)method fromClass:(Class)aClass;

/**
 *  @brief 自己及父类中的能否响应selector
 *
 *  @param selector  要响应的selector
 *  @param stopClass 停止遍历的类
 *
 *  @return 能否响应
 */
- (BOOL)ok_respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 *  @brief 父类是否能响应某方法
 *
 *  @param selector 方法
 *
 *  @return 是否能响应
 */
- (BOOL)ok_superRespondsToSelector:(SEL)selector;

/**
 *  @brief 父类树中能否响应selector
 *
 *  @param selector  要响应的selector
 *  @param stopClass 停止遍历的类
 *
 *  @return 是否有能响应的类
 */
- (BOOL)ok_superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

+ (BOOL)ok_instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;

@end

NS_ASSUME_NONNULL_END