//
//  NSNumber+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSNumber+OKCategory.h"

@implementation NSNumber (OKCategory)
- (CGFloat)ok_CGFloatValue {
#if (CGFLOAT_IS_DOUBLE)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

- (id)initWithCGFloat:(CGFloat)value {
#if (CGFLOAT_IS_DOUBLE)
    self = [self initWithDouble:value];
#else
    self = [self initWithFloat:value];
#endif
    return self;
}

+ (NSNumber *)numberWithCGFloat:(CGFloat)value {
    NSNumber *result = [[self alloc] initWithCGFloat:value];
    return result;
}

- (NSString *)ok_romanNumeber {
    NSInteger n = [self integerValue];

    NSArray *numerals = [NSArray arrayWithObjects:@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];

    NSUInteger valueCount = 13;
    NSUInteger values[]   = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};

    NSMutableString *numeralString = [NSMutableString string];

    for (NSUInteger i = 0; i < valueCount; i++) {
        while (n >= values[i]) {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    return numeralString;
}

- (NSNumber *)ok_roundWithDigit:(NSUInteger)digit {
    NSNumber          *result;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber *)ok_ceilWithDigit:(NSUInteger)digit {
    NSNumber          *result;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber *)ok_floorWithDigit:(NSUInteger)digit {
    NSNumber          *result;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    return result;
}
@end
