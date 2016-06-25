//
//  UITextView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (OKCategory)

/**
 *  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)ok_selectedRange;

/// 选中所有文字
- (void)ok_selectAllText;

/**
 *  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)ok_setSelectedRange:(NSRange)range;

/// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)getInputLengthWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END