//
//  HttpHelpBase.h
//  jinheLV
//
//  Created by 今合网技术部 on 2016/12/15.
//  Copyright © 2016年 今合网技术部. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface HttpHelpBase : NSObject

+ (AFSecurityPolicy*)customSecurityPolicy;

@end
