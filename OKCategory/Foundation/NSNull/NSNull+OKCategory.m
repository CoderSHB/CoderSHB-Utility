//
//  NSNull+OKCategory.h
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSNull+OKCategory.h"
#import "NSObject+OKRuntime.h"

@implementation NSNull (OKCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ok_swizzleMethod:@selector(methodSignatureForSelector:)
                    withMethod:@selector(ok_methodSignatureForSelector:)];
        
        [self ok_swizzleMethod:@selector(forwardInvocation:)
                    withMethod:@selector(ok_forwardInvocation:)];
    });
}

- (NSMethodSignature *)ok_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self ok_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)ok_forwardInvocation:(NSInvocation *)anInvocation {
    
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        return;
    }
    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

@end
