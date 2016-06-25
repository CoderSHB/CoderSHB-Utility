//
//  UIBezierPath+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (OKCategory)

+ (UIBezierPath *)ok_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)ok_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)ok_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)ok_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)ok_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)ok_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end

NS_ASSUME_NONNULL_END