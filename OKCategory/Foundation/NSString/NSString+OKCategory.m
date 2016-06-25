//
//  NSString+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSString+OKCategory.h"
#import "NSData+OKCategory.h"

@implementation NSString (OKCategory)

- (BOOL)ok_isNull {
    if (!self || [self isKindOfClass:[NSNull class]] || [self ok_isEmptyAfterTrim]) {
        return YES;
    }
    return NO;
}

- (BOOL)ok_isEmpty {
    return (!self || !self.length);
}

- (BOOL)ok_isEmptyAfterTrim {
    return [[self ok_trimmingWhitespaceAndNewlines] isEqualToString:@""];
}

- (BOOL)ok_isStartsWithACapitalLetter {

    unichar firstCharacter = [self characterAtIndex:0];
    return [[NSCharacterSet uppercaseLetterCharacterSet]
            characterIsMember:firstCharacter];
}


- (NSString *)ok_firstCharacter {
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}


//- (NSUInteger)ok_numberOfWords {
//    __block NSUInteger count = 0;
//    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
//                             options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
//                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
//     {
//         count++;
//     }];
//    return count;
//}
- (NSUInteger)ok_countNumberOfWords {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet:whiteSpace intoString:nil]) {
        count++;
    }

    return count;
}

- (NSString *)ok_reverseString {

    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[self length]];

    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         [reversedString appendString:substring];
     }];
    return reversedString;
}

- (NSString *)ok_removeSubString:(NSString *)subString {
    if ([self ok_containsString:subString]) {
        NSRange range = [self rangeOfString:subString];
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

- (BOOL)ok_containsOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)ok_containsOnlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)ok_containsOnlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

- (CGFloat)ok_widthWithFont:(UIFont *)font containerHeight:(CGFloat)containerHeight {
    return [self ok_sizeWithFont:font containerSize:CGSizeMake(containerHeight, CGFLOAT_MAX)].width;
}

- (CGFloat)ok_heightWithFont:(UIFont *)font containerWidth:(CGFloat)containerWidth {
    return [self ok_sizeWithFont:font containerSize:CGSizeMake(containerWidth, CGFLOAT_MAX)].height;
}

- (CGSize)ok_sizeWithFont:(UIFont *)font containerSize:(CGSize)containerSize {
    
    UIFont *textFont = font ? : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:containerSize
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingUsesFontLeading |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:containerSize
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: [NSParagraphStyle defaultParagraphStyle]};
    
    textSize = [self boundingRectWithSize:containerSize
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingUsesFontLeading |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end


@implementation NSString (OKCategory_SafeAccess)

- (BOOL)ok_containsString:(NSString *)string {
    
    if (string.length == 0) {
        return NO;
    }
    
    if (__IPHONE_OS_VERSION_MIN_REQUIRED < 80000) {
        NSRange range = [self rangeOfString:string];
        return range.location == NSNotFound ? NO : YES;
    } else {
        return [self containsString:string];
    }
}

- (NSString *)ok_substringWithRange:(NSRange)range {
    if (range.location > self.length || range.length == 0) {
        return self;
    } else if ((range.location + range.length) > self.length) {
        return self;
    }
    
    return [self substringWithRange:range];
}

@end

@implementation NSString (OKCategory_Trims)

- (NSString *)ok_trimmingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)ok_trimmingWhitespaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ok_stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)ok_stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString ok_stringByStrippingHTML];
}

@end

@implementation NSString (OKCategory_Base64)

#pragma mark - URL Encoding and Decoding
- (NSString *)ok_URLEncode {
    return [self ok_URLEncodeUsingEncoding:NSUTF8StringEncoding];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)ok_URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)ok_URLDecode {
    return [self ok_URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)ok_URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

#pragma clang diagnostic pop

+ (NSString *)ok_stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData ok_dataWithBase64EncodedString:string];
    if (data) {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)ok_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data ok_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)ok_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data ok_base64EncodedString];
}

- (NSString *)ok_base64DecodedString {
    return [NSString ok_stringWithBase64EncodedString:self];
}

- (NSData *)ok_base64DecodedData {
    return [NSData ok_dataWithBase64EncodedString:self];
}

@end

#pragma mark OKCategory_Encrypt

@implementation NSString (OKCategory_Encrypt)

- (NSString *)ok_MD5
{
    NSData * value;
    
    value = [NSData dataWithBytes:[self UTF8String] length:[self length]];
    return [value ok_MD5Encryption];
}


@end

