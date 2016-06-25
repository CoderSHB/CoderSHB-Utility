//
//  UIButton+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIButton+OKCategory.h"
#import <objc/runtime.h>
#import "UIImage+OKCategory.h"

static const void *__UIButtonBlockKey = &__UIButtonBlockKey;

static NSString *const kIndicatorViewKey    = @"indicatorView";
static NSString *const kButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (OKCategory)
//#ifdef Insepectable_enable
//- (void)setTitleHexColor:(NSString *)titleHexColor {
//    NSScanner *scanner = [NSScanner scannerWithString:titleHexColor];
//    unsigned  hexNum;
//    if (![scanner scanHexInt:&hexNum]) return;
//    [self setTitleColor:[self colorWithRGBHex:hexNum] forState:UIControlStateNormal];
//}
//
//- (NSString *)titleHexColor {
//    return @"0xffffff";
//}
//
//- (UIColor *)colorWithRGBHex:(UInt32)hex {
//    int r = (hex >> 16) & 0xFF;
//    int g = (hex >> 8) & 0xFF;
//    int b = (hex) & 0xFF;
//
//    return [UIColor colorWithRed:r / 255.0f
//                           green:g / 255.0f
//                            blue:b / 255.0f
//                           alpha:1.0f];
//}
//#endif
- (UIEdgeInsets)touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

/**
 *  @brief  设置按钮额外热区
 */
- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect       bounds          = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)ok_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage ok_imageWithColor:backgroundColor] forState:state];
}

- (void)ok_showIndicator {

    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];

    NSString *currentButtonText = self.titleLabel.text;

    objc_setAssociatedObject(self, &kButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];


}

- (void)ok_hideIndicator {

    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &kButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &kIndicatorViewKey);

    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    self.enabled = YES;
}

- (void)ok_addAction:(UIButtonBlock)block {
    objc_setAssociatedObject(self, __UIButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(__action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ok_addAction:(UIButtonBlock)block forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, __UIButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(__action:) forControlEvents:controlEvents];
}

- (void)__action:(id)sender {
    UIButtonBlock blockAction = (UIButtonBlock)objc_getAssociatedObject(self, __UIButtonBlockKey);
    if (blockAction) {
        blockAction(self);
    }
}

- (void)ok_startTime:(NSInteger)timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle {
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t  queue   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@", strTime);
                [self setTitle:[NSString stringWithFormat:@"%@%@", strTime, waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;

            });
            timeOut--;

        }
    });
    dispatch_resume(_timer);
}

@end
