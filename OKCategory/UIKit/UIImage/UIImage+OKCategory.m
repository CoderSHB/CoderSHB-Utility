//
//  UIImage+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIImage+OKCategory.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
//#import "UIDevice+OKCategory.h"

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey     = &FailBlockKey;

@interface UIImage ()

@property (nonatomic, copy)  void (^CompleteBlock)();
@property (nonatomic, copy)  void (^FailBlock)(NSError *);

@end


@implementation UIImage (OKPrivateCategory)

- (void)__addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (NSCache *)__cache {
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

@end

@implementation UIImage (OKCategory)

- (void (^)())FailBlock {
    return objc_getAssociatedObject(self, FailBlockKey);
}

- (void)setFailBlock:(void (^)())FailBlock {
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())CompleteBlock {
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

- (void)setCompleteBlock:(void (^)())CompleteBlock {
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

/// 保存相册
- (void)ok_savedPhotosAlbumWithCompleteBlock:(void (^)())completeBlock failBlock:(void (^)(NSError *))failBlock {

    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

    self.CompleteBlock = completeBlock;
    self.FailBlock     = failBlock;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error == nil) {
        if (self.CompleteBlock != nil) self.CompleteBlock();
    } else {
        if (self.FailBlock != nil) self.FailBlock(error);
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIImage *)ok_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIImage *)ok_screenshots {
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];

    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window

    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return viewImage;
}

+ (UIImage *)ok_screenshotsWithoutStateBar {
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect   screenRect    = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20);

    UIGraphicsBeginImageContext(screenRect.size);//全屏截图，包括window

    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return viewImage;
}

+ (UIImage *)ok_imageFromView:(UIView *)theView {

    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return theImage;
}

+ (UIImage *)ok_imageFromView:(UIView *)theView atFrame:(CGRect)r {
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return theImage;
}

// blurAmount between 0.0 to 1.0
- (UIImage *)ok_blurredImage:(CGFloat)blurAmount {

    if (blurAmount < 0.0 || blurAmount > 1.0) {
        blurAmount = 0.5;
    }

    int boxSize = (int)(blurAmount * 40);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGImageRef img = self.CGImage;

    vImage_Buffer inBuffer, outBuffer;
    vImage_Error  error;

    void *pixelBuffer;

    CGDataProviderRef inProvider   = CGImageGetDataProvider(img);
    CFDataRef         inBitmapData = CGDataProviderCopyData(inProvider);

    inBuffer.width    = CGImageGetWidth(img);
    inBuffer.height   = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height   = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }

    if (error) {
#ifdef DEBUG
        //NSLog(@"%s error: %zd", __PRETTY_FUNCTION__, error);
#endif
        return self;
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);

    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);

    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}

#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
- (UIImage *)ok_effectImageWithEffectType:(OKImageEffectType)effectType {
    
    NSDictionary *effectDict = @{@(OKImageEffectTypeNone) : @"",
                                 @(OKImageEffectTypeInstant) : @"CIPhotoEffectInstant",
                                 @(OKImageEffectTypeNoir) : @"CIPhotoEffectNoir",
                                 @(OKImageEffectTypeTonal) : @"CIPhotoEffectTonal",
                                 @(OKImageEffectTypeTransfer) : @"CIPhotoEffectTransfer",
                                 @(OKImageEffectTypeMono) : @"CIPhotoEffectMono",
                                 @(OKImageEffectTypeFade) : @"CIPhotoEffectFade",
                                 @(OKImageEffectTypeProcess) : @"CIPhotoEffectProcess",
                                 @(OKImageEffectTypeChrome) : @"CIPhotoEffectChrome"};
    
    NSString *effectName = [effectDict objectForKey:@(effectType)];
    
    if (effectName.length > 0) {
        
        CIContext *context    = [CIContext contextWithOptions:nil];
        CIImage   *inputImage = [[CIImage alloc] initWithImage:self];
        CIFilter  *filter     = [CIFilter filterWithName:effectName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        CIImage    *result      = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage      = [context createCGImage:result fromRect:[result extent]];
        UIImage    *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }
    return self;
}

#pragma mark - 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
- (UIImage *)ok_blurredImageWithBlurType:(OKImageBlurType)blurType radius:(CGFloat)radius {
    
    NSDictionary *blurDict = @{@(OKImageBlurTypeNone) : @"",
                               @(OKImageBlurTypeGaussian) : @"CIGaussianBlur",
                               @(OKImageBlurTypeBox) : @"CIBoxBlur",
                               @(OKImageBlurTypeDisc) : @"CIDiscBlur",
                               @(OKImageBlurTypeMedian) : @"CIMedianFilter",
                               @(OKImageBlurTypeMotion) : @"CIMotionBlur"};
    
    NSString *blurName = [blurDict objectForKey:@(blurType)];
    
    if (blurName.length > 0) {

        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *inputImage = [[CIImage alloc] initWithImage:self];
        CIFilter *filter = [CIFilter filterWithName:blurName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![blurName isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return self;
    }
}

/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
- (UIImage *)ok_saturateImageWithSaturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

- (UIImage *)ok_scaleToSize:(CGSize)size {

    UIGraphicsBeginImageContext(size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;
}

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.

- (UIImage *)croppedImage:(CGRect)bounds {

    CGFloat scale = MAX(self.scale, 1.0f);

    CGRect scaledBounds = CGRectMake(bounds.origin.x * scale, bounds.origin.y * scale, bounds.size.width * scale, bounds.size.height * scale);

    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledBounds);

    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];

    CGImageRelease(imageRef);

    return croppedImage;

}

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)ok_colorAtPoint:(CGPoint)point {
    if (point.x < 0 || point.y < 0) return nil;

    CGImageRef imageRef = self.CGImage;
    NSUInteger width    = CGImageGetWidth(imageRef);
    NSUInteger height   = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height) return nil;

    unsigned char *rawData = malloc(height * width * 4);
    if (!rawData) return nil;

    CGColorSpaceRef colorSpace       = CGColorSpaceCreateDeviceRGB();
    NSUInteger      bytesPerPixel    = 4;
    NSUInteger      bytesPerRow      = bytesPerPixel * width;
    NSUInteger      bitsPerComponent = 8;
    CGContextRef    context          = CGBitmapContextCreate(rawData,
                                                             width,
                                                             height,
                                                             bitsPerComponent,
                                                             bytesPerRow,
                                                             colorSpace,
                                                             kCGImageAlphaPremultipliedLast
                                                             | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    int     byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red       = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green     = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue      = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha     = (rawData[byteIndex + 3] * 1.0) / 255.0;

    UIColor *result = nil;
    result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    free(rawData);
    return result;
}

/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)ok_colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }

    NSInteger       pointX           = trunc(point.x);
    NSInteger       pointY           = trunc(point.y);
    CGImageRef      cgImage          = self.CGImage;
    NSUInteger      width            = self.size.width;
    NSUInteger      height           = self.size.height;
    CGColorSpaceRef colorSpace       = CGColorSpaceCreateDeviceRGB();
    int             bytesPerPixel    = 4;
    int             bytesPerRow      = bytesPerPixel * 1;
    NSUInteger      bitsPerComponent = 8;
    unsigned char   pixelData[4]     = { 0, 0, 0, 0 };
    CGContextRef    context          = CGBitmapContextCreate(pixelData,
                                                             1,
                                                             1,
                                                             bitsPerComponent,
                                                             bytesPerRow,
                                                             colorSpace,
                                                             kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);

    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)ok_hasAlphaChannel {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)ok_imageWithAlpha {
    if ([self ok_hasAlphaChannel]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}


/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */

+ (UIImage *)ok_covertToGrayImageFromImage:(UIImage *)sourceImage {
    int width  = sourceImage.size.width;
    int height = sourceImage.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef    context    = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);

    if (context == NULL) {
        return nil;
    }

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage    *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);

    return grayImage;
}

+ (UIImage *)ok_mergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage {
    CGImageRef firstImageRef  = firstImage.CGImage;
    CGFloat    firstWidth     = CGImageGetWidth(firstImageRef);
    CGFloat    firstHeight    = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat    secondWidth    = CGImageGetWidth(secondImageRef);
    CGFloat    secondHeight   = CGImageGetHeight(secondImageRef);
    CGSize     mergedSize     = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)ok_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self ok_imageWithAlpha];

    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));

    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self __addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                         context:context
                       ovalWidth:cornerSize
                      ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);

    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);

    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);

    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);

    return roundedImage;
}



+ (UIImage *)ok_iconWithFont:(UIFont *)font named:(NSString *)iconNamed withTintColor:(UIColor *)tintColor clipToBounds:(BOOL)clipToBounds forSize:(CGFloat)fontSize {
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@%@%d%f", NSStringFromSelector(_cmd), font.fontName, tintColor, iconNamed, clipToBounds, fontSize];
    UIImage  *image      = [[self __cache] objectForKey:identifier];
    if (image == nil) {
        NSMutableAttributedString *ligature = [[NSMutableAttributedString alloc] initWithString:iconNamed];
        [ligature setAttributes:@{(NSString *)kCTLigatureAttributeName: @(2),
                                  (NSString *)kCTFontAttributeName: font}
                          range:NSMakeRange(0, [ligature length])];

        CGSize imageSize = [ligature size];
        imageSize.width  = ceil(imageSize.width);
        imageSize.height = ceil(imageSize.height);
        if (!CGSizeEqualToSize(CGSizeZero, imageSize)) {
            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
            [ligature drawAtPoint:CGPointZero];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            if (tintColor) {
                UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextScaleCTM(context, 1, -1);
                CGContextTranslateCTM(context, 0, -imageSize.height);
                CGContextClipToMask(context, (CGRect){.size = imageSize}, [image CGImage]);
                [tintColor setFill];
                CGContextFillRect(context, (CGRect){.size = imageSize});
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if (clipToBounds && [image respondsToSelector:@selector(imageClippedToPixelBounds)]) {
                image = [image performSelector:@selector(imageClippedToPixelBounds)];
            }
#pragma clang diagnostic pop

            [[self __cache] setObject:image forKey:identifier];
        }
    }
    return image;
}

@end
