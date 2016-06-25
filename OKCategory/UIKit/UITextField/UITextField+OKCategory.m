//
//  UITextField+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UITextField+OKCategory.h"
#import <objc/runtime.h>

@implementation UITextField (OKCategory)

- (BOOL)isMenuItemDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMenuItemDisabled:(BOOL)menuItemDisabled {
    objc_setAssociatedObject(self, @selector(isMenuItemDisabled), @(menuItemDisabled), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.isMenuItemDisabled || self.isSecureTextEntry) {
        UIMenuController *menuCtrl = [UIMenuController sharedMenuController];
        if (menuCtrl) {
            menuCtrl.menuVisible = NO;
        }
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)ok_setPlaceholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)ok_selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;

    UITextRange    *selectedRange  = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd   = selectedRange.end;

    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length   = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

/**
 *  @brief  选中所有文字
 */
- (void)ok_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)ok_setSelectedRange:(NSRange)range {
    UITextPosition *beginning      = self.beginningOfDocument;
    UITextPosition *startPosition  = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition    = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange    *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end

typedef BOOL (^UITextFieldReturnBlock) (UITextField *textField);
typedef void (^UITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^UITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (Blocks)
static const void *UITextFieldDelegateKey = &UITextFieldDelegateKey;
static const void *UITextFieldShouldBeginEditingKey            = &UITextFieldShouldBeginEditingKey;
static const void *UITextFieldShouldEndEditingKey              = &UITextFieldShouldEndEditingKey;
static const void *UITextFieldDidBeginEditingKey               = &UITextFieldDidBeginEditingKey;
static const void *UITextFieldDidEndEditingKey                 = &UITextFieldDidEndEditingKey;
static const void *UITextFieldShouldChangeCharactersInRangeKey = &UITextFieldShouldChangeCharactersInRangeKey;
static const void *UITextFieldShouldClearKey                   = &UITextFieldShouldClearKey;
static const void *UITextFieldShouldReturnKey                  = &UITextFieldShouldReturnKey;

#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UITextFieldReturnBlock block = textField.shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}

+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    UITextFieldReturnBlock block = textField.shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}

+ (void)textFieldDidBeginEditing:(UITextField *)textField {
    UITextFieldVoidBlock block = textField.didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}

+ (void)textFieldDidEndEditing:(UITextField *)textField {
    UITextFieldVoidBlock block = textField.didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}

+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextFieldCharacterChangeBlock block = textField.shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField, range, string);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

+ (BOOL)textFieldShouldClear:(UITextField *)textField {
    UITextFieldReturnBlock block = textField.shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}

+ (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextFieldReturnBlock block = textField.shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))shouldBegindEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldBeginEditingKey);
}

- (void)setShouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldEndEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldEndEditingKey);
}

- (void)setShouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextField *))didBeginEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldDidBeginEditingKey);
}

- (void)setDidBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextField *))didEndEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldDidEndEditingKey);
}

- (void)setDidEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey);
}

- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldReturnBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldReturnKey);
}

- (void)setShouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldClearBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldClearKey);
}

- (void)setShouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark control method
/*
   Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)setDelegateIfNoDelegateSet {
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, UITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}

@end
