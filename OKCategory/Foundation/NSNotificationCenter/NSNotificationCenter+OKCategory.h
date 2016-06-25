//
//  NSNotificationCenter+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (OKCategory)

/**
 *  @brief  在主线程中发送一条通知
 *
 *  @param notification NSNotification对象
 */
- (void)ok_postNotificationOnMainThread:(NSNotification *)notification;

/**
 *  @brief  在主线程中发送一条通知
 *
 *  @param aName    用来生成新通知的通知名称
 *  @param anObject 通知携带的对象
 */
- (void)ok_postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject;

/**
 *  @brief  在主线程中发送一条通知
 *
 *  @param aName     用来生成新通知的通知名称
 *  @param anObject  通知携带的对象
 *  @param aUserInfo 通知携带的用户信息
 */
- (void)ok_postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end

NS_ASSUME_NONNULL_END