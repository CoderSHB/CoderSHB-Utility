//
//  Foundation+Utility.m
//  Foundation+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Utility)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];

    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}
@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}
@end
