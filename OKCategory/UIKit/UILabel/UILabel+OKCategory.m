//
//  UILabel+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UILabel+OKCategory.h"

@implementation UILabel (OKCategory)
//#ifdef Insepectable_enable
//
//- (void)setTextHexColor:(NSString *)textHexColor{
//    NSScanner *scanner = [NSScanner scannerWithString:textHexColor];
//    unsigned hexNum;
//    if (![scanner scanHexInt:&hexNum]) return;
//    self.textColor = [self colorWithRGBHex:hexNum];
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
//
//- (NSString *)textHexColor{
//    return @"0xffffff";
//}
//
//#endif

-(void)ok_setBackgroundImage:(UIImage *)bgImage {
    
    UIColor *color = [UIColor colorWithPatternImage:bgImage];
    self.backgroundColor = color;
}
@end
