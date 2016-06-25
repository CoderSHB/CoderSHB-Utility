//
//  NSDecimalNumber+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSDecimalNumber+OKCategory.h"

@implementation NSDecimalNumber (OKCategory)

- (NSDecimalNumber *)ok_roundToScale:(NSUInteger)scale {
    return [self ok_roundToScale:scale mode:NSRoundPlain];
}

- (NSDecimalNumber *)ok_roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode {
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}

- (NSDecimalNumber *)ok_decimalNumberWithPercentage:(float)percent {
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:percent] decimalValue]];
    return [self decimalNumberByMultiplyingBy:percentage];
}

- (NSDecimalNumber *)ok_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage {
    NSDecimalNumber *hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *percent = [self decimalNumberByMultiplyingBy:[discountPercentage decimalNumberByDividingBy:hundred]];
    return [self decimalNumberBySubtracting:percent];
}

- (NSDecimalNumber *)ok_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale {
    NSDecimalNumber *value = [self ok_decimalNumberWithDiscountPercentage:discountPercentage];
    return [value ok_roundToScale:scale];
}

- (NSDecimalNumber *)ok_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue {
    NSDecimalNumber *hundred    = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *percentage = [[self decimalNumberByDividingBy:baseValue] decimalNumberByMultiplyingBy:hundred];
    return [hundred decimalNumberBySubtracting:percentage];
}

- (NSDecimalNumber *)ok_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale {
    NSDecimalNumber *discount = [self ok_discountPercentageWithBaseValue:baseValue];
    return [discount ok_roundToScale:scale];
}


@end
