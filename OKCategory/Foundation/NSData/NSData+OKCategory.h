//
//  NSData+OKCategory
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (OKCategory)

/**
 *  @brief 将APNS NSData类型token 格式化成字符串
 *
 *  @return 整理过后的字符串token
 */
- (NSString *)ok_APNSToken;

/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (nullable NSString *)ok_UTF8String;

/**
 *  @brief 转换成16进制字符串
 *
 *  @return 转换后的字符串
 */
- (NSString *)ok_hexadecimalString;

@end

#pragma mark - 加密 解密

@interface NSData (OKEncrypt)

#pragma mark MD2 MD4 MD5加密

- (NSString *)ok_MD2Encryption; // MD2加密
- (NSString *)ok_MD4Encryption; // MD4加密
- (NSString *)ok_MD5Encryption; // MD5加密

- (NSData *)ok_MD2DataEncryption; // MD2加密
- (NSData *)ok_MD4DataEncryption; // MD4加密
- (NSData *)ok_MD5DataEncryption; // MD5加密

#pragma mark SHA1 SHA224 SHA256 SHA384 SHA512加密

- (NSString *)ok_SHA1Encryption;   // SHA1加密
- (NSString *)ok_SHA224Encryption; // SHA224加密
- (NSString *)ok_SHA256Encryption; // SHA256加密
- (NSString *)ok_SHA384Encryption; // SHA384加密
- (NSString *)ok_SHA512Encryption; // SHA512加密

- (NSData *)ok_SHA1DataEncryption;   // SHA1加密
- (NSData *)ok_SHA224DataEncryption; // SHA224加密
- (NSData *)ok_SHA256DataEncryption; // SHA256加密
- (NSData *)ok_SHA384DataEncryption; // SHA384加密
- (NSData *)ok_SHA512DataEncryption; // SHA512加密

/**
 *  @brief 利用AES加密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 加密后数据
 */
- (nullable NSData *)ok_encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  @brief 利用AES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (nullable NSData *)ok_decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  @brief 利用3DES加密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 加密后数据
 */
- (nullable NSData *)ok_encryptedWith3DESUsingKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  @brief 利用3DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (nullable NSData *)ok_decryptedWith3DESUsingKey:(NSString *)key andIV:(NSData *)iv;

@end

#pragma mark - BASE64编码

@interface NSData (OKBase64)

/**
 *  @brief NSData转NSString BASE64编码
 */
- (NSString *)ok_base64EncodedString;

/**
 *  @brief BASE64反编码
 */
+ (nullable NSString *)ok_Base64DecodedString:(NSString *)base64String;

- (NSData *)ok_base64Encoded;
- (nullable NSData *)ok_Base64Decoded;

/**
 *  @brief  字符串base64后转data
 *
 *  @param  string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (nullable NSData *)ok_dataWithBase64EncodedString:(NSString *)string;

/**
 *  @brief  NSData转string
 *
 *  @param  wrapWidth 换行长度
 *
 *  @return base64后的字符串
 */
- (nullable NSString *)ok_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

@end

#pragma mark - 压缩 解压缩

//@interface NSData (OKGzip)
//
///**
// *  @brief  GZIP压缩 压缩级别 默认-1
// *
// *  @return 压缩后的数据
// */
//- (nullable NSData *)ok_gzippedData;
//
///**
// *  @brief  GZIP压缩
// *
// *  @param level 压缩级别
// *
// *  @return 压缩后的数据
// */
//- (nullable NSData *)ok_gzippedDataWithCompressionLevel:(float)level;
//
///**
// *  @brief  GZIP解压
// *
// *  @return 解压后数据
// */
//- (nullable NSData *)ok_gunzippedData;
//
//@end

NS_ASSUME_NONNULL_END