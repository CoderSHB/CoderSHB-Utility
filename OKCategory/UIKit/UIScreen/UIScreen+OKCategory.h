//
//  UIScreen+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (OKCategory)

+ (CGSize)ok_screenSize;
+ (CGFloat)ok_screenWidth;
+ (CGFloat)ok_screenHeight;

+ (CGSize)ok_orientationSize;
+ (CGFloat)ok_orientationWidth;
+ (CGFloat)ok_orientationHeight;
+ (CGSize)ok_DPISize;

@end

NS_ASSUME_NONNULL_END