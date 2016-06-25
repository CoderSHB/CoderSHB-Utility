//
//  UIView+Constraints
//
//  Copyright (c) 2015年 OK Inc. All rights reserved.
//

#import "UIView+OKConstraints.h"

@implementation UIView (OKConstraints)
-(NSLayoutConstraint *)ok_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)ok_leftConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)ok_rightConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)ok_topConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)ok_bottomConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)ok_leadingConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)ok_trailingConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)ok_widthConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)ok_heightConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)ok_centerXConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)ok_centerYConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)ok_baseLineConstraint {
    return [self ok_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
