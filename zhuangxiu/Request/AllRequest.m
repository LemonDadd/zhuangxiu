
//
//  AllRequest.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "AllRequest.h"
#import "NHFUpLoadImages.h"

#define ErrorMessage @"数据请求失败,请检查您的网络"

@implementation AllRequest

+ (void)requestGetHomeListBySkip:(NSInteger)skip
                         request:(void(^)(NSArray *message,
                                          NSString *errorMsg))request{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [HttpHelper httpDataRequest:@"https://api.jiajuol.com/app/index.php" paramDictionary:dic request:^(BOOL finish, NSString *data) {
        request(nil,nil);
    }];
}

+ (void)requestGetPicListBySize:(NSInteger)size
                           Skip:(NSInteger)skip
                        request:(void(^)(NSArray *message,
                                         NSString *errorMsg))request {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [HttpHelper httpDataRequest:@"https://api.jiajuol.com/app/index.php" paramDictionary:dic request:^(BOOL finish, NSString *data) {
        request(nil,nil);
    }];
}

+ (void)requestGetShouCangListBySize:(NSInteger)size
                                Skip:(NSInteger)skip
                             request:(void(^)(NSArray *message,
                                              NSString *errorMsg))request {
    
}


+ (void)requestGetNewListBySize:(NSInteger)npc
                           Skip:(NSInteger)opc
                           type:(NSString *)type
                        request:(void(^)(NSArray *message,
                                         NSString *errorMsg))request {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%ld",npc] forKey:@"npc"];
    [dic setObject:[NSString stringWithFormat:@"%ld",opc] forKey:@"opc"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:@"387570" forKey:@"uid"];
    [HttpHelper httpDataRequestByGetMethod:@"http://api.homer.app887.com/api/Articles.action" paramDictionary:dic TimeOutSeconds:120 request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, @"请求失败");
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSArray *arr = dic[@"root"][@"list"];
                request(arr, nil);
            }
        } else {
            request(nil, @"请求失败");
        }
    }];
}

/**
 发送验证码
 
 @param mobile 手机号
 @param request 返回
 */
+ (void)requestsendValidCodeByMobile:(NSString *)mobile
                             request:(void(^)(NSString *message,
                                              BOOL success,
                                              NSString *errorMsg,
                                              BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:mobile forKey:@"mobile"];
    [HttpHelper httpDataRequest:SendValidCodeBaseUrl paramDictionary:paramDic TimeOutSeconds:120  request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    request(dic[@"data"], true, nil, false);
                } else {
                    request(nil, false, dic[@"message"], true);
                }
            }
        } else {
            request(nil, false, data, true);
        }
    }];
}

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
                                        BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:userName forKey:@"mobile"];
    [paramDic setObject:passwd forKey:@"password"];
    [HttpHelper httpDataRequest:LoginBaseUrl paramDictionary:paramDic TimeOutSeconds:120  request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    UserInfoClass *userInfoClass = [UserInfoClass mj_objectWithKeyValues:dic[@"data"]];
                    request(userInfoClass, true, nil, false);
                } else {
                    request(nil, false, dic[@"message"], true);
                }
            }
        } else {
            request(nil, false, data, true);
        }
    }];
}

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
                                          BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:userName forKey:@"username"];
    [paramDic setObject:passwd forKey:@"password"];
    [paramDic setObject:mobile forKey:@"mobile"];
    [paramDic setObject:validCode forKey:@"validcode"];
    [paramDic setObject:validid forKey:@"id"];
    [HttpHelper httpDataRequest:UserRegBaseUrl paramDictionary:paramDic TimeOutSeconds:120 request:^(BOOL finish,  NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    UserInfoClass *userInfoClass = [UserInfoClass mj_objectWithKeyValues:dic[@"data"]];
                    request(userInfoClass, true, nil, false);
                } else {
                    request(nil, false, dic[@"message"], true);
                }
            }
        } else {
            request(nil, false, data, true);
        }
    }];
}

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
                                              BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:passwd forKey:@"passwd"];
    [paramDic setObject:mobile forKey:@"mobile"];
    [paramDic setObject:validCode forKey:@"validCode"];
    [paramDic setObject:validid forKey:@"id"];
    [HttpHelper httpDataRequest:ResetPasswordBaseUrl paramDictionary:paramDic  TimeOutSeconds:120 request:^(BOOL finish, NSString *data) {
        if (finish) {
            if (data == nil) {
                request(false, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    request([dic[@"data"] boolValue], true, nil, false);
                } else {
                    request(false, false, dic[@"message"], true);
                }
            }
        } else {
            request(false, false, data, true);
        }
    }];
}

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
                                             BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:mobile forKey:@"mobile"];
    [paramDic setObject:validCode forKey:@"validCode"];
    [paramDic setObject:validid forKey:@"id"];
    [HttpHelper httpDataRequest:UpdateMobileBaseUrl paramDictionary:paramDic TimeOutSeconds:120 request:^(BOOL finish,  NSString *data) {
        if (finish) {
            if (data == nil) {
                request(false, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    request([dic[@"data"] boolValue], true, nil, false);
                } else {
                    request(false, false, dic[@"message"], true);
                }
            }
        } else {
            request(false, false, data, true);
        }
    }];
}

/**
 修改头像
 
 @param photo url
 @param request 头像地址
 */
+ (void)requestUpdatePhotoByPhoto:(NSString *)photo
                          request:(void(^)(NSString *message,
                                           BOOL success,
                                           NSString *errorMsg,
                                           BOOL error))request {
    NSMutableDictionary* paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:photo forKey:@"photo"];
    [HttpHelper httpDataRequest:UpdatePhotoBaseUrl paramDictionary:paramDic TimeOutSeconds:120 request:^(BOOL finish,  NSString *data) {
        if (finish) {
            if (data == nil) {
                request(nil, false, ErrorMessage, true);
            } else {
                NSDictionary* dic =[JsonDeal dealJson:data];
                NSInteger Code = [[dic objectForKey:@"code"] integerValue];
                if (Code == 1) {
                    request(dic[@"data"], true, nil, false);
                } else {
                    request(nil, false, dic[@"message"], true);
                }
            }
        } else {
            request(nil, false, data, true);
        }
    }];
}


+ (void)uploadImagesByImags:(NSArray *)imgs
                  ImagNames:(NSArray *)imagenames
                    Request:(void(^)(NSString *message,
                                     NSString *errorMsg))request {
    [[NHFUpLoadImages defaultManager]uploadMutableImageByUrlString:UploadBaseUrl params:nil images:imgs imageNames:imagenames process:^(CGFloat process) {
        
    } request:^(NSString *message, BOOL success, NSString *errorMsg, BOOL error) {
        if (success && !error) {
            NSDictionary* dic =[JsonDeal dealJson:message];
            NSInteger Code = [[dic objectForKey:@"code"] integerValue];
            if (Code == 1) {
                NSArray *arr =dic[@"data"];
                request(arr.firstObject,nil);
            } else {
                request(nil,dic[@"message"]);
            }
        }else {
            request(nil,errorMsg);
        }
    }];
}

@end
