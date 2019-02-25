//
//  LoginViewModelClass.h
//  Museum
//
//  Created by 关云秀 on 2017/12/20.
//  Copyright © 2017年 xuannalisha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoClass.h"

@interface LoginViewModelClass : NSObject

- (void)requestLoginByUserName:(NSString *)userName
                        passwd:(NSString *)passwd
                       request:(void(^)(NSString *errorMsg))request;

@end
