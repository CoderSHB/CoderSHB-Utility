//
//  UIFont+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIFont+OKCategory.h"

@implementation UIFont (OKCategory)

+ (UIFont *)ok_HelveticaNeue:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueBold:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueUltraLight:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueCondensedBlack:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueBoldItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueCondensedBold:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueMedium:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueLight:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueThin:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueThinItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-ThinItalic" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueLightItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueUltraLightItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:fontsize];
    return font;
}

+ (UIFont *)ok_HelveticaNeueMediumItalic:(CGFloat)fontsize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-MediumItalic" size:fontsize];
    return font;
}

+ (UIFont *)ok_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName {
    return [UIFont ok_preferredFontForTextStyle:style withFontName:fontName scale:1.0f];
}

+ (UIFont *)ok_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale {

    UIFont *font = nil;
    if ([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]) {
        font = [UIFont preferredFontForTextStyle:fontName];
    } else {
        font = [UIFont fontWithName:fontName size:14 * scale];
    }
    return [font ok_adjustFontForTextStyle:style];
}

- (UIFont *)ok_adjustFontForTextStyle:(NSString *)style {
    return [self ok_adjustFontForTextStyle:style scale:1.0f];
}

- (UIFont *)ok_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale {

    UIFontDescriptor *fontDescriptor = nil;

    if ([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]) {

        fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];

    } else {

        fontDescriptor = self.fontDescriptor;

    }

    float dynamicSize = [fontDescriptor pointSize] * scale + 3;

    return [UIFont fontWithName:self.fontName size:dynamicSize];
}

@end
