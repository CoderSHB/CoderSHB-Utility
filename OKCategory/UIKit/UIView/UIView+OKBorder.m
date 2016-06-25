//
//  UIView+OKBorder
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIView+OKBorder.h"

@implementation UIView (OKBorder)

- (void)ok_clearBorderStyle {
    self.layer.borderWidth   = 0;
    self.layer.masksToBounds = YES;
}

+ (UIView *)ok_createDashedLineWithFrame:(CGRect)lineFrame
                              lineLength:(CGFloat)length
                             lineSpacing:(CGFloat)spacing
                               lineColor:(UIColor *)color {
    
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:@[@(length), @(spacing)]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize borderType:(OKBorderType)type {
    [self ok_addBorderWithColor:color borderSize:borderSize opacity:1.0 margin:0.0 borderType:type];
}

- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize margin:(CGFloat)margin borderType:(OKBorderType)type {
    
    [self ok_addBorderWithColor:color borderSize:borderSize opacity:1.0 margin:margin borderType:type];

}

- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize opacity:(float)opacity borderType:(OKBorderType)type {
    
    [self ok_addBorderWithColor:color borderSize:borderSize opacity:opacity margin:0.0 borderType:type];
}

- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize opacity:(float)opacity margin:(CGFloat)margin borderType:(OKBorderType)type {
    
    if (type & OKBorderTypeTop) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, 0, self.frame.size.width - margin, borderSize);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeLeft) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, 0, borderSize, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeBottom) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, self.frame.size.height - borderSize, self.frame.size.width - margin, borderSize);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeRight) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(self.frame.size.width - borderSize, 0, borderSize, self.frame.size.height);
        [self.layer addSublayer:border];
    }
}

//- (void)ok_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
//    [self ok_addTopBorderWithColor:color andWidth:borderWidth andOpacity:1.0];
//}
//
//- (void)ok_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
//    [self ok_addBottomBorderWithColor:color andWidth:borderWidth andOpacity:1.0];
//}
//
//- (void)ok_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
//    [self ok_addLeftBorderWithColor:color andWidth:borderWidth andOpacity:1.0];
//}
//
//- (void)ok_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
//    [self ok_addRightBorderWithColor:color andWidth:borderWidth andOpacity:1.0];
//}
//
//- (void)ok_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity {
//    CALayer *border = [CALayer layer];
//    border.opacity         = opacity;
//    border.backgroundColor = color.CGColor;
//    border.frame           = CGRectMake(0, 0, self.frame.size.width, borderWidth);
//    [self.layer addSublayer:border];
//}
//
//- (void)ok_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity {
//    CALayer *border = [CALayer layer];
//    border.opacity         = opacity;
//    border.backgroundColor = color.CGColor;
//    border.frame           = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
//    [self.layer addSublayer:border];
//}
//
//- (void)ok_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity {
//    CALayer *border = [CALayer layer];
//    border.opacity         = opacity;
//    border.backgroundColor = color.CGColor;
//    border.frame           = CGRectMake(0, 0, borderWidth, self.frame.size.height);
//    [self.layer addSublayer:border];
//}
//
//- (void)ok_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity {
//    CALayer *border = [CALayer layer];
//    border.opacity         = opacity;
//    border.backgroundColor = color.CGColor;
//    border.frame           = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
//    [self.layer addSublayer:border];
//}

@end
