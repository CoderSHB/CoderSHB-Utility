//
//  UIWebView+OKJavaScript
//
//  Copyright (c) 2014年 OK Inc. All rights reserved.
//

#import "UIWebView+OKJavaScript.h"

@implementation UIWebView (OKJavaScript)

/// 获取某个标签的结点个数
- (NSUInteger)ok_nodeCountOfTag:(NSString *)tag {
    NSString   *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    NSUInteger len       = [[self stringByEvaluatingJavaScriptFromString:jsString] integerValue];
    return len;
}

/// 获取当前页面URL
- (NSString *)ok_fetchCurrentURL {
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

/// 获取标题
- (NSString *)ok_fetchTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

/// 获取所有图片链接
- (NSArray *)ok_fetchImages {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self ok_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

/// 获取当前页面所有点击链接
- (NSArray *)ok_fetchAllURL {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self ok_nodeCountOfTag:@"a"]; i++) {
        NSString *jsString    = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

/// 改变所有图像的宽度
- (void)ok_setImageWidth:(CGFloat)width {
    for (int i = 0; i < [self ok_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].width = '%f'", i, width];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '%fpx'", i, width];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}

/// 改变所有图像的高度
- (void)ok_setImageHeight:(CGFloat)height {
    for (int i = 0; i < [self ok_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].height = '%f'", i, height];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.height = '%fpx'", i, height];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}

/// 改变指定标签的字体大小
- (void)ok_setFontSize:(CGFloat)fontSize withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.fontSize = '%fpx';}", tagName, fontSize];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

@end
