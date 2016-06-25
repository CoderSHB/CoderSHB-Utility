//
//  UIDevice+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, OKHardware) {
    NOT_AVAILABLE,

    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6,
    IPHONE_6_PLUS,


    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,

    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,

    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,

    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,

    SIMULATOR
};

@interface UIDevice (OKCategory)

/// 获取设备类型
- (NSString *)ok_hardwareString;
- (OKHardware)ok_hardware;

/// 获取设备类型描述
- (NSString *)ok_hardwareDescription;
/// 获取设备类型描述 (不包括 GSM, CDMA, GLOBAL)
- (NSString *)ok_hardwareSimpleDescription;

/// 当前设备类型是否高于hardware
- (BOOL)ok_isCurrentDeviceHardwareBetterThan:(OKHardware)hardware;

///该方法返回静态图像的分辨率,可以收到从当前设备的相机
- (CGSize)ok_backCameraStillImageResolutionInPixels;

/// 当前设备是否是iPhone 4英寸屏幕
- (BOOL)ok_isIphoneWith4inchDisplay;

/// 获取IP地址
+ (NSString *)ok_IPAddress;

/// 获取mac地址
+ (NSString *)ok_macAddress;

/// 当前设备CPU频率
+ (NSUInteger)ok_cpuFrequency;
/// 返回当前设备总线频率
+ (NSUInteger)ok_busFrequency;
/// 当前设备内存大小
+ (NSUInteger)ok_ramSize;
/// 返回当前设备的CPU数量
+ (NSUInteger)ok_cpuNumber;

/// 获取iOS系统的版本号
+ (NSString *)ok_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)ok_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)ok_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)ok_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)ok_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)ok_totalDiskSpaceBytes;

@end
