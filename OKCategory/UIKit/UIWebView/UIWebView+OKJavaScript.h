//
//  UIWebView+OKJavaScript
//
//  Copyright (c) 2014年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView (OKJavaScript)

#pragma mark -
#pragma mark 获取网页中的数据

/// 获取某个标签的结点个数
- (NSUInteger)ok_nodeCountOfTag:(NSString *)tag;

/// 获取当前页面URL
- (NSString *)ok_fetchCurrentURL;

/// 获取标题
- (NSString *)ok_fetchTitle;

/// 获取图片
- (NSArray *)ok_fetchImages;

/// 获取当前页面所有链接
- (NSArray *)ok_fetchAllURL;

/// 改变所有图像的宽度
- (void)ok_setImageWidth:(CGFloat)width;

/// 改变所有图像的高度
- (void)ok_setImageHeight:(CGFloat)height;

/// 改变指定标签的字体大小
- (void)ok_setFontSize:(CGFloat)fontSize withTag:(NSString *)tagName;

@end

NS_ASSUME_NONNULL_END