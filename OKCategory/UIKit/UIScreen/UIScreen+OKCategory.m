//
//  UIScreen+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIScreen+OKCategory.h"

@implementation UIScreen (OKCategory)
+ (CGSize)ok_screenSize {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)ok_screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)ok_screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)ok_orientationSize {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
    BOOL isLand = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion > 8.0 && isLand) ? SizeSWAP([UIScreen ok_screenSize]) : [UIScreen ok_screenSize];
}

+ (CGFloat)ok_orientationWidth {
    return [UIScreen ok_orientationSize].width;
}

+ (CGFloat)ok_orientationHeight {
    return [UIScreen ok_orientationSize].height;
}

+ (CGSize)ok_DPISize {
    CGSize  size  = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

/**
 *  交换高度与宽度
 */
static inline CGSize SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}

@end
