//
//  NSObject+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OKCategory)

+ (nullable Class)ok_rootClass;

- (NSString *)ok_superClassName;
+ (NSString *)ok_superClassName;

- (NSString *)ok_className;
+ (NSString *)ok_className;

/// 实例变量列表
+ (NSArray *)ok_instanceVariableList;

/// 属性名称列表
- (NSArray *)ok_propertyList;
+ (NSArray *)ok_propertyList;
/// 格式化后的属性列表
+ (NSArray *)ok_propertiesWithCodeFormat;

/// 实例属性字典
- (NSDictionary *)ok_propertiesDictionary;

/// 创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)ok_registedClassList;

/// 方法列表
- (NSArray *)ok_methodList;
+ (NSArray *)ok_methodList;

- (NSArray *)ok_methodListInfo;

/// 协议列表
- (NSDictionary *)ok_protocolList;
+ (NSDictionary *)ok_protocolList;

/**
 *  计算执行Block内部代码所需时间
 *
 *  @param block  执行代码
 *  @param prefix 打印语句前缀
 */
- (void)ok_logRunTimeWithBlock:(void (^)(void))block prefix:(NSString *)prefix;

/**
 *  @brief  附加一个stong对象
 *
 *  @param value 被附加的对象
 *  @param aKey  被附加对象的key
 */
- (void)ok_stronglyAssociateWithValue:(id)value forKey:(void *)aKey;

/**
 *  @brief  附加一个weak对象
 *
 *  @param value 被附加的对象
 *  @param aKey  被附加对象的key
 */
- (void)ok_weaklyAssociateWithValue:(id)value forKey:(void *)aKey;

/**
 *  @brief  根据附加对象的key取出附加对象
 *
 *  @param aKey 附加对象的key
 *
 *  @return 附加对象
 */
- (id)ok_associatedValueForKey:(void *)aKey;

/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)ok_performAsynchronous:(void (^)(void))block;

/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)ok_performOnMainThread:(void (^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)ok_performAfter:(NSTimeInterval)seconds block:(void (^)(void))block;

- (id)ok_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)ok_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)ok_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (id)ok_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)ok_cancelBlock:(id)block;
+ (void)ok_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end

NS_ASSUME_NONNULL_END