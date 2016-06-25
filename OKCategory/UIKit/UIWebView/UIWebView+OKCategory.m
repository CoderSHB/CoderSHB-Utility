//
//  UIWebView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIWebView+OKCategory.h"

@implementation UIWebView (OKCategory)

- (NSArray *)ok_fetchMetaData {
    NSString *string = [self stringByEvaluatingJavaScriptFromString:@""
                        "var json = '[';                                    "
                        "var a = document.getElementsByTagName('meta');     "
                        "for(var i=0;i<a.length;i++){                       "
                        "   json += '{';                                    "
                        "   var b = a[i].attributes;                        "
                        "   for(var j=0;j<b.length;j++){                    "
                        "       var name = b[j].name;                       "
                        "       var value = b[j].value;                     "
                        "                                                   "
                        "       json += '\"'+name+'\":';                    "
                        "       json += '\"'+value+'\"';                    "
                        "       if(b.length>j+1){                           "
                        "           json += ',';                            "
                        "       }                                           "
                        "   }                                               "
                        "   json += '}';                                    "
                        "   if(a.length>i+1){                               "
                        "       json += ',';                                "
                        "   }                                               "
                        "}                                                  "
                        "json += ']';                                       "];

    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error;
    id array = [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];

    if (error) {
        NSLog(@"%@", error);
    }
    return array;
}

- (void)ok_clearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;

    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];

    [NSUserDefaults.standardUserDefaults synchronize];
}


- (void)ok_hiddenShadowView {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}

- (void)ok_showHorizontalScrollIndicator:(BOOL)show {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:show];
        }
    }
}

- (void)ok_showVerticalScrollIndicator:(BOOL)show {
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:show];
        }
    }
}

- (void)ok_makeTransparent {
    self.backgroundColor = [UIColor clearColor];
    self.opaque          = NO;
}

- (void)ok_makeTransparentAndRemoveShadow {
    [self ok_makeTransparent];
    [self ok_hiddenShadowView];
}

@end
