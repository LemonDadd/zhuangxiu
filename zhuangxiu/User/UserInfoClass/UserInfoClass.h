//
//  UserInfoClass.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInfoClass;
static UserInfoClass *staticUserInfoClass;

@interface UserInfoClass : NSObject

@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *username;

/**
 *  获取用户信息
 *
 *  @return
 */
+ (UserInfoClass*)getUserInfoClass;

/**
 *  保存用户信息
 */
- (void)saveUserInfoClass;

/**
 *  清除用户信息
 */
- (void)clearUserInfoClass;

/**
 *  切换用户的头像
 *
 *  @param imagePath
 */
+ (void)saveUserHeadImagePath:(NSString*)imagePath;


/**
 设置用户属性值
 
 @param value
 @param key
 @return
 */
+ (UserInfoClass *)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
