//
//  UIImage+OKStretch
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (OKStretch)

/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END