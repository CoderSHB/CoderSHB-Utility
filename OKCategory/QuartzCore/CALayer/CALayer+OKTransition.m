//
//  CALayer+OKTransition.h
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "CALayer+OKTransition.h"

@implementation CALayer (OKPrivate)

/*
 *  返回动画曲线
 */
-(NSString *)__curve:(OKTransitionCurve)curve{
    
    //曲线数组
    NSArray *funcNames=@[kCAMediaTimingFunctionDefault,kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionLinear];
    
    return [self __objFromArray:funcNames index:curve isRamdom:(OKTransitionCurveRamdom == curve)];
}

/*
 *  返回动画方向
 */
-(NSString *)__animaSubtype:(OKTransitionSubType)subType{
    
    //设置转场动画的方向
    NSArray *subtypes=@[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight];
    
    return [self __objFromArray:subtypes index:subType isRamdom:(OKTransitionSubtypesFromRamdom == subType)];
}

/*
 *  返回动画类型
 */
-(NSString *)__animaTypeWithTransitionType:(OKTransitionAnimType)type{
    
    //设置转场动画的类型
    NSArray *animArray=@[@"rippleEffect",@"suckEffect",@"pageCurl",@"oglFlip",@"cube",@"reveal",@"pageUnCurl",@"push"];
    
    return [self __objFromArray:animArray index:type isRamdom:(OKTransitionAnimTypeRamdom == type)];
}

/*
 *  统一从数据返回对象
 */
-(id)__objFromArray:(NSArray *)array index:(NSUInteger)index isRamdom:(BOOL)isRamdom{
    
    NSUInteger count = array.count;
    
    NSUInteger i = isRamdom?arc4random_uniform((u_int32_t)count) : index;
    
    return array[i];
}

@end


@implementation CALayer (OKTransition)

/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subtype  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
-(CATransition *)ok_transitionWithAnimType:(OKTransitionAnimType)animType subType:(OKTransitionSubType)subType curve:(OKTransitionCurve)curve duration:(CGFloat)duration{
    
    NSString *key = @"transition";
    
    if([self animationForKey:key]!=nil){
        [self removeAnimationForKey:key];
    }
    
    
    CATransition *transition=[CATransition animation];
    
    //动画时长
    transition.duration=duration;
    
    //动画类型
    transition.type=[self __animaTypeWithTransitionType:animType];
    
    //动画方向
    transition.subtype=[self __animaSubtype:subType];
    
    //缓动函数
    transition.timingFunction=[CAMediaTimingFunction functionWithName:[self __curve:curve]];
    
    //完成动画删除
    transition.removedOnCompletion = YES;
    
    [self addAnimation:transition forKey:key];
    
    return transition;
}

@end
