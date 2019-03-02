//
//  AllRequest.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "JsonDeal.h"

NS_ASSUME_NONNULL_BEGIN

#define api @"http://api.homer.app887.com"
#define getNew @"/api/Articles.action?npc=0&opc=20&type=家居设计/家饰搭配/装修指南/装修风水&uid=387570 "

@interface AllRequest : JsonDeal

+ (void)requestGetHomeListBySkip:(NSInteger)skip
                             request:(void(^)(NSArray *message,
                                              NSString *errorMsg))request;

+ (void)requestGetPicListBySize:(NSInteger)size
                            Skip:(NSInteger)skip
                         request:(void(^)(NSArray *message,
                                          NSString *errorMsg))request;

+ (void)requestGetShouCangListBySize:(NSInteger)size
                           Skip:(NSInteger)skip
                        request:(void(^)(NSArray *message,
                                         NSString *errorMsg))request;

+ (void)requestGetNewListBySize:(NSInteger)npc
                           Skip:(NSInteger)opc
                           type:(NSString *)type
                             request:(void(^)(NSArray *message,
                                              NSString *errorMsg))request;

/**
 发送验证码
 
 @param mobile 手机号
 @param request 返回
 */
+ (void)requestsendValidCodeByMobile:(NSString *)mobile
                             request:(void(^)(NSString *message,
                                              BOOL success,
                                              NSString *errorMsg,
                                              BOOL error))request;

/**
 登录
 
 @param userName 用户名
 @param passwd 密码
 @param request 用户信息
 */
+ (void)requestLoginByUserName:(NSString *)userName
                        passwd:(NSString *)passwd
                       request:(void(^)(UserInfoClass *userInfoClass,
                                        BOOL success,
                                        NSString *errorMsg,
                                        BOOL error))request;

/**
 注册
 
 @param userName 用户名
 @param passwd 密码
 @param mobile 手机号
 @param validCode 验证码
 @param validid 验证码Id
 @param request 用户信息
 */
+ (void)requestUserRegByUserName:(NSString *)userName
                          passwd:(NSString *)passwd
                          mobile:(NSString *)mobile
                       validCode:(NSString *)validCode
                         validid:(NSString *)validid
                         request:(void(^)(UserInfoClass *userInfoClass,
                                          BOOL success,
                                          NSString *errorMsg,
                                          BOOL error))request;

/**
 重置密码
 
 @param passwd 密码
 @param mobile 手机号
 @param validCode 验证码
 @param validid 验证码Id
 @param request 返回
 */
+ (void)requestResetPasswordBypasswd:(NSString *)passwd
                              mobile:(NSString *)mobile
                           validCode:(NSString *)validCode
                             validid:(NSString *)validid
                             request:(void(^)(BOOL message,
                                              BOOL success,
                                              NSString *errorMsg,
                                              BOOL error))request;

/**
 重新绑定手机
 
 @param mobile 手机号
 @param validCode 验证码
 @param validid 验证码Id
 @param request 返回
 */
+ (void)requestUpdateMobileByMobile:(NSString *)mobile
                          validCode:(NSString *)validCode
                            validid:(NSString *)validid
                            request:(void(^)(BOOL message,
                                             BOOL success,
                                             NSString *errorMsg,
                                             BOOL error))request;

/**
 修改密码
 
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param request 返回
 */
+ (void)requestUpdatePasswordByNewPassword:(NSString *)newPassword
                               oldPassword:(NSString *)oldPassword
                                   request:(void(^)(BOOL message,
                                                    BOOL success,
                                                    NSString *errorMsg,
                                                    BOOL error))request;


+ (void)requestUpdatePhotoByPhoto:(NSString *)photo
                          request:(void(^)(NSString *message,
                                           BOOL success,
                                           NSString *errorMsg,
                                           BOOL error))request;

+ (void)uploadImagesByImags:(NSArray *)imgs
                  ImagNames:(NSArray *)imagenames
                    Request:(void(^)(NSString *message,
                                     NSString *errorMsg))request;

@end

NS_ASSUME_NONNULL_END
