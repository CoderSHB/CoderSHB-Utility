//
//  UILabel+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//#ifdef Insepectable_enable
//IB_DESIGNABLE
//@interface UILabel (OKCategory)
// set text hex color
//@property (nonatomic, copy) IBInspectable NSString *textHexColor;
//#else
@interface UILabel (OKCategory)
//#endif

-(void)ok_setBackgroundImage:(UIImage *)bgImage;


@end

NS_ASSUME_NONNULL_END