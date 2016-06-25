//
//  UIApplication+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (OKCategory)

- (NSString *)ok_appVersion;
- (NSString *)ok_appBuild;
- (NSString *)ok_appIdentifier;

- (NSString *)ok_currentLanguage;
- (NSString *)ok_deviceModel;

/// 应用沙盒存储空间大小
- (NSString *)ok_applicationSize;

/// Display the network activity indicator to provide feedback when your application accesses the network for more than a couple of seconds. If the operation finishes sooner than that, you don’t have to show the network activity indicator, because the indicator would be likely to disappear before users notice its presence.
- (void)ok_beganNetworkActivity;

/// Tell the application that a session of network activity has begun. The network activity indicator will remain showing or hide automatically depending the presence of other ongoing network activity in the app.
- (void)ok_endedNetworkActivity;

@end

NS_ASSUME_NONNULL_END