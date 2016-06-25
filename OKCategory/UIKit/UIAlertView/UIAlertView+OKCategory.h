//
//  UIAlertView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (OKCategory)

@property (nonatomic, copy) UIAlertViewCallBackBlock alertViewCallBackBlock;

+ (void)ok_alertWithCallBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
