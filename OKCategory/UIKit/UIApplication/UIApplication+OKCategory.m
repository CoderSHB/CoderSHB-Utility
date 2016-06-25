//
//  UIApplication+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "UIApplication+OKCategory.h"
#import <sys/utsname.h>
#import <libkern/OSAtomic.h>
#import "NSFileManager+OKCategory.h"

static volatile int32_t numberOfActiveNetworkConnections;

@implementation UIApplication (OKCategory)

- (NSString *)ok_appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)ok_appBuild {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

- (NSString *)ok_appIdentifier {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)ok_currentLanguage {
    NSArray  *languages       = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages firstObject];
    return [NSString stringWithString:currentLanguage];
}

- (NSString *)ok_deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithString:deviceString];
}

- (NSString *)ok_applicationSize {
    unsigned long long docSize   = [NSFileManager ok_sizeOfFolder:[NSFileManager ok_documentPath]];
    unsigned long long libSize   = [NSFileManager ok_sizeOfFolder:[NSFileManager ok_libraryPath]];
    unsigned long long cacheSize = [NSFileManager ok_sizeOfFolder:[NSFileManager ok_cachesPath]];

    unsigned long long total = docSize + libSize + cacheSize;

    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (void)ok_beganNetworkActivity {
    self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnections) > 0;
}

- (void)ok_endedNetworkActivity {
    self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnections) > 0;
}

@end
