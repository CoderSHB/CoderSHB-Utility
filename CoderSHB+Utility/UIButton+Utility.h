//
//  UIButton+Utility.h
//  UIButton+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2014年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utility)

/** 设置按钮文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 设置按钮高亮时文字颜色 */
@property (nonatomic, strong) UIColor *highlightedTitleColor;
/** 设置按钮选中时文字颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;

/** 设置按钮title */
@property (nonatomic, copy) NSString *title;
/** 设置按钮高亮时的title */
@property (nonatomic, copy) NSString *highlightedTitle;
/** 设置按钮选中时的title */
@property (nonatomic, copy) NSString *selectedTitle;

/** 设置按钮图片 */
@property (nonatomic, copy) NSString *image;
/** 设置按钮高亮时的图片 */
@property (nonatomic, copy) NSString *highlightedImage;
/** 设置按钮选中时的图片 */
@property (nonatomic, copy) NSString *selectedImage;

/** 设置按钮背景图片 */
@property (nonatomic, copy) NSString *bgImage;
/** 设置按钮高亮时的背景图片 */
@property (nonatomic, copy) NSString *highlightedBgImage;
/** 设置按钮选中时的背景图片 */
@property (nonatomic, copy) NSString *selectedBgImage;

@end
