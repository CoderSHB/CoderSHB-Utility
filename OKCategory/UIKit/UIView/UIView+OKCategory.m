//
//  UIView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIView+OKCategory.h"

@implementation UIView (OKCategory)

- (void)setOk_x:(CGFloat)ok_x {
    CGRect frame = self.frame;
    frame.origin.x = ok_x;
    self.frame     = frame;
}

- (CGFloat)ok_x {
    return self.frame.origin.x;
}

- (void)setOk_maxX:(CGFloat)ok_maxX {
    self.ok_x = ok_maxX - self.ok_width;
}

- (CGFloat)ok_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setOk_maxY:(CGFloat)ok_maxY {
    self.ok_y = ok_maxY - self.ok_height;
}

- (CGFloat)ok_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setOk_y:(CGFloat)ok_y {
    CGRect frame = self.frame;
    frame.origin.y = ok_y;
    self.frame     = frame;
}

- (CGFloat)ok_y {
    return self.frame.origin.y;
}

- (void)setOk_centerX:(CGFloat)ok_centerX {
    CGPoint center = self.center;
    center.x    = ok_centerX;
    self.center = center;
}

- (CGFloat)ok_centerX {
    return self.center.x;
}

- (void)setOk_centerY:(CGFloat)ok_centerY {
    CGPoint center = self.center;
    center.y    = ok_centerY;
    self.center = center;
}

- (CGFloat)ok_centerY {
    return self.center.y;
}

- (void)setOk_width:(CGFloat)ok_width {
    CGRect frame = self.frame;
    frame.size.width = ok_width;
    self.frame       = frame;
}

- (CGFloat)ok_width {
    return self.frame.size.width;
}

- (void)setOk_height:(CGFloat)ok_height {
    CGRect frame = self.frame;
    frame.size.height = ok_height;
    self.frame        = frame;
}

- (CGFloat)ok_height {
    return self.frame.size.height;
}

- (CGPoint)ok_origin {
    return self.frame.origin;
}

- (void)setOk_origin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame      = newframe;
}

- (void)setOk_size:(CGSize)ok_size {
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = ok_size;
    self.frame = frame;
}

- (CGSize)ok_size {
    return self.frame.size;
}

- (UIColor *)ok_fetchColorAtPosition:(CGPoint)position {
    CGPoint p = CGPointMake(position.x / self.frame.size.width, position.y / self.frame.size.height);

    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGImageRef        cgImage      = [image CGImage];
    CGDataProviderRef provider     = CGImageGetDataProvider(cgImage);
    CFDataRef         bitmapData   = CGDataProviderCopyData(provider);
    const UInt8       *data        = CFDataGetBytePtr(bitmapData);
    size_t            bytesPerRow  = CGImageGetBytesPerRow(cgImage);
    size_t            width        = CGImageGetWidth(cgImage);
    size_t            height       = CGImageGetHeight(cgImage);
    int               col          = p.x*(width-1);
    int               row          = p.y*(height-1);
    const UInt8       *pixel       = data + row*bytesPerRow+col*4;
    UIColor           *returnColor = [UIColor colorWithRed:pixel[2]/255. green:pixel[1]/255. blue:pixel[0]/255. alpha:1.0];
    CFRelease(bitmapData);
    return returnColor;
}

- (UIImage *)ok_snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }

    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIView *)ok_findViewRecursively:(BOOL (^)(UIView *subview, BOOL *stop))recurse {
    for (UIView *subview in self.subviews) {
        BOOL stop = NO;
        if (recurse(subview, &stop) ) {
            return [subview ok_findViewRecursively:recurse];
        } else if (stop) {
            return subview;
        }
    }
    return nil;
}

- (BOOL)ok_findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }

    for (UIView *v in self.subviews) {
        if ([v ok_findAndResignFirstResponder]) {
            return YES;
        }
    }

    return NO;
}

- (UIView *)ok_findFirstResponder {

    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }

    for (UIView *v in self.subviews) {
        UIView *fv = [v ok_findFirstResponder];
        if (fv) {
            return fv;
        }
    }

    return nil;
}

- (NSArray *)ok_superviews {
    NSMutableArray *superviews = [[NSMutableArray alloc] init];

    UIView *view      = self;
    UIView *superview = nil;
    while (view) {
        superview = [view superview];
        if (!superview) {
            break;
        }

        [superviews addObject:superview];
        view = superview;
    }

    return superviews;
}

- (void)ok_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

+ (void)ok_removeViews:(NSArray *)views {

    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
    });
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (NSString *)ok_recursiveView {
    NSString *description = [NSString stringWithFormat:@"%s [Line %d] \r\r %@",
                             __PRETTY_FUNCTION__, __LINE__,
                             [self performSelector:@selector(recursiveDescription)]];
    return description;
}

- (NSString *)ok_constraintsDescription {
    NSString *description = [NSString stringWithFormat:@"%s [Line %d] \r\r %@ \r\r",
                             __PRETTY_FUNCTION__, __LINE__,
                             [[self constraints] description]];
    return description;
}

- (NSString *)ok_autolayoutTraceDescription {
    NSString *description = [NSString stringWithFormat:@"%s [Line %d] \r\r %@",
                             __PRETTY_FUNCTION__, __LINE__,
                             [self performSelector:@selector(_autolayoutTrace)]];
    return description;
}

#pragma clang diagnostic pop

@end
