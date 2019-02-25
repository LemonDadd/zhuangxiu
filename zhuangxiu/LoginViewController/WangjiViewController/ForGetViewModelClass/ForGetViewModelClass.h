//
//  ForGetViewModelClass.h
//  Museum
//
//  Created by keneng17 on 2017/12/22.
//  Copyright © 2017年 xuannalisha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForGetViewModelClass : NSObject

- (void)requestResetPasswordBypasswd:(NSString *)passwd
                          mobile:(NSString *)mobile
                       validCode:(NSString *)validCode
                         validid:(NSString *)validid
                         request:(void(^)(NSString *errorMsg))request;

- (void)requestsendValidCodeByMobile:(NSString *)mobile
                             request:(void(^)(NSString *errorMsg))request;


@end
