//
//  NSDictionary+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSDictionary+OKCategory.h"
#import "NSObject+OKRuntime.h"

@implementation NSDictionary (OKCategory)

- (NSString *)ok_XMLString {

    NSString *xmlStr = @"<xml>";

    for (NSString *key in self.allKeys) {

        NSString *value = [self objectForKey:key];

        xmlStr = [xmlStr stringByAppendingString:[NSString stringWithFormat:@"<%@>%@</%@>", key, value, key]];
    }

    xmlStr = [xmlStr stringByAppendingString:@"</xml>"];

    return xmlStr;
}

- (NSString *)ok_JSONString {

    NSError *error;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSDictionary *)ok_dictionaryWithJSONString:(NSString *)json {

    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];

    NSError      *error;
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:&error];

    if (error) {
#ifdef DEBUG
        NSLog(@"fail to get dictionary from JSON: %@, error: %@", self, error);
#endif
        return nil;
    }
    return info;
}

- (BOOL)ok_containsObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

- (NSDictionary *)ok_objectsForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            dic[key] = value;
        }
    }
    return dic;
}

- (NSDictionary *)ok_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *result = [self mutableCopy];
    [result addEntriesFromDictionary:dictionary];
    return result;
}

- (NSDictionary *)ok_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys {
    NSMutableDictionary *result = [self mutableCopy];
    [result removeObjectsForKeys:keys.allObjects];
    return result;
}

@end

#pragma mark - NSDictionary OKURL

@implementation NSDictionary (OKURL)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

+ (NSDictionary *)ok_dictionaryWithURLQuery:(NSString *)query {
    NSMutableDictionary *dict       = [NSMutableDictionary dictionary];
    NSArray             *parameters = [query componentsSeparatedByString:@"&"];
    for (NSString *parameter in parameters) {
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if ([contents count] == 2) {
            NSString *key   = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)ok_URLQueryString {
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                      (CFStringRef)[[self objectForKey:key] description],
                                                                      NULL,
                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}

#pragma clang diagnostic pop

@end

#pragma mark - NSDictionary OKSafeAccess

@implementation NSDictionary (OKSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ok_swizzleMethod:@selector(initWithObjects:forKeys:count:)
                        withMethod:@selector(ok_initWithObjects:forKeys:count:)];
        [self ok_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:)
                         withMethod:@selector(ok_dictionaryWithObjects:forKeys:count:)];
    });
}

- (instancetype)ok_initWithObjects:(const id [])objects
                           forKeys:(const id<NSCopying> [])keys
                             count:(NSUInteger)cnt {
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self ok_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

+ (instancetype)ok_dictionaryWithObjects:(const id [])objects
                                 forKeys:(const id<NSCopying> [])keys
                                   count:(NSUInteger)cnt {
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self ok_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (BOOL)ok_hasKey:(NSString *)key {
    return [self objectForKey:key] != nil;
}

- (NSString *)ok_stringForKey:(id)key {

    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
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

- (NSNumber *)ok_numberForKey:(id)key {
    id value = [self objectForKey:key];
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

- (NSDecimalNumber *)ok_decimalNumberForKey:(id)key {
    id value = [self objectForKey:key];

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

- (NSArray *)ok_arrayForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)ok_dictionaryForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)ok_integerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)ok_unsignedIntegerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)ok_boolForKey:(id)key {
    id value = [self objectForKey:key];

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

- (int16_t)ok_int16ForKey:(id)key {
    id value = [self objectForKey:key];

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

- (int32_t)ok_int32ForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)ok_int64ForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)ok_charForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)ok_shortForKey:(id)key {
    id value = [self objectForKey:key];

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

- (float)ok_floatForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)ok_doubleForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (long long)ok_longLongForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)ok_unsignedLongLongForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (NSDate *)ok_dateForKey:(id)key dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return nil;
    }

    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

- (CGFloat)ok_CGFloatForKey:(id)key {
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)ok_pointForKey:(id)key {
    CGPoint point = CGPointFromString(self[key]);
    return point;
}

- (CGSize)ok_sizeForKey:(id)key {
    CGSize size = CGSizeFromString(self[key]);
    return size;
}

- (CGRect)ok_rectForKey:(id)key {
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}

@end

#pragma mark - NSMutableDictionary OKSafeAccess

@implementation NSMutableDictionary (OKSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class ok_swizzleMethod:@selector(setObject:forKey:)
                     withMethod:@selector(ok_setObject:forKey:)];
        [class ok_swizzleMethod:@selector(setObject:forKeyedSubscript:)
                     withMethod:@selector(ok_setObject:forKeyedSubscript:)];
    });
}

- (void)ok_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    if (!anObject) {
        anObject = [NSNull null];
    }
    [self ok_setObject:anObject forKey:aKey];
}

- (void)ok_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    if (!obj) {
        obj = [NSNull null];
    }
    [self ok_setObject:obj forKeyedSubscript:key];
}

- (void)setPoint:(CGPoint)point forKey:(NSString *)key {
    self[key] = NSStringFromCGPoint(point);
}

- (void)setSize:(CGSize)size forKey:(NSString *)key {
    self[key] = NSStringFromCGSize(size);
}

- (void)setRect:(CGRect)rect forKey:(NSString *)key {
    self[key] = NSStringFromCGRect(rect);
}

@end
