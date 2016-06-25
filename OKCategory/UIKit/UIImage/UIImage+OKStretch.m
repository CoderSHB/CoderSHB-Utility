//
//  UIImage+OKStretch
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIImage+OKStretch.h"

@implementation UIImage (OKStretch)

#pragma mark  拉伸图片:自定义比例
+ (UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap {
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftCap topCapHeight:image.size.height * topCap];
}

#pragma mark  拉伸图片
+ (UIImage *)resizeWithImageName:(NSString *)name {
    return [self resizeWithImageName:name leftCap:.5f topCap:.5f];
}

@end
