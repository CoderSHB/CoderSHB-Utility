//
//  UIImage+Utility.m
//  UIImage+Utility
//
//  Created by SHB on 15/2/26.
//  Copyright (c) 2015年 CoderSHB. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
  UIImage *oldImage = [UIImage imageNamed:imageName];
  CGFloat imageW = oldImage.size.width * 0.5;
  CGFloat imageH = oldImage.size.height * 0.5;
  UIImage *newImage = [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
  return newImage;
}

+ (UIImage *)circleImageWithName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
  UIImage *oldImage = [UIImage imageNamed:imageName];
  CGFloat imageW = oldImage.size.width + 2 * borderWidth;
  CGFloat imageH = oldImage.size.height + 2 * borderWidth;
  CGSize imageSize = CGSizeMake(imageW, imageH);
  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  [borderColor set];
  
  CGFloat bigRadius = imageW * 0.5;
  CGFloat centerX = bigRadius;
  CGFloat centerY = bigRadius;
  CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
  CGContextFillPath(ctx);
  
  CGFloat smallRadius = bigRadius - borderWidth;
  CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
  CGContextClip(ctx);
  
  [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
  CGFloat imageW = image.size.width + 2 * borderWidth;
  CGFloat imageH = image.size.height + 2 * borderWidth;
  CGSize imageSize = CGSizeMake(imageW, imageH);
  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  [borderColor set];
  
  CGFloat bigRadius = imageW * 0.5;
  CGFloat centerX = bigRadius;
  CGFloat centerY = bigRadius;
  CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
  CGContextFillPath(ctx);
  
  CGFloat smallRadius = bigRadius - borderWidth;
  CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
  CGContextClip(ctx);
  
  [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(CGPoint)markPosition
{
  UIImage *bgImage = [UIImage imageNamed:bgName];
  UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0);
  [bgImage drawAtPoint:CGPointZero];
  
  UIImage *markImage = [UIImage imageNamed:markImageName];
  [markImage drawAtPoint:markPosition];
  
  return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(ImageMarkPosition)markPosition padding:(CGFloat)padding
{
  UIImage *bgImage = [UIImage imageNamed:bgName];
  UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0);
  [bgImage drawAtPoint:CGPointZero];
  
  UIImage *markImage = [UIImage imageNamed:markImageName];
  CGFloat logoTopX = bgImage.size.width - markImage.size.width;
  CGFloat logoBottomY = bgImage.size.height - markImage.size.height;
  
  switch (markPosition) {
    case ImageMarkPositionTopRightCorner:
      [markImage drawAtPoint:CGPointMake(logoTopX - padding, 0)];
      break;
    case ImageMarkPositionTopLeftCorner:
      [markImage drawAtPoint:CGPointMake(0, 0)];
      break;
    case ImageMarkPositionBottomRightCorner:
      [markImage drawAtPoint:CGPointMake(logoTopX - padding, logoBottomY - padding)];
      break;
    case ImageMarkPositionBottomLeftCorner:
      [markImage drawAtPoint:CGPointMake(0, logoBottomY - padding)];
      break;
    default:
      break;
  }
  
  return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markString:(NSString *)markString attributes:(NSDictionary *)attrs markRect:(CGRect)rect
{
  UIImage *bgImage = [UIImage imageNamed:bgName];
  UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0);
  [bgImage drawAtPoint:CGPointZero];
  [markString drawInRect:rect withAttributes:attrs];
  
  return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)imageMarkWithBackgroundImageName:(NSString *)bgName markImageName:(NSString *)markImageName markPosition:(CGPoint)markPosition markString:(NSString *)markString attributes:(NSDictionary *)attrs markRect:(CGRect)rect
{
  UIImage *bgImage = [UIImage imageNamed:bgName];
  UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0);
  [bgImage drawAtPoint:CGPointZero];

  UIImage *markImage = [UIImage imageNamed:markImageName];
  [markImage drawAtPoint:markPosition];

  [markString drawInRect:rect withAttributes:attrs];
  
  return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)snapshotWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

@end
