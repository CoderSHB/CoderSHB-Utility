//
//  NSTimer+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSTimer+OKCategory.h"

@implementation NSTimer (OKCategory)

#pragma mark - private

+ (void)__executeSimpleBlock:(NSTimer *)aTimer {
    if ([aTimer userInfo]) {
        void (^block)() = (void (^)())[aTimer userInfo];
        block();
    }
}

/**
 *  @brief  暂停NSTimer
 */
- (void)ok_pauseTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  @brief  开始NSTimer
 */
- (void)ok_resumeTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  @brief  延迟开始NSTimer
 */
- (void)ok_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

+ (id)ok_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                  block:(void (^)())aBlock
                                repeats:(BOOL)yesOrNo {

    void (^block)() = [aBlock copy];

    id ret = [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(__executeSimpleBlock:) userInfo:block repeats:yesOrNo];
    return ret;
}

+ (id)ok_timerWithTimeInterval:(NSTimeInterval)ti
                         block:(void (^)())aBlock
                       repeats:(BOOL)yesOrNo {

    void (^block)() = [aBlock copy];

    id ret = [self timerWithTimeInterval:ti target:self selector:@selector(__executeSimpleBlock:) userInfo:block repeats:yesOrNo];
    return ret;
}

@end
