//
//  NSArray+Addition.m
//
//  Created by SHB on 15/12/22.
//  Copyright © 2015年 CoderSHB. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

- (id)ok_objectAtIndex:(NSUInteger)index {
    
    NSAssert(index < self.count, @"index 不能 >= 数组元素个数");
    
    if (index >= self.count) {
        return nil;
    }
    id value = [self objectAtIndex:index];
    
    NSAssert(value != [NSNull null], @"元素为空");
    
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (NSArray *)ok_subarrayWithRange:(NSRange)range {
    
    NSAssert(range.location <= self.count, @"range location 越界");
    
    NSAssert(range.length >= 0, @"range length 不合法");
    
    NSAssert((range.location + range.length) <= self.count, @"range 越界");
    
    if (range.location > self.count || range.length == 0) {
        return @[];
    } else if ((range.location + range.length) > self.count) {
        return @[];
    }
    
    return [self subarrayWithRange:range];
    
}

@end

@implementation NSMutableArray (Addition)

- (void)ok_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    NSAssert(index <= self.count, @"index 越界");
    
    NSAssert(anObject != nil, @"anObject 不能为nil");
    
    if (index > self.count || anObject == nil) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

@end