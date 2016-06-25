//
//  UIView+OKAnimation
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

float radiansForDegrees(int degrees);

@interface UIView (OKAnimation)

- (void)ok_fadeOut ;

- (void)ok_fadeOutAndRemoveFromSuperview ;

- (void)ok_fadeIn ;

// Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(nullable id)delegate callback:(nullable SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(nullable id)delegate callback:(nullable SEL)method;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(nullable id)delegate callback:(nullable SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(nullable id)delegate callback:(nullable SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs;
- (void)pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)addSubviewWithFadeAnimation:(UIView *)subview;

@end

NS_ASSUME_NONNULL_END