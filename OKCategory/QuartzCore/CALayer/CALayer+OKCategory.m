//
//  CALayer+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "CALayer+OKCategory.h"

UIViewContentMode SSCAGravityToUIViewContentMode(NSString *gravity){
    static NSDictionary    *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{ kCAGravityCenter:@(UIViewContentModeCenter),
                 kCAGravityTop:@(UIViewContentModeTop),
                 kCAGravityBottom:@(UIViewContentModeBottom),
                 kCAGravityLeft:@(UIViewContentModeLeft),
                 kCAGravityRight:@(UIViewContentModeRight),
                 kCAGravityTopLeft:@(UIViewContentModeTopLeft),
                 kCAGravityTopRight:@(UIViewContentModeTopRight),
                 kCAGravityBottomLeft:@(UIViewContentModeBottomLeft),
                 kCAGravityBottomRight:@(UIViewContentModeBottomRight),
                 kCAGravityResize:@(UIViewContentModeScaleToFill),
                 kCAGravityResizeAspect:@(UIViewContentModeScaleAspectFit),
                 kCAGravityResizeAspectFill:@(UIViewContentModeScaleAspectFill) };
    });
    if (!gravity) return UIViewContentModeScaleToFill;
    return (UIViewContentMode)((NSNumber *)dic[gravity]).integerValue;
}

NSString *SSUIViewContentModeToCAGravity(UIViewContentMode contentMode){
    switch (contentMode) {
    case UIViewContentModeScaleToFill:      return kCAGravityResize;
    case UIViewContentModeScaleAspectFit:   return kCAGravityResizeAspect;
    case UIViewContentModeScaleAspectFill:  return kCAGravityResizeAspectFill;
    case UIViewContentModeRedraw:           return kCAGravityResize;
    case UIViewContentModeCenter:           return kCAGravityCenter;
    case UIViewContentModeTop:              return kCAGravityTop;
    case UIViewContentModeBottom:           return kCAGravityBottom;
    case UIViewContentModeLeft:             return kCAGravityLeft;
    case UIViewContentModeRight:            return kCAGravityRight;
    case UIViewContentModeTopLeft:          return kCAGravityTopLeft;
    case UIViewContentModeTopRight:         return kCAGravityTopRight;
    case UIViewContentModeBottomLeft:       return kCAGravityBottomLeft;
    case UIViewContentModeBottomRight:      return kCAGravityBottomRight;
    default:                                return kCAGravityResize;
    }
}

@implementation CALayer (OKCategory)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setContentsUIImage:(UIImage *)bgImage {
    self.contents = (__bridge id)(bgImage.CGImage);
}

- (UIImage *)contentsUIImage {
    return self.contents;
}

- (CGFloat)transformRotation {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation"];
    return v.doubleValue;
}

- (void)setTransformRotation:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation"];
}

- (CGFloat)transformRotationX {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.x"];
    return v.doubleValue;
}

- (void)setTransformRotationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.x"];
}

- (CGFloat)transformRotationY {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.y"];
    return v.doubleValue;
}

- (void)setTransformRotationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.y"];
}

- (CGFloat)transformRotationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.z"];
    return v.doubleValue;
}

- (void)setTransformRotationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.z"];
}

- (CGFloat)transformScaleX {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.x"];
    return v.doubleValue;
}

- (void)setTransformScaleX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.x"];
}

- (CGFloat)transformScaleY {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.y"];
    return v.doubleValue;
}

- (void)setTransformScaleY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.y"];
}

- (CGFloat)transformScaleZ {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.z"];
    return v.doubleValue;
}

- (void)setTransformScaleZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.z"];
}

- (CGFloat)transformScale {
    NSNumber *v = [self valueForKeyPath:@"transform.scale"];
    return v.doubleValue;
}

- (void)setTransformScale:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale"];
}

- (CGFloat)transformTranslationX {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.x"];
    return v.doubleValue;
}

- (void)setTransformTranslationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.x"];
}

- (CGFloat)transformTranslationY {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.y"];
    return v.doubleValue;
}

- (void)setTransformTranslationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.y"];
}

- (CGFloat)transformTranslationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.z"];
    return v.doubleValue;
}

- (void)setTransformTranslationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.z"];
}

- (CGFloat)transformDepth {
    return self.transform.m34;
}

- (void)setTransformDepth:(CGFloat)v {
    CATransform3D d = self.transform;
    d.m34          = v;
    self.transform = d;
}

- (UIViewContentMode)contentMode {
    return SSCAGravityToUIViewContentMode(self.contentsGravity);
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    self.contentsGravity = SSUIViewContentModeToCAGravity(contentMode);
}

- (UIImage *)ok_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)ok_snapshotPDF {
    CGRect            bounds   = self.bounds;
    NSMutableData     *data    = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef      context  = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)ok_setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.shadowColor        = color.CGColor;
    self.shadowOffset       = offset;
    self.shadowRadius       = radius;
    self.shadowOpacity      = 1;
    self.shouldRasterize    = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)ok_removeAllSublayers {
    while (self.sublayers.count) {
        [self.sublayers.lastObject removeFromSuperlayer];
    }
}

- (void)ok_addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve {
    if (duration <= 0) return;

    NSString *mediaFunction;
    switch (curve) {
    case UIViewAnimationCurveEaseInOut: {
        mediaFunction = kCAMediaTimingFunctionEaseOut;
    } break;
    case UIViewAnimationCurveEaseIn: {
        mediaFunction = kCAMediaTimingFunctionEaseIn;
    } break;
    case UIViewAnimationCurveEaseOut: {
        mediaFunction = kCAMediaTimingFunctionEaseInEaseOut;
    } break;
    case UIViewAnimationCurveLinear: {
        mediaFunction = kCAMediaTimingFunctionLinear;
    } break;
    default: {
        mediaFunction = kCAMediaTimingFunctionLinear;
    } break;
    }

    CATransition *transition = [CATransition animation];
    transition.duration       = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:mediaFunction];
    transition.type           = kCATransitionFade;
    [self addAnimation:transition forKey:@"SSToolKit.fade"];
}

- (void)ok_removePreviousFadeAnimation {
    [self removeAnimationForKey:@"SSToolKit.fade"];
}

@end
