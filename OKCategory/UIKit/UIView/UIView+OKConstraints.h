//
//  UIView+Constraints
//
//  Copyright (c) 2015年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (OKConstraints)

- (NSLayoutConstraint *)ok_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)ok_leftConstraint;
- (NSLayoutConstraint *)ok_rightConstraint;
- (NSLayoutConstraint *)ok_topConstraint;
- (NSLayoutConstraint *)ok_bottomConstraint;
- (NSLayoutConstraint *)ok_leadingConstraint;
- (NSLayoutConstraint *)ok_trailingConstraint;
- (NSLayoutConstraint *)ok_widthConstraint;
- (NSLayoutConstraint *)ok_heightConstraint;
- (NSLayoutConstraint *)ok_centerXConstraint;
- (NSLayoutConstraint *)ok_centerYConstraint;
- (NSLayoutConstraint *)ok_baseLineConstraint;

@end
