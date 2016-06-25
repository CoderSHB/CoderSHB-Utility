//
//  UIWebView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView (OKCategory)

/**
 *  @brief  获取网页meta信息
 *
 *  @return meta信息
 */
-(nullable NSArray *)ok_fetchMetaData;

/**
 *  @brief  清空cookie
 */
- (void)ok_clearCookies;

/**
 *  @brief 隐藏拖拽后的上下阴影
 */
- (void)ok_hiddenShadowView;

/**
 *  @brief 是否显示水平滑动指示器
 */
- (void)ok_showHorizontalScrollIndicator:(BOOL)show;

/**
 *  @brief 是否显示垂直滑动指示器
 */
- (void)ok_showVerticalScrollIndicator:(BOOL)show;

/**
 *  @brief 网页透明
 */
- (void)ok_makeTransparent;

/**
 *  @brief 网页透明移除+阴影
 */
- (void)ok_makeTransparentAndRemoveShadow;

@end

NS_ASSUME_NONNULL_END