//
//  NewsModel.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
+(void)load {
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"talks" : [NewsTalksModel class]
                 };
    }];
}
@end

@implementation NewsIdModel

@end

@implementation NewsTalksModel

@end
