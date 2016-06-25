//
//  NSObject+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSObject+OKCategory.h"
#import  <objc/runtime.h>
#import <dispatch/dispatch.h>

static inline dispatch_time_t __dispatchTimeDelay(NSTimeInterval time) {
    int64_t delta = (int64_t)(NSEC_PER_SEC * time);
    return dispatch_time(DISPATCH_TIME_NOW, delta);
}

@implementation NSObject (OKPrivateCategory)

+ (NSString *)__decodeType:(const char *)cString {
    if (!strcmp(cString, @encode(char)))
        return @"char";
    if (!strcmp(cString, @encode(int)))
        return @"int";
    if (!strcmp(cString, @encode(short)))
        return @"short";
    if (!strcmp(cString, @encode(long)))
        return @"long";
    if (!strcmp(cString, @encode(long long)))
        return @"long long";
    if (!strcmp(cString, @encode(unsigned char)))
        return @"unsigned char";
    if (!strcmp(cString, @encode(unsigned int)))
        return @"unsigned int";
    if (!strcmp(cString, @encode(unsigned short)))
        return @"unsigned short";
    if (!strcmp(cString, @encode(unsigned long)))
        return @"unsigned long";
    if (!strcmp(cString, @encode(unsigned long long)))
        return @"unsigned long long";
    if (!strcmp(cString, @encode(float)))
        return @"float";
    if (!strcmp(cString, @encode(double)))
        return @"double";
    if (!strcmp(cString, @encode(bool)))
        return @"bool";
    if (!strcmp(cString, @encode(_Bool)))
        return @"_Bool";
    if (!strcmp(cString, @encode(void)))
        return @"void";
    if (!strcmp(cString, @encode(char *)))
        return @"char *";
    if (!strcmp(cString, @encode(id)))
        return @"id";
    if (!strcmp(cString, @encode(Class)))
        return @"class";
    if (!strcmp(cString, @encode(SEL)))
        return @"SEL";
    if (!strcmp(cString, @encode(BOOL)))
        return @"BOOL";

    //    NSDictionary *typeDic = @{@"c":@"char",
    //                              @"i":@"int",
    //                              @"s":@"short",
    //                              @"l":@"long",
    //                              @"q":@"long long",
    //                              @"C":@"unsigned char",
    //                              @"I":@"unsigned int",
    //                              @"S":@"unsigned short",
    //                              @"L":@"unsigned long",
    //                              @"Q":@"unsigned long long",
    //                              @"f":@"float",
    //                              @"d":@"double",
    //                              @"B":@"BOOL",
    //                              @"v":@"void",
    //                              @"*":@"char *",
    //                              @"@":@"id",
    //                              @"#":@"Class",
    //                              @":":@"SEL",
    //                              };

    //@TODO: do handle bitmasks
    NSString *result = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    //    if ([typeDic objectForKey:result]) {
    //        return [typeDic objectForKey:result];
    //    }
    if ([[result substringToIndex:1] isEqualToString:@"@"] && [result rangeOfString:@"?"].location == NSNotFound) {
        result = [[result substringWithRange:NSMakeRange(2, result.length - 3)] stringByAppendingString:@"*"];
    } else {
        if ([[result substringToIndex:1] isEqualToString:@"^"]) {
            result = [NSString stringWithFormat:@"%@ *",
                      [NSString __decodeType:[[result substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    }
    return result;
}

@end

@implementation NSObject (OKCategory)

+ (Class)ok_rootClass {

    Class rootClass    = nil;
    Class currentClass = [self class];

    while ((currentClass = class_getSuperclass(currentClass)))
        rootClass = currentClass;

    return rootClass;
}

- (NSString *)ok_superClassName {
    return NSStringFromClass([self superclass]);
}

+ (NSString *)ok_superClassName {
    return NSStringFromClass([self superclass]);
}

- (NSString *)ok_className {
    return NSStringFromClass([self class]);
}

+ (NSString *)ok_className {
    return NSStringFromClass([self class]);
}

+ (NSArray *)ok_instanceVariableList {
    unsigned int   outCount;
    Ivar           *ivars  = class_copyIvarList([self class], &outCount);
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        NSString *type            = [[self class] __decodeType:ivar_getTypeEncoding(ivars[i])];
        NSString *name            = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *ivarDescription = [NSString stringWithFormat:@"%@ %@", type, name];
        [result addObject:ivarDescription];
    }
    free(ivars);
    return result.count ? [result copy] : nil;
}

- (NSArray *)ok_propertyList {
    return [[self class] ok_propertyList];
}

+ (NSArray *)ok_propertyList {
    unsigned int    propertyCount  = 0;
    objc_property_t *properties    = class_copyPropertyList(self, &propertyCount);
    NSMutableArray  *propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char      *name    = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

+ (NSArray *)ok_propertiesWithCodeFormat {
    NSMutableArray *array = [NSMutableArray array];

    NSArray *properties = [self ok_propertyList];

    for (NSDictionary *item in properties) {
        NSMutableString *format = ({

            NSMutableString *formatString = [NSMutableString stringWithFormat:@"@property "];
            //attribute
            NSArray *attribute = [item objectForKey:@"attribute"];
            attribute = [attribute sortedArrayUsingComparator:^NSComparisonResult (id obj1, id obj2) {
                             return [obj1 compare:obj2 options:NSNumericSearch];
                         }];
            if (attribute && attribute.count > 0) {
                NSString *attributeStr = [NSString stringWithFormat:@"(%@)", [attribute componentsJoinedByString:@", "]];

                [formatString appendString:attributeStr];
            }

            //type
            NSString *type = [item objectForKey:@"type"];
            if (type) {
                [formatString appendString:@" "];
                [formatString appendString:type];
            }

            //name
            NSString *name = [item objectForKey:@"name"];
            if (name) {
                [formatString appendString:@" "];
                [formatString appendString:name];
                [formatString appendString:@";"];
            }

            formatString;
        });

        [array addObject:format];
    }

    return array;
}

- (NSDictionary *)ok_propertiesDictionary {
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int        outCount;
    objc_property_t     *props = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop      = props[i];
        NSString        *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id              propValue = [self valueForKey:propName];
        [dict setObject:propValue ? : [NSNull null] forKey:propName];
    }
    free(props);
    return dict;
}

///类的指针列表
+ (NSArray *)ok_registedClassList {
    NSMutableArray *result = [NSMutableArray array];

    unsigned int count;
    Class        *classes = objc_copyClassList(&count);
    for (int i = 0; i < count; i++) {
        [result addObject:NSStringFromClass(classes[i])];
    }
    free(classes);
    [result sortedArrayUsingSelector:@selector(compare:)];

    return result;
}

- (NSArray *)ok_methodList {
    return [[self class] ok_methodList];
}

+ (NSArray *)ok_methodList {
    u_int          count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method         *methods    = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL      name     = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    free(methods);

    return methodList;
}

- (NSArray *)ok_methodListInfo {
    u_int          count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method         *methods    = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];

        Method method = methods[i];
        //        IMP imp = method_getImplementation(method);
        SEL name = method_getName(method);
        // 返回方法的参数的个数
        int argumentsCount = method_getNumberOfArguments(method);
        //获取描述方法参数和返回值类型的字符串
        const char *encoding = method_getTypeEncoding(method);
        //取方法的返回值类型的字符串
        const char *returnType = method_copyReturnType(method);

        NSMutableArray *arguments = [NSMutableArray array];
        for (int index = 0; index < argumentsCount; index++) {
            // 获取方法的指定位置参数的类型字符串
            char *arg = method_copyArgumentType(method, index);
            //            NSString *argString = [NSString stringWithCString:arg encoding:NSUTF8StringEncoding];
            [arguments addObject:[[self class] __decodeType:arg]];
        }

        NSString *returnTypeString = [[self class] __decodeType:returnType];
        NSString *encodeString     = [[self class] __decodeType:encoding];
        NSString *nameString       = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];

        [info setObject:arguments forKey:@"arguments"];
        [info setObject:[NSString stringWithFormat:@"%d", argumentsCount] forKey:@"argumentsCount"];
        [info setObject:returnTypeString forKey:@"returnType"];
        [info setObject:encodeString forKey:@"encode"];
        [info setObject:nameString forKey:@"name"];
        //        [info setObject:imp_f forKey:@"imp"];
        [methodList addObject:info];
    }
    free(methods);
    return methodList;
}

- (NSDictionary *)ok_protocolList {
    return [[self class] ok_protocolList];
}

+ (NSDictionary *)ok_protocolList {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    unsigned int                  count;
    Protocol *__unsafe_unretained *protocols = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i++) {
        Protocol *protocol = protocols[i];

        NSString *protocolName = [NSString stringWithCString:protocol_getName(protocol) encoding:NSUTF8StringEncoding];

        NSMutableArray *superProtocolArray = ({

            NSMutableArray *array = [NSMutableArray array];

            unsigned int superProtocolCount;
            Protocol *__unsafe_unretained *superProtocols = protocol_copyProtocolList(protocol, &superProtocolCount);
            for (int ii = 0; ii < superProtocolCount; ii++) {
                Protocol *superProtocol = superProtocols[ii];

                NSString *superProtocolName = [NSString stringWithCString:protocol_getName(superProtocol) encoding:NSUTF8StringEncoding];

                [array addObject:superProtocolName];
            }
            free(superProtocols);

            array;
        });

        [dictionary setObject:superProtocolArray forKey:protocolName];
    }
    free(protocols);

    return dictionary;
}

- (void)ok_logRunTimeWithBlock:(void (^)(void))block prefix:(NSString *)prefix {

    double a = CFAbsoluteTimeGetCurrent();
    block();
    double b = CFAbsoluteTimeGetCurrent();

    unsigned int m = ((b-a) * 1000.0f); // convert from seconds to milliseconds

    NSLog(@"%@: %d ms", prefix ? prefix : @"Time taken", m);
}

- (void)ok_stronglyAssociateWithValue:(id)value forKey:(void *)aKey {
    objc_setAssociatedObject(self, aKey, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)ok_weaklyAssociateWithValue:(id)value forKey:(void *)aKey {
    objc_setAssociatedObject(self, aKey, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)ok_associatedValueForKey:(void *)aKey {
    return objc_getAssociatedObject(self, aKey);
}

/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)ok_performAsynchronous:(void (^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)ok_performOnMainThread:(void (^)(void))block wait:(BOOL)shouldWait {
    if (shouldWait) {
        // Synchronous
        dispatch_sync(dispatch_get_main_queue(), block);
    } else {
        // Asynchronous
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)ok_performAfter:(NSTimeInterval)seconds block:(void (^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (id)ok_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    return [[self class] ok_performBlock:block afterDelay:delay];
}

+ (id)ok_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;

    __block BOOL cancelled = NO;

    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };

    wrappingBlock = [wrappingBlock copy];

    dispatch_after(__dispatchTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO); });

    return wrappingBlock;
}

- (id)ok_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    return [[self class] ok_performBlock:block withObject:anObject afterDelay:delay];
}

+ (id)ok_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;

    __block BOOL cancelled = NO;

    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };

    wrappingBlock = [wrappingBlock copy];

    dispatch_after(__dispatchTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO, anObject); });

    return wrappingBlock;
}

+ (void)ok_cancelBlock:(id)block {
    if (!block) return;
    void (^aWrappingBlock)(BOOL) = (void (^)(BOOL))block;
    aWrappingBlock(YES);
}

+ (void)ok_cancelPreviousPerformBlock:(id)aWrappingBlockHandle {
    [self ok_cancelBlock:aWrappingBlockHandle];
}

@end

