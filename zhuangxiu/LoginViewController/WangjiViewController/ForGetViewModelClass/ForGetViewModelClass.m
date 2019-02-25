//
//  ForGetViewModelClass.m
//  Museum
//
//  Created by keneng17 on 2017/12/22.
//  Copyright © 2017年 xuannalisha. All rights reserved.
//

#import "ForGetViewModelClass.h"

@implementation ForGetViewModelClass

- (void)requestResetPasswordBypasswd:(NSString *)passwd
                              mobile:(NSString *)mobile
                           validCode:(NSString *)validCode
                             validid:(NSString *)validid
                             request:(void(^)(NSString *errorMsg))request {
    [AllRequest requestResetPasswordBypasswd:passwd mobile:mobile validCode:validCode validid:validid request:^(BOOL message, BOOL success, NSString *errorMsg, BOOL error) {
        [AllRequest requestsendValidCodeByMobile:mobile request:^(NSString *message, BOOL success, NSString *errorMsg, BOOL error) {
            if (success && !error) {
                request(nil);
            } else {
                request(errorMsg);
            }
        }];
    }];
}

- (void)requestsendValidCodeByMobile:(NSString *)mobile
                             request:(void(^)(NSString *errorMsg))request {
    [AllRequest requestsendValidCodeByMobile:mobile request:^(NSString *message, BOOL success, NSString *errorMsg, BOOL error) {
        if (success && !error) {
            request(nil);
        } else {
            request(errorMsg);
        }
    }];
}

@end
