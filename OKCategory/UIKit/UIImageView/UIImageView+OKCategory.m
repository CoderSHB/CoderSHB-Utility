//
//  UIImageView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIImageView+OKCategory.h"

@implementation UIImageView (OKCategory)

- (void)ok_reflect {
    CGRect frame = self.frame;
    frame.origin.y += (frame.size.height + 1);

    UIImageView *reflectionImageView = [[UIImageView alloc] initWithFrame:frame];
    self.clipsToBounds              = TRUE;
    reflectionImageView.contentMode = self.contentMode;
    [reflectionImageView setImage:self.image];
    reflectionImageView.transform = CGAffineTransformMakeScale(1.0, -1.0);

    CALayer *reflectionLayer = [reflectionImageView layer];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds   = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors   = [NSArray arrayWithObjects:
                              (id)[[UIColor clearColor] CGColor],
                              (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] CGColor], nil];

    gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    gradientLayer.endPoint   = CGPointMake(0.5, 1.0);
    reflectionLayer.mask     = gradientLayer;

    [self.superview addSubview:reflectionImageView];

}

+ (UIImageView *)ok_imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration {
    if (imageArray && [imageArray count] == 0) {
        return nil;
    }

    UIImageView    *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageArray objectAtIndex:0]]];
    NSMutableArray *images    = [NSMutableArray array];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    [imageView setImage:[images objectAtIndex:0]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    return imageView;
}

- (void)ok_setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    // CGContextRef thisctx = UIGraphicsGetCurrentContext();
    // CGAffineTransform myTr = CGAffineTransformMake(1, 0, 0, -1, 0, self.height);
    // CGContextConcatCTM(thisctx, myTr);
    //CGContextDrawImage(thisctx,CGRectMake(0,0,self.width,self.height),[image CGImage]); //原图
    //CGContextDrawImage(thisctx,rect,[mask CGImage]); //水印图
    //原图
    [image drawInRect:self.bounds];
    //水印图
    [mark drawInRect:rect];
    // NSString *s = @"dfd";
    // [[UIColor redColor] set];
    // [s drawInRect:self.bounds withFont:[UIFont systemFontOfSize:15.0]];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

- (void)ok_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    //原图
    [image drawInRect:self.bounds];
    //文字颜色
    [color set];
    //水印文字

    if ([markString respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        [markString drawAtPoint:point withAttributes:@{NSFontAttributeName:font}];
    } else {
        // pre-iOS7.0
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [markString drawAtPoint:point withFont:font];
#pragma clang diagnostic pop
    }


    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

- (void)ok_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    //原图
    [image drawInRect:self.bounds];
    //文字颜色
    [color set];
    // const CGFloat *colorComponents = CGColorGetComponents([color CGColor]);
    // CGContextSetRGBFillColor(context, colorComponents[0], colorComponents[1], colorComponents [2], colorComponents[3]);
    //水印文字
    if ([markString respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        [markString drawInRect:rect withAttributes:@{NSFontAttributeName:font}];
    } else {
        // pre-iOS7.0
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [markString drawInRect:rect withFont:font];
#pragma clang diagnostic pop
    }

    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

@end
