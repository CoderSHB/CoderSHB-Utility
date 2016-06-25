//
//  UIScrollView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIScrollView+OKCategory.h"

@implementation UIScrollView (OKCategory)

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}

#pragma mark -

- (CGPoint)ok_topContentOffset {
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)ok_bottomContentOffset {
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)ok_leftContentOffset {
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)ok_rightContentOffset {
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}

#pragma mark -

- (BOOL)ok_isScrolledToTop {
    return self.contentOffset.y <= [self ok_topContentOffset].y;
}

- (BOOL)ok_isScrolledToBottom {
    return self.contentOffset.y >= [self ok_bottomContentOffset].y;
}

- (BOOL)ok_isScrolledToLeft {
    return self.contentOffset.x <= [self ok_leftContentOffset].x;
}

- (BOOL)ok_isScrolledToRight {
    return self.contentOffset.x >= [self ok_rightContentOffset].x;
}

#pragma mark -

- (void)ok_scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:[self ok_topContentOffset] animated:animated];
}

- (void)ok_scrollToBottomAnimated:(BOOL)animated {
    [self setContentOffset:[self ok_bottomContentOffset] animated:animated];
}

- (void)ok_scrollToLeftAnimated:(BOOL)animated {
    [self setContentOffset:[self ok_leftContentOffset] animated:animated];
}

- (void)ok_scrollToRightAnimated:(BOOL)animated {
    [self setContentOffset:[self ok_rightContentOffset] animated:animated];
}

#pragma mark -

- (NSUInteger)ok_verticalPageIndex {
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)ok_horizontalPageIndex {
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

- (void)ok_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)ok_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

#pragma mark - Pages

- (CGFloat)ok_pagesY {
    CGFloat pageHeight    = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight/pageHeight;
}

- (CGFloat)ok_pagesX {
    CGFloat pageWidth    = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth/pageWidth;
}

- (CGFloat)ok_currentPageY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY    = self.contentOffset.y;
    return offsetY / pageHeight;
}

- (CGFloat)ok_currentPageX {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX   = self.contentOffset.x;
    return offsetX / pageWidth;
}

- (void)ok_setPageY:(CGFloat)page {
    [self ok_setPageY:page animated:NO];
}

- (void)ok_setPageX:(CGFloat)page {
    [self ok_setPageX:page animated:NO];
}

- (void)ok_setPageY:(CGFloat)page animated:(BOOL)animated {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY    = page * pageHeight;
    CGFloat offsetX    = self.contentOffset.x;
    CGPoint offset     = CGPointMake(offsetX, offsetY);
    [self setContentOffset:offset];
}

- (void)ok_setPageX:(CGFloat)page animated:(BOOL)animated {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetY   = self.contentOffset.y;
    CGFloat offsetX   = page * pageWidth;
    CGPoint offset    = CGPointMake(offsetX, offsetY);
    [self setContentOffset:offset animated:animated];
}

@end
