//
//  NSBundle+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSBundle+OKCategory.h"

@implementation NSBundle (OKCategory)

- (UIImage *)ok_appIcon {
    UIImage *appIcon = [[UIImage alloc] initWithContentsOfFile:[self ok_appIconPath]];
    return appIcon;
}

- (NSString *)ok_appIconPath {
    NSString *iconFilename  = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    NSString *iconBasename  = [iconFilename stringByDeletingPathExtension];
    NSString *iconExtension = [iconFilename pathExtension];
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension];
}

@end
