//
//  UIColor+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIColor+OKCategory.h"

@implementation UIColor (OKCategory)
+ (UIColor *)ok_randomColor {

    UIColor *color;
    float   randomRed   = (arc4random()%255)/255.0f;
    float   randomGreen = (arc4random()%255)/255.0f;
    float   randomBlue  = (arc4random()%255)/255.0f;

    color = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];

    return color;
}

- (UIColor *)ok_invertedColor {
    NSArray *components = [self componentArray];
    return [UIColor colorWithRed:1-[components[0] doubleValue] green:1-[components[1] doubleValue] blue:1-[components[2] doubleValue] alpha:[components[3] doubleValue]];
}

- (NSArray *)componentArray {
    CGFloat red, green, blue, alpha;
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    if (CGColorGetNumberOfComponents([self CGColor]) == 2) {
        red   = components[0];
        green = components[0];
        blue  = components[0];
        alpha = components[1];
    } else {
        red   = components[0];
        green = components[1];
        blue  = components[2];
        alpha = components[3];
    }
    return @[@(red), @(green), @(blue), @(alpha)];
}

+ (UIColor *)ok_colorWithHexString:(NSString *)hexString {
    return [self ok_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)ok_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {

    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat  red, blue, green;
    switch ([colorString length]) {
    case 3:         // #RGB
        red   = [self colorComponentFrom:colorString start:0 length:1];
        green = [self colorComponentFrom:colorString start:1 length:1];
        blue  = [self colorComponentFrom:colorString start:2 length:1];
        break;
    case 4:         // #ARGB
        red   = [self colorComponentFrom:colorString start:1 length:1];
        green = [self colorComponentFrom:colorString start:2 length:1];
        blue  = [self colorComponentFrom:colorString start:3 length:1];
        break;
    case 6:         // #RRGGBB
        red   = [self colorComponentFrom:colorString start:0 length:2];
        green = [self colorComponentFrom:colorString start:2 length:2];
        blue  = [self colorComponentFrom:colorString start:4 length:2];
        break;
    case 8:         // #AARRGGBB
        red   = [self colorComponentFrom:colorString start:2 length:2];
        green = [self colorComponentFrom:colorString start:4 length:2];
        blue  = [self colorComponentFrom:colorString start:6 length:2];
        break;
    default:
        red = 0; green = 0; blue = 0; alpha = 1;
        break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex   = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

#pragma mark - UIColor with RGB value
+ (UIColor *)colorWithRGB:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha {

    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha];
}

#pragma mark - Gradient Color

+ (UIColor *)ok_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(int)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef    context    = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();

    NSArray       *colors  = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();

    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)ok_fetchColorAtImage:(UIImage *)image {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif

    CGSize          thumbSize  = CGSizeMake(50, 50);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context    = CGBitmapContextCreate(NULL,
                                                       thumbSize.width,
                                                       thumbSize.height,
                                                       8,//bits per component
                                                       thumbSize.width*4,
                                                       colorSpace,
                                                       bitmapInfo);

    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);

    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red    = data[offset];
            int green  = data[offset+1];
            int blue   = data[offset+2];
            int alpha  = data[offset+3];

            NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);

    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray      *curColor   = nil;
    NSArray      *MaxColor   = nil;
    NSUInteger   MaxCount    = 0;
    while ( (curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if (tmpCount < MaxCount) continue;
        MaxCount = tmpCount;
        MaxColor = curColor;
    }

    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

@end
