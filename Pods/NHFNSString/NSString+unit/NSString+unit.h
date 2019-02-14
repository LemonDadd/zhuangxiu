//
//  NSString+unit.h
//  zjproject
//
//  Created by rockontrol on 15/4/15.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(unit)

/**
 *  将汉字转成UTF8
 *
 *  @return
 */
- (NSString*)hzToUTF8;

/**
 *  检查手机号码
 *
 *  @return 
 */
- (BOOL)checkPhoneNumInput;

/**
 *  去掉文本两边的空格
 *
 *  @return 
 */
- (NSString*)stringTrim;

/**
 *  获取随机码
 *
 *  @param from
 *  @param to
 *
 *  @return 
 */
+ (NSString*)getRandomNumber:(NSInteger)from to:(NSInteger)to;

/**
 *  整形判断
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  浮点形判断
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isPureFloat:(NSString *)string;

/**
 *  进行md5加密
 *
 *  @return 
 */
- (NSString *)md5;

/**
 *  将汉字转成拼音
 *
 *  @return
 */
- (NSString *)pinYin;

/**
 *  根据定位的信息处理距离信息
 *
 *  @param instance
 *
 *  @return
 */
+ (NSString *)locationInstance:(float)instance;

/**
 *  转向UTF8编码
 *
 *  @param string
 *
 *  @return 
 */
+ (NSString *)toUTF8:(NSString *)string;

/**
 *  测试字符串是否是空的数据
 *
 *  @param string
 *
 *  @return 
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 *  类型转换
 *
 *  @param object
 *
 *  @return 
 */
+ (NSString *)convertByBool:(BOOL)object;

/**
 *  判空
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isNULLBy:(NSString *)string;

/**
 *  获取唯一编码
 *
 *  @return
 */
+ (NSString *)getUniqueStrByUUID;

@end













