//
//  NSString+Device.m
//
//  Created by SHB on 16/1/4.
//  Copyright © 2016年 CoderSHB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Device.h"
#import "sys/utsname.h"

#if TARGET_IPHONE_SIMULATOR
    #define SIMULATOR 1
#else
    #define SIMULATOR 0
#endif

BOOL isiPhone4(void) {
    return [NSString isiPhone4];
}

BOOL isiPhone5(void) {
    return [NSString isiPhone5];
}

BOOL isiPhone6(void) {
    return [NSString isiPhone6];
}

BOOL isiPhone6P(void) {
    return [NSString isiPhone6P];
}

@implementation NSString (Device)

+ (BOOL)isiPhone4 {
    if (SIMULATOR) {
        return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO;
    } else {
        return [[NSString deviceVersion] isEqualToString:@"iPhone 4"]
                || [[NSString deviceVersion] isEqualToString:@"iPhone 4S"];
    }
}

+ (BOOL)isiPhone5 {
    if (SIMULATOR) {
        return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO;
    } else {
        return [[NSString deviceVersion] isEqualToString:@"iPhone 5"]
                || [[NSString deviceVersion] isEqualToString:@"iPhone 5C"]
                || [[NSString deviceVersion] isEqualToString:@"iPhone 5S"];
    }
}

+ (BOOL)isiPhone6 {
    if (SIMULATOR) {
        return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO;
    } else {
        return [[NSString deviceVersion] isEqualToString:@"iPhone 6"]
                || [[NSString deviceVersion] isEqualToString:@"iPhone 6S"];
    }
}

+ (BOOL)isiPhone6P {
    if (SIMULATOR) {
       return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO;
    } else {
        return [[NSString deviceVersion] isEqualToString:@"iPhone 6 Plus"]
        || [[NSString deviceVersion] isEqualToString:@"iPhone 6S Plus"];
    }
}

/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString *)deviceVersion {

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";

    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";

    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad mini (CDMA)";

    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (CDMA)";

    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";

    //Simulator
    if ([deviceString isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";

    if ([deviceString isEqualToString:@"iPad4,4"]
        || [deviceString isEqualToString:@"iPad4,5"]
        || [deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";

    if ([deviceString isEqualToString:@"iPad4,7"]
        || [deviceString isEqualToString:@"iPad4,8"]
        || [deviceString isEqualToString:@"iPad4,9"]) return @"iPad mini 3";

    return deviceString;
}

@end
