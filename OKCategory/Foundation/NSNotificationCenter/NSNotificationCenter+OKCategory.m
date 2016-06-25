//
//  NSNotificationCenter+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSNotificationCenter+OKCategory.h"

@implementation NSNotificationCenter (OKCategory)

/*!
 *  @brief  在主线程中发送一条通知
 *
 *  @param notification 一条通知
 */
- (void)ok_postNotificationOnMainThread:(NSNotification *)notification {
    [self performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:YES];
}

/*!
 *  @brief  在主线程中发送一条通知
 *
 *  @param aName    用来生成新通知的通知名称
 *  @param anObject 通知携带的对象
 */
- (void)ok_postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject {
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject];
    [self ok_postNotificationOnMainThread:notification];
}

/*!
 *  @brief  在主线程中发送一条通知
 *
 *  @param aName     用来生成新通知的通知名称
 *  @param anObject  通知携带的对象
 *  @param aUserInfo 通知携带的用户信息
 */
- (void)ok_postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo];
    [self ok_postNotificationOnMainThread:notification];
}

@end
