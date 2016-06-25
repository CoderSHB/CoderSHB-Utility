//
//  NSString+OKDevice
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OKDevice)

/**
 *  是否是320宽度屏幕
 */
FOUNDATION_EXTERN BOOL isiPhone4InchW();

/**
 *  判断是否是iPhone4,4S
 */
+ (BOOL)isiPhone4;

/**
 *  判断是否是iPhone5,5C,5S
 */
+ (BOOL)isiPhone5;

/**
 *  判断是否是iPhone6,6S
 */
+ (BOOL)isiPhone6;

/**
 *  判断是否是iPhone6 Plus,6S Plus
 */
+ (BOOL)isiPhone6P;

@end

NS_ASSUME_NONNULL_END