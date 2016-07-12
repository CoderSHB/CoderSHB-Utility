//
//  NSArray+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (OKCategory)

/**
 *  @brief 返回数组中第一个元素 如果数组为空 则返回nil
 *
 *  @return 数组中第一个元素或nil
 */
- (id)ok_firstObject;

/**
 *  @brief 返回数组中第二个元素 如果数组为空 则返回nil
 *
 *  @return 数组中第二个元素或nil
 */
- (id)ok_secondObject;

/**
 *  @brief 返回数组中第三个元素 如果数组为空 则返回nil
 *
 *  @return 数组中第三个元素或nil
 */
- (id)ok_thirdObject;

/**
 *  @brief 随取出一个元素 如果数组为空, return nil
 */
- (id)ok_randomObject;

/// 获取数组前count个元素
- (NSArray *)ok_head:(NSUInteger)count;

/// 获取数组后count个元素
- (NSArray *)ok_tail:(NSUInteger)count;

/// 比较两个数组包含的元素是否一样(不按照顺序)
- (BOOL)ok_compareIgnoreObjectOrderWithArray:(NSArray *)array;

/// 获取与otherArray交集的元素
- (NSArray *)ok_arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/// 获取与otherArray差集的元素
- (NSArray *)ok_arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end

@interface NSArray (SafeAccess)

- (NSString *)ok_stringWithIndex:(NSUInteger)index;

- (NSNumber *)ok_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)ok_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray *)ok_arrayWithIndex:(NSUInteger)index;

- (NSDictionary *)ok_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)ok_integerWithIndex:(NSUInteger)index;

- (NSUInteger)ok_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)ok_boolWithIndex:(NSUInteger)index;

- (int16_t)ok_int16WithIndex:(NSUInteger)index;

- (int32_t)ok_int32WithIndex:(NSUInteger)index;

- (int64_t)ok_int64WithIndex:(NSUInteger)index;

- (char)ok_charWithIndex:(NSUInteger)index;

- (short)ok_shortWithIndex:(NSUInteger)index;

- (float)ok_floatWithIndex:(NSUInteger)index;

- (double)ok_doubleWithIndex:(NSUInteger)index;

- (CGFloat)ok_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)ok_pointWithIndex:(NSUInteger)index;

- (CGSize)ok_sizeWithIndex:(NSUInteger)index;

- (CGRect)ok_rectWithIndex:(NSUInteger)index;

- (NSDate *)ok_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

@end

@interface NSMutableArray (SafeAccess)

- (void)ok_addPoint:(CGPoint)point;
- (void)ok_addSize:(CGSize)size;
- (void)ok_addRect:(CGRect)rect;

/// 对数组乱序
- (void)ok_shuffle;
/// 反转数组
- (void)ok_reverse;

/// 往数组头部插入一个元素
- (void)ok_pushHead:(NSObject *)anObject;
/// 往数组头部插入一个数组
- (void)ok_pushHeadWithArray:(NSArray *)array;

/// 插入一个元素到数组尾部
- (void)ok_pushTail:(NSObject *)anObject;
/// 插入一个数组到数组尾部
- (void)ok_pushTailWithArray:(NSArray *)array;

/// 删除数组的第一个元素
- (void)ok_popHead;
/// 删除数组的前N个元素
- (void)ok_popHeadWithCount:(NSUInteger)count;

/// 从数组尾部删除一个元素
- (void)ok_popTail;
/// 从数组尾部删除N个元素
- (void)ok_popTailWithCount:(NSUInteger)count;

/// 保留数组头部的前N个元素
- (void)ok_keepHeadWithCount:(NSUInteger)count;
/// 保留数组尾部的后N个元素
- (void)ok_keepTailWithCount:(NSUInteger)count;

@end
