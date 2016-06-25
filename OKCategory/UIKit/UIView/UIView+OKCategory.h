//
//  UIView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (OKCategory)

@property (nonatomic, assign) CGFloat ok_x;
@property (nonatomic, assign) CGFloat ok_y;
@property (nonatomic, assign) CGFloat ok_maxX;
@property (nonatomic, assign) CGFloat ok_maxY;
@property (nonatomic, assign) CGFloat ok_centerX;
@property (nonatomic, assign) CGFloat ok_centerY;
@property (nonatomic, assign) CGFloat ok_width;
@property (nonatomic, assign) CGFloat ok_height;
@property (nonatomic, assign) CGPoint ok_origin;
@property (nonatomic, assign) CGSize  ok_size;

- (UIColor *)ok_fetchColorAtPosition:(CGPoint)position;

/**
 *  view截图
 *
 *  @return 截图
 */
- (UIImage *)ok_snapshot;

/**
 *  寻找子视图
 *
 *  @param recurse 回调
 *
 */
- (nullable UIView *)ok_findViewRecursively:(BOOL (^)(UIView *subview, BOOL *stop))recurse;

/**
 *  找到并且resign第一响应者
 */
- (BOOL)ok_findAndResignFirstResponder;

/**
 *  找到第一响应者
 */
- (nullable UIView *)ok_findFirstResponder;


- (NSArray *)ok_superviews;

- (void)ok_removeAllSubviews;
/**
 *  批量移除视图
 *
 *  @param views 需要移除的视图数组
 */
+ (void)ok_removeViews:(NSArray *)views;

/**
 *  打印视图层级
 *
 *  @return 打印视图层级字符串
 */
-(NSString*)ok_recursiveView;
/**
 *  打印约束
 *
 *  @return 打印约束字符串
 */
-(NSString*)ok_constraintsDescription;
/**
 *  打印整个autolayout树的字符串
 *
 *  @return 打印整个autolayout树的字符串
 */
-(NSString*)ok_autolayoutTraceDescription;

@end

NS_ASSUME_NONNULL_END