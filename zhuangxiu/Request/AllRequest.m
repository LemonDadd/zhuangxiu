
//
//  AllRequest.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "AllRequest.h"

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
    
}

@end
