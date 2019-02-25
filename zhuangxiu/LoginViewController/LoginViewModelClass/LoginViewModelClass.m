//
//  LoginViewModelClass.m
//  Museum
//
//  Created by 关云秀 on 2017/12/20.
//  Copyright © 2017年 xuannalisha. All rights reserved.
//

#import "LoginViewModelClass.h"

@implementation LoginViewModelClass

- (void)requestLoginByUserName:(NSString *)userName
                        passwd:(NSString *)passwd
                       request:(void(^)(NSString *errorMsg))request {
    [AllRequest requestLoginByUserName:userName passwd:passwd request:^(UserInfoClass *userInfoClass, BOOL success, NSString *errorMsg, BOOL error) {
        if (success && !error) {
            [userInfoClass saveUserInfoClass];
            request(nil);
        }else {
            request(errorMsg);
        }
    }];
}

@end
