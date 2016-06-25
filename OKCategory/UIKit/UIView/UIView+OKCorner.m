//
//  UIView+OKCorner
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIView+OKCorner.h"

@implementation UIView (OKCornerPrivate)

- (void)__roundedCornerOnSide:(UIRectCorner)corners withRadious:(CGFloat)radious {
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:[(id)self bounds]
                                           byRoundingCorners:corners
                                                 cornerRadii:(CGSize){radious, radious}].CGPath;
    
    
    [(id)self setClipsToBounds:YES];
}

@end


@implementation UIView (OKCorner)

- (void)ok_cornerRadiusStyleWithValue:(CGFloat)value {
    self.layer.cornerRadius  = value;
    self.layer.masksToBounds = YES;
}

- (void)ok_roundedWidthStyle {
    self.layer.cornerRadius  = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

- (void)ok_roundedHeightStyle {
    self.layer.cornerRadius  = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
}

- (void)ok_roundedCornersOnTopWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerTopLeft | UIRectCornerTopRight
                    withRadious:radious];
}

- (void)ok_roundedCornersOnTopLeftWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerTopLeft
                    withRadious:radious];
}

- (void)ok_roundedCornersOnTopRightWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerTopRight
                    withRadious:radious];
}

- (void)ok_roundedCornersOnBottomWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerBottomLeft | UIRectCornerBottomRight
                    withRadious:radious];
}

- (void)ok_roundedCornersOnBottomLeftWithRadious:(CGFloat)radious  {
    
    [self __roundedCornerOnSide:UIRectCornerBottomLeft
                    withRadious:radious];
}

- (void)ok_roundedCornersOnBottomRightWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerBottomRight
                    withRadious:radious];
}

- (void)ok_roundedCornersOnAllSideWithRadious:(CGFloat)radious {
    
    [self __roundedCornerOnSide:UIRectCornerAllCorners
                    withRadious:radious];
}

@end
