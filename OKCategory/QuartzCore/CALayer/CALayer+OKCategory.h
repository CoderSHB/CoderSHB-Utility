//
//  CALayer+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (OKCategory)

@property(nonatomic, strong) UIColor *borderUIColor;
@property(nonatomic, strong) UIColor *contentsUIImage;

//旋转(Rotation)
@property (nonatomic) CGFloat transformRotation;     //!< key path "tranform.rotation"
@property (nonatomic) CGFloat transformRotationX;    //!< key path "tranform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    //!< key path "tranform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    //!< key path "tranform.rotation.z"


//缩放(Scale)
@property (nonatomic) CGFloat transformScale;        //!< key path "tranform.scale"
@property (nonatomic) CGFloat transformScaleX;       //!< key path "tranform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       //!< key path "tranform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       //!< key path "tranform.scale.z"


//平移(Translation)
@property (nonatomic) CGFloat transformTranslationX; //!< key path "tranform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; //!< key path "tranform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; //!< key path "tranform.translation.z"

/**
   Shortcut for transform.m34, -1/1000 is a good value.
   It should be set before other transform shortcut.
 */
@property (nonatomic, assign) CGFloat transformDepth;

/**
   Wrapper for `contentsGravity` property.
 */
@property (nonatomic, assign) UIViewContentMode contentMode;

/**
   Take snapshot without transform, image's size equals to bounds.
 */
- (UIImage *)ok_snapshotImage;

/**
   Take snapshot without transform, PDF's page size equals to bounds.
 */
- (nullable NSData *)ok_snapshotPDF;

/**
   Shortcut to set the layer's shadow

   @param color  Shadow Color
   @param offset Shadow offset
   @param radius Shadow radius
 */
- (void)ok_setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
   Remove all sublayers.
 */
- (void)ok_removeAllSublayers;

/**
   Add a fade animation to layer's contents when the contents is changed.

   @param duration Animation duration
   @param curve    Animation curve.
 */
- (void)ok_addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

/**
   Cancel fade animation which is added with "-addFadeAnimationWithDuration:curve:".
 */
- (void)ok_removePreviousFadeAnimation;

@end

NS_ASSUME_NONNULL_END