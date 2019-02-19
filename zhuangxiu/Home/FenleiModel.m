//
//  FenleiModel.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/19.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "FenleiModel.h"

@implementation FenleiModel

+(void)load {
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"condition_list" : [ConditionListModel class]
                 };
    }];
}

@end

@implementation ConditionListModel

@end

