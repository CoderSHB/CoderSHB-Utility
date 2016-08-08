//
//  UIImage+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图片滤镜类型
typedef NS_ENUM (NSInteger, OKImageEffectType) {
    OKImageEffectTypeNone = 0,  //!< 无处理
    OKImageEffectTypeInstant,   //!< 怀旧
    OKImageEffectTypeNoir,      //!< 黑白
    OKImageEffectTypeTonal,     //!< 色调
    OKImageEffectTypeTransfer,  //!< 岁月
    OKImageEffectTypeMono,      //!< 单色
    OKImageEffectTypeFade,      //!< 褪色
    OKImageEffectTypeProcess,   //!< 冲印
    OKImageEffectTypeChrome     //!< 铬黄
};

/// 图片模糊处理类型
typedef NS_ENUM (NSInteger, OKImageBlurType) {
    OKImageBlurTypeNone = 0, //!< 无处理
    OKImageBlurTypeGaussian, //!< 高斯模糊
    OKImageBlurTypeBox NS_ENUM_AVAILABLE_IOS(9_0),      //!< 均值模糊
    OKImageBlurTypeDisc NS_ENUM_AVAILABLE_IOS(9_0),     //!< 环形卷积模糊
    OKImageBlurTypeMedian NS_ENUM_AVAILABLE_IOS(9_0),   //!< 中值模糊, 用于消除图像噪点, 无需设置radius
    OKImageBlurTypeMotion NS_ENUM_AVAILABLE_IOS(9_0)    //!< 运动模糊, 用于模拟相机移动拍摄时的扫尾效果
};

@interface UIImage (OKCategory)

/**
 *  @brief 保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock 出错回调
 */
- (void)ok_savedPhotosAlbumWithCompleteBlock:(void (^)())completeBlock failBlock:(void (^)(NSError *))failBlock;

/**
 *  @brief 根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)ok_imageWithColor:(UIColor *)color;

+ (UIImage *)ok_screenshots;
+ (UIImage *)ok_screenshotsWithoutStateBar;
+ (UIImage *)ok_imageFromView:(UIView *)theView;
+ (UIImage *)ok_imageFromView:(UIView *)theView atFrame:(CGRect)r;

/**
 *  @brief blur a image
 *
 *  @param blurAmount 0.0 ~ 1.0
 *
 *  @return image with blured
 */
- (UIImage *)ok_blurredImage:(CGFloat)blurAmount;

#pragma mark - 对图片进行滤镜处理
/**
 *  @brief 对图片进行滤镜处理
 *
 *  @param effectType 滤镜类型
 *
 *  @return 处理后的图片
 */
- (UIImage *)ok_effectImageWithEffectType:(OKImageEffectType)effectType;

#pragma mark - 对图片进行模糊处理
/**
 *  @brief 对图片进行模糊处理
 *
 *  @param blurType 模糊处理类型
 *  @param radius   比率 0.0 ~ 1.0
 *
 *  @return 模糊处理后图片
 */
- (UIImage *)ok_blurredImageWithBlurType:(OKImageBlurType)blurType radius:(CGFloat)radius;

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
                                   contrast:(CGFloat)contrast;

/// 缩小图片到合适的尺寸
- (UIImage *)ok_scaleToSize:(CGSize)newSize;

/// 设置成圆形图片(避免使用cornerRadius防止卡顿)
- (UIImage *)ok_circleImage;

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)ok_colorAtPoint:(CGPoint)point;

/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)ok_colorAtPixel:(CGPoint)point;

/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)ok_hasAlphaChannel;

/**
 *  @brief 给图片加alpha
 *
 *  @return 加了alpha的image
 */
- (UIImage *)ok_imageWithAlpha;

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage *)ok_covertToGrayImageFromImage:(UIImage *)sourceImage;


/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage *)ok_mergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage;

/// 给图片加圆角和边框
- (UIImage *)ok_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

/**
 *  @brief 用icon font 生成图片
 *
 *  @param font         icon font
 *  @param iconNamed    icon name
 *  @param tintColor    icon color [default to black]
 *  @param clipToBounds 是否切角
 *  @param fontSize     fontsize
 *
 *  @return image
 */
+ (UIImage *)ok_iconWithFont:(UIFont *)font
                       named:(NSString *)iconNamed
               withTintColor:(UIColor *)tintColor
                clipToBounds:(BOOL)clipToBounds
                     forSize:(CGFloat)fontSize;

@end
