//
//  UITableView+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (OKCategory)

- (void)ok_setExtraCellLineHidden;

- (void)ok_addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)ok_addLineforPlainCell:(UITableViewCell *)cell
             forRowAtIndexPath:(NSIndexPath *)indexPath
                     leftSpace:(CGFloat)leftSpace;

/**
 *  @brief  ios7设置页面的UITableViewCell样式
 *
 *  @param cell      cell
 *  @param indexPath indexPath
 */
- (void)ok_applyiOS7SettingsStyleGrouping:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END