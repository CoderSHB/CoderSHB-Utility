//
//  UIColor+Utility.h
//  UIColor+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2014年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utility)

/**
 *  根据16进制数据获取颜色
 *
 *  @param hexString 16进制颜色值
 *
 *  @return 返回颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
