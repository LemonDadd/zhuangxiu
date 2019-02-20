//
//  JsonToDic.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "JsonToDic.h"

@implementation JsonToDic

+(id)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return data;
}

@end
