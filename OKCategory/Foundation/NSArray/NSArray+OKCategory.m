//
//  NSArray+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSArray+OKCategory.h"
#import "NSObject+OKRuntime.h"

@implementation NSArray (OKCategory)

- (id)ok_firstObject {
    return [self count] > 0 ? [self objectAtIndex:0] : nil;
}

- (id)ok_secondObject {
    return [self count] > 1 ? [self objectAtIndex:1] : nil;
}

- (id)ok_thirdObject {
    return [self count] > 2 ? [self objectAtIndex:2] : nil;
}

- (id)ok_randomObject {
    if (self.count > 0) {
        return [self objectAtIndex:arc4random_uniform((uint32_t)self.count)];
    }
    return nil;
}

- (NSArray *)ok_head:(NSUInteger)count {
    NSRange range;
    if (self.count < count) {
        range = NSMakeRange(0, self.count);
    } else {
        range = NSMakeRange(0, count);
    }
    return [self subarrayWithRange:range];

}

- (NSArray *)ok_tail:(NSUInteger)count {
    NSRange range;
    if (self.count < count) {
        range = NSMakeRange(0, self.count);
    } else {
        range = NSMakeRange(self.count - count, count);
    }
    return [self subarrayWithRange:range];
}

- (BOOL)ok_compareIgnoreObjectOrderWithArray:(NSArray *)array {

    NSSet *set1 = [NSSet setWithArray:self];

    NSSet *set2 = [NSSet setWithArray:array];

    return [set1 isEqualToSet:set2];
}

- (NSArray *)ok_arrayForIntersectionWithOtherArray:(NSArray *)otherArray {

    if (self.count == 0) return nil;
    if (!otherArray) return nil;

    NSMutableArray *intersectionArray = [NSMutableArray array];
    
    for (id obj in self) {

        if (![otherArray containsObject:obj]) continue;
        [intersectionArray addObject:obj];
    }
    return intersectionArray;
}

- (NSArray *)ok_arrayForMinusWithOtherArray:(NSArray *)otherArray {

    if (self.count == 0) return nil;
    if (!otherArray) return self;

    NSMutableArray *minusArray = [NSMutableArray arrayWithArray:self];

    for (id obj in otherArray) {

        if (![self containsObject:obj]) continue;
        [minusArray removeObject:obj];
    }
    return minusArray;
}

@end

@implementation NSArray (SafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ok_swizzleMethod:@selector(objectAtIndex:)
                    withMethod:@selector(ok_objectAtIndex:)];
        [self ok_swizzleMethod:@selector(subarrayWithRange:)
                    withMethod:@selector(ok_subarrayWithRange:)];
        
        
    });
}

- (id)ok_objectAtIndex:(NSUInteger)index {

    if (index < self.count) {
        return [self ok_objectAtIndex:index];
    }
    return nil;
}

- (NSArray *)ok_subarrayWithRange:(NSRange)range {

    if (range.location > self.count || range.length == 0) {
        return @[];
    } else if ((range.location + range.length) > self.count) {
        return @[];
    }

    return [self ok_subarrayWithRange:range];
}

- (NSString *)ok_stringWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }

    return nil;
}

- (NSNumber *)ok_numberWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSDecimalNumber *)ok_decimalNumberWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray *)ok_arrayWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)ok_dictionaryWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)ok_integerWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)ok_unsignedIntegerWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)ok_boolWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)ok_int16WithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)ok_int32WithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)ok_int64WithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)ok_charWithIndex:(NSUInteger)index {

    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)ok_shortWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)ok_floatWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)ok_doubleWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)ok_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    
    id value = [self objectAtIndex:index];

    if (value == nil || value == [NSNull null]) {
        return nil;
    }

    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

- (CGFloat)ok_CGFloatWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    CGFloat f = [value doubleValue];

    return f;
}

- (CGPoint)ok_pointWithIndex:(NSUInteger)index {
    id value = [self objectAtIndex:index];

    CGPoint point = CGPointFromString(value);

    return point;
}

- (CGSize)ok_sizeWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    CGSize size = CGSizeFromString(value);

    return size;
}

- (CGRect)ok_rectWithIndex:(NSUInteger)index {
    
    id value = [self objectAtIndex:index];

    CGRect rect = CGRectFromString(value);

    return rect;
}

@end

@implementation NSMutableArray (SafeAccess)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSArrayM");
        
        [class ok_swizzleMethod:@selector(addObject:)
                     withMethod:@selector(ok_addObject:)];
        
        [class ok_swizzleMethod:@selector(insertObject:atIndex:)
                     withMethod:@selector(ok_insertObject:atIndex:)];
        
        [class ok_swizzleMethod:@selector(removeObjectAtIndex:)
                     withMethod:@selector(ok_removeObjectAtIndex:)];
        
        [class ok_swizzleMethod:@selector(replaceObjectAtIndex:withObject:)
                     withMethod:@selector(ok_replaceObjectAtIndex:withObject:)];
    });
}

- (void)ok_addObject:(id)anObject {
    if (anObject) {
        [self ok_addObject:anObject];
    } else {
        NSLog(@"OKCategory >>>> object is nil");
    }
}

- (void)ok_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= [self count]) {
        [self ok_insertObject:anObject atIndex:index];
    } else {
        NSLog(@"OKCategory >>>> index is beyound bounds or object is nil");
    }
}

- (void)ok_removeObjectAtIndex:(NSUInteger)index {
    if (index < [self count]) {
        [self ok_removeObjectAtIndex:index];
    } else {
        NSLog(@"OKCategory >>>> index is beyound bounds");
    }
}

- (void)ok_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < [self count] && anObject) {
        [self ok_replaceObjectAtIndex:index withObject:anObject];
    } else {
        NSLog(@"OKCategory >>>> index is beyound bounds or object is nil");
    }
}

- (void)ok_addPoint:(CGPoint)point {
    [self addObject:NSStringFromCGPoint(point)];
}

- (void)ok_addSize:(CGSize)size {
    [self addObject:NSStringFromCGSize(size)];
}

- (void)ok_addRect:(CGRect)rect {
    [self addObject:NSStringFromCGRect(rect)];
}

- (void)ok_shuffle {
    for (NSInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform((u_int32_t)i + 1)
                  withObjectAtIndex:i];
    }
}

- (void)ok_reverse {
    NSUInteger mid = self.count / 2;
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(self.count - (i + 1))];
    }
}

- (void)ok_pushHead:(NSObject *)anObject {
    if (anObject) {
        [self insertObject:anObject atIndex:0];
    }
}

- (void)ok_pushHeadWithArray:(NSArray *)array {
    if (array.count > 0) {
        for (NSInteger i = array.count - 1; i >= 0; --i) {
            [self insertObject:array[i] atIndex:0];
        }
    }
}

- (void)ok_pushTail:(NSObject *)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)ok_pushTailWithArray:(NSArray *)array {
    if (array.count > 0) {
        [self addObjectsFromArray:array];
    }
}

- (void)ok_popHead {
    if (self.count > 0) {
        [self removeObjectAtIndex:0];
    }
}

- (void)ok_popHeadWithCount:(NSUInteger)count {
    if (self.count > 0) {
        if (count >= self.count) {
            [self removeAllObjects];
        } else {
            NSRange range;
            range.location = 0;
            range.length   = count;
            [self removeObjectsInRange:range];
        }
    }
}

- (void)ok_popTail {
    if (self.count > 0) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (void)ok_popTailWithCount:(NSUInteger)count {
    if (self.count > 0) {
        if (count >= self.count) {
            [self removeAllObjects];
        } else {
            NSRange range;
            range.location = self.count - count;
            range.length   = count;
            [self removeObjectsInRange:range];
        }
    }
}

- (void)ok_keepHeadWithCount:(NSUInteger)count {
    if (self.count > count) {
        NSRange range;
        range.location = count;
        range.length   = self.count - count;
        [self removeObjectsInRange:range];
    }
}

- (void)ok_keepTailWithCount:(NSUInteger)count {
    if (self.count > count) {
        NSRange range;
        range.location = 0;
        range.length   = self.count - count;
        [self removeObjectsInRange:range];
    }
}

@end
