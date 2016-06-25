//
//  NSURL+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (OKCategory)

- (BOOL)isEqualToURL:(NSURL *)otherURL;

/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)ok_queryParameters;

/**
 *  @brief  根据参数名 取参数值
 *
 *  @param aKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)ok_valueForParameter:(NSString *)aKey;

/**
 *  @brief 添加query参数
 *
 *  @param parameters 接入参数(a=b&c=d)
 *
 *  @return 接入后结果
 */
- (NSString *)ok_URLByAppendingQueryParameter:(NSString *)parameter;

/**
 *  @brief URL增加query dictionary
 *
 *  @param queryDictionary queryDictionary
 *
 *  @return 增加后的URL
 */
- (NSURL *)ok_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary;

/**
 *  @brief 在当前URL添加字典中的keys/values
 *
 *  @param queryDictionary Query keys/values
 *
 *  @return 拼接后的URL
 */
- (NSURL *)ok_URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary;

/**
 *  @brief 在当前URL添加字典中的keys/values
 *
 *  @param queryDictionary Query keys/values
 *  @param sortedKeys      是否排序(排序规则按照字母顺序)
 *
 *  @return 拼接后的URL
 */
- (NSURL *)ok_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary
                             withSortedKeys:(BOOL)sortedKeys;

/**
 *  @brief 添加字典中的keys/values 将URL中与queryDictionary相同的key替换
 *
 *  @param queryDictionary Query keys/values
 *  @param sortedKeys      是否排序(排序规则按照字母顺序)
 *
 *  @return 拼接替换后的URL
 */
- (NSURL *)ok_URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary
                                 withSortedKeys:(BOOL)sortedKeys;

/**
 *  @brief 移除URL的Query
 *
 *  @return 移除后的URL
 */
- (NSURL *)ok_URLByRemovingQuery;

/**
 *  @brief 将URL的query转为字典
 */
//- (NSDictionary *)ok_URLQueryDictionary;

@end

NS_ASSUME_NONNULL_END