//
//  UIView+OKBorder
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, OKBorderType) {
    OKBorderTypeTop     = 1 << 0,
    OKBorderTypeLeft    = 1 << 1,
    OKBorderTypeBottom  = 1 << 2,
    OKBorderTypeRight   = 1 << 3,
    OKBorderTypeAll     = OKBorderTypeTop | OKBorderTypeLeft | OKBorderTypeBottom | OKBorderTypeRight,
};

#pragma mark - 用CALayer给UIView添加边框

@interface UIView (OKBorder)

- (void)ok_clearBorderStyle;

/**
 *  @brief 绘制虚线
 *
 *  @param lineFrame 虚线的 frame
 *  @param length    虚线中短线的宽度
 *  @param spacing   虚线中短线之间的间距
 *  @param color     虚线中短线的颜色
 */
+ (UIView *)ok_createDashedLineWithFrame:(CGRect)lineFrame
                              lineLength:(CGFloat)length
                             lineSpacing:(CGFloat)spacing
                               lineColor:(UIColor *)color;

/**
 *  @brief 添加边框
 *
 *  @param color      边框颜色
 *  @param borderSize 边框宽度
 *  @param type       边框类型
 */
- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize borderType:(OKBorderType)type;

/**
 *  @brief 添加边框
 *
 *  @param color      边框颜色
 *  @param borderSize 边框宽度
 *  @param margin     上边框,下边框的左边距
 *  @param type       边框类型
 */
- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize margin:(CGFloat)margin borderType:(OKBorderType)type;

/**
 *  @brief 添加边框
 *
 *  @param color      边框颜色
 *  @param borderSize 边框宽度
 *  @param opacity    边框的透明度(取值范围0-1)
 *  @param type       边框类型
 */
- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize opacity:(float)opacity borderType:(OKBorderType)type;

/**
 *  @brief 添加边框
 *
 *  @param color      边框颜色
 *  @param borderSize 边框宽度
 *  @param opacity    边框的透明度(取值范围0-1)
 *  @param margin     上边框,下边框的左边距
 *  @param type       边框类型
 */
- (void)ok_addBorderWithColor:(UIColor *)color borderSize:(CGFloat)borderSize opacity:(float)opacity margin:(CGFloat)margin borderType:(OKBorderType)type;


///**
// *  添加上边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// */
//- (void)ok_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;
//
///**
// *  添加下边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// */
//- (void)ok_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;
//
///**
// *  添加左边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// */
//- (void)ok_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;
//
///**
// *  添加右边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// */
//- (void)ok_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;
//
///**
// *  添加上边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// *  @param opacity     边框的透明度(取值范围0-1)
// */
//- (void)ok_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity;
//
///**
// *  添加下边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// *  @param opacity     边框的透明度(取值范围0-1)
// */
//- (void)ok_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity;
//
///**
// *  添加左边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// *  @param opacity     边框的透明度(取值范围0-1)
// */
//- (void)ok_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity;
//
///**
// *  添加右边框
// *
// *  @param color       边框颜色
// *  @param borderWidth 边框宽度
// *  @param opacity     边框的透明度(取值范围0-1)
// */
//- (void)ok_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andOpacity:(float)opacity;

@end

NS_ASSUME_NONNULL_END
