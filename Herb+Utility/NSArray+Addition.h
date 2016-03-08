//
//  NSArray+Addition.h
//
//  Created by SHB on 15/12/22.
//  Copyright © 2015年 CoderSHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Addition)

/*!
 *  安全访问数组的第index元素的方法
 *
 *  @abstract 检查是否越界 和 元素是否为NSNull 如果是 return nil
 *
 */
- (id)ok_objectAtIndex:(NSUInteger)index;

/*!
 *  安全获取子数组方法
 *
 *  @abstract 检查range是否越界 如果是 return nil
 */
- (NSArray *)ok_subarrayWithRange:(NSRange)range;

@end

@interface NSMutableArray (Addition)

/*!
 *  安全插入方法
 *
 *  @abstract 检查是否越界 检查anObject是否为空 如果是 return
 */
- (void)ok_insertObject:(id)anObject atIndex:(NSUInteger)index;

@end