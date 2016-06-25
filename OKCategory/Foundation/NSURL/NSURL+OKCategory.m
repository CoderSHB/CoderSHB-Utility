//
//  NSURL+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "NSURL+OKCategory.h"

static NSString *const OKURLReservedChars = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const OKQuerySeparator   = @"&";
static NSString *const OKQueryDivider     = @"=";
static NSString *const OKQueryBegin       = @"?";
static NSString *const OKFragmentBegin    = @"#";

@implementation NSDictionary (OKCategory_Private)

static inline NSString *uq_URLEscape(NSString *string);

- (NSString *)ok_URLQueryString {
    return [self ok_URLQueryStringWithSortedKeys:NO];
}

- (NSString*)ok_URLQueryStringWithSortedKeys:(BOOL)sortedKeys {
    NSMutableString *queryString = @"".mutableCopy;
    NSArray *keys = sortedKeys ? [self.allKeys sortedArrayUsingSelector:@selector(compare:)] : self.allKeys;
    for (NSString *key in keys) {
        id rawValue = self[key];
        NSString *value = nil;
        // beware of empty or null
        if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
            value = uq_URLEscape([self[key] description]);
        }
        [queryString appendFormat:@"%@%@%@%@",
         queryString.length ? OKQuerySeparator : @"",    // appending?
         uq_URLEscape(key),
         value ? OKQueryDivider : @"",
         value ? value : @""];
    }
    return queryString.length ? queryString.copy : nil;
}

static inline NSString *uq_URLEscape(NSString *string) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return ((__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)string,
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)OKURLReservedChars,
                                                                                  kCFStringEncodingUTF8));
    
}

#pragma clang diagnostic pop

@end

@implementation NSURL (OKCategory)

- (BOOL)isEqualToURL:(NSURL *)otherURL {
    return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
           ([self isFileURL] && [otherURL isFileURL] &&
            ([[self path] isEqual:[otherURL path]]));
}

- (NSDictionary *)ok_queryParameters {
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}

- (NSString *)ok_valueForParameter:(NSString *)aKey {
    return [[self ok_queryParameters] objectForKey:aKey];
}

- (NSURL *)ok_URLByAppendingQueryParameter:(NSString *)parameter {

    NSString *queryStr       = self.query;
    NSString *resultQueryStr = nil;

    NSString *resultUrlStr   = nil;
    NSString *absoluteUrlStr = self.absoluteString;
    NSRange  hashRange       = [absoluteUrlStr rangeOfString:@"#"];

    //判断原始url是否包含query部分
    if (queryStr && queryStr.length > 0) {
        //包含query
        resultQueryStr = [NSString stringWithFormat:@"%@&%@", queryStr, parameter];
        resultUrlStr   = [absoluteUrlStr stringByReplacingOccurrencesOfString:queryStr withString:resultQueryStr];

    } else {
        //未包含query
        resultQueryStr = [NSString stringWithFormat:@"?%@", parameter];
        if (hashRange.location != NSNotFound) {

            //发现hash
            //先截取hash部分，再拼接query
            NSString *hashStr = [absoluteUrlStr substringFromIndex:hashRange.location];
            NSString *subUrl  = [NSString stringWithFormat:@"%@%@", resultQueryStr, hashStr];
            resultUrlStr = [absoluteUrlStr stringByReplacingOccurrencesOfString:hashStr withString:subUrl];

        } else {
            resultUrlStr = [NSString stringWithFormat:@"%@/?%@", absoluteUrlStr, parameter];
        }
    }
    return [NSURL URLWithString:resultUrlStr];
}

- (NSURL *)ok_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary {
    return [self ok_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL *)ok_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary
                             withSortedKeys:(BOOL)sortedKeys {

    NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;

    NSString *dictionaryQuery = [queryDictionary ok_URLQueryStringWithSortedKeys:sortedKeys];

    if (dictionaryQuery) {
        [queries addObject:dictionaryQuery];
    }
    NSString *newQuery = [queries componentsJoinedByString:OKQuerySeparator];

    if (newQuery.length) {
        NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:OKQueryBegin];
        if (queryComponents.count) {
            return [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@%@%@%@%@",
                     queryComponents[0],                      // existing url
                     OKQueryBegin,
                     newQuery,
                     self.fragment.length ? OKFragmentBegin : @"",
                     self.fragment.length ? self.fragment : @""]];
        }
    }
    return self;
}

- (NSURL *)ok_URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary {
    return [self ok_URLByReplacingQueryWithDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL *)ok_URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary
                                 withSortedKeys:(BOOL)sortedKeys {
    NSURL *stripped = [self ok_URLByRemovingQuery];
    return [stripped ok_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:sortedKeys];
}

- (NSURL*) ok_URLByRemovingQuery {
    NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:OKQueryBegin];
    if (queryComponents.count) {
        return [NSURL URLWithString:queryComponents.firstObject];
    }
    return self;
}


@end
