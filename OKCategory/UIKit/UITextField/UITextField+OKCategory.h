//
//  UITextField+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (OKCategory)

/// 是否禁用menuBar
@property (nonatomic, assign, getter = isMenuItemDisabled) BOOL menuItemDisabled;

/**
 *  设置UITextField的placeholder的颜色
 */
- (void)ok_setPlaceholderColor:(UIColor *)color;

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)ok_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)ok_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)ok_setSelectedRange:(NSRange)range;

@end

@interface UITextField (OKBlocks)

@property (nonatomic, copy) BOOL (^shouldBegindEditingBlock)(UITextField *textField);
@property (nonatomic, copy) BOOL (^shouldEndEditingBlock)(UITextField *textField);
@property (nonatomic, copy) void (^didBeginEditingBlock)(UITextField *textField);
@property (nonatomic, copy) void (^didEndEditingBlock)(UITextField *textField);
@property (nonatomic, copy) BOOL (^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (nonatomic, copy) BOOL (^shouldReturnBlock)(UITextField *textField);
@property (nonatomic, copy) BOOL (^shouldClearBlock)(UITextField *textField);

- (void)ok_setShouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)ok_setShouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)ok_setDidBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)ok_setDidEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)ok_setShouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)ok_setShouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)ok_setShouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;

@end

NS_ASSUME_NONNULL_END