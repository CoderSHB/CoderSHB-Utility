//
//  NSTimer+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (OKCategory)

/**
 *  @brief  暂停NSTimer
 */
- (void)ok_pauseTimer;

/**
 *  @brief  开始NSTimer
 */
- (void)ok_resumeTimer;

/**
 *  @brief  延迟开始NSTimer
 */
- (void)ok_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

+ (id)ok_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                  block:(nullable void (^)())aBlock
                                repeats:(BOOL)yesOrNo;

+ (id)ok_timerWithTimeInterval:(NSTimeInterval)ti
                         block:(nullable void (^)())aBlock
                       repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END