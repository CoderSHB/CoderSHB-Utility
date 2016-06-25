//
//  NSUserDefaults+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSUserDefaults+OKCategory.h"

@implementation NSUserDefaults (OKCategory)

+ (id)ok_objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)ok_saveObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id<NSCoding>)ok_modelForKey:(NSString *)defaultName {
    id<NSCoding> model;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
    if (data) {
        model = (id<NSCoding>)[NSKeyedUnarchiver unarchiveObjectWithData: data];
    }
    return model;
}

+ (void)ok_saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName {
    if (value) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
