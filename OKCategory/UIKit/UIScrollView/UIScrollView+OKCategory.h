//
//  UIScrollView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (OKCategory)

@property(nonatomic, assign) CGFloat contentWidth;
@property(nonatomic, assign) CGFloat contentHeight;
@property(nonatomic, assign) CGFloat contentOffsetX;
@property(nonatomic, assign) CGFloat contentOffsetY;

#pragma mark - content偏移

- (CGPoint)ok_topContentOffset;
- (CGPoint)ok_bottomContentOffset;
- (CGPoint)ok_leftContentOffset;
- (CGPoint)ok_rightContentOffset;

#pragma mark - 是否已滚动到(上下左右)边

- (BOOL)ok_isScrolledToTop;
- (BOOL)ok_isScrolledToBottom;
- (BOOL)ok_isScrolledToLeft;
- (BOOL)ok_isScrolledToRight;

#pragma mark - 滚动到(上下左右)边

- (void)ok_scrollToTopAnimated:(BOOL)animated;
- (void)ok_scrollToBottomAnimated:(BOOL)animated;
- (void)ok_scrollToLeftAnimated:(BOOL)animated;
- (void)ok_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)ok_verticalPageIndex;
- (NSUInteger)ok_horizontalPageIndex;

- (void)ok_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)ok_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

- (CGFloat)ok_pagesY;
- (CGFloat)ok_pagesX;
- (CGFloat)ok_currentPageY;
- (CGFloat)ok_currentPageX;

- (void)ok_setPageY:(CGFloat)page;
- (void)ok_setPageX:(CGFloat)page;
- (void)ok_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)ok_setPageX:(CGFloat)page animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END