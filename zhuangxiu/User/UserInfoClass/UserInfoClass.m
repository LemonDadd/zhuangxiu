//
//  UserInfoClass.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserInfoClass.h"

//用户信息
#define UserInfoKey @"UserInfoKey"

@implementation UserInfoClass

+ (UserInfoClass*)getUserInfoClass {
    @synchronized (self) {
        NSDictionary* userInfoDic = [[CacheDeal getInstancetype] getObject:UserInfoKey];
        if (userInfoDic == nil) {
            return nil;
        }
        UserInfoClass* userInfoClass = [UserInfoClass mj_objectWithKeyValues:userInfoDic];
        TT_RELEASE_SAFELY(userInfoDic);
        staticUserInfoClass = userInfoClass;
        return userInfoClass;
    }
}

- (void)saveUserInfoClass {
    @synchronized (self) {
        NSDictionary *dic = [self mj_keyValues];
        [[CacheDeal getInstancetype] saveObject:dic key:UserInfoKey];
        staticUserInfoClass = [UserInfoClass mj_objectWithKeyValues:dic];
    }
}

- (void)clearUserInfoClass {
    @synchronized (self) {
        staticUserInfoClass = nil;
        [[CacheDeal getInstancetype] removeDataKey:UserInfoKey];
    }
}

+ (void)saveUserHeadImagePath:(NSString*)imagePath{
    if (imagePath.length == 0) {
        return;
    }
    @synchronized (self) {
        NSMutableDictionary* userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[CacheDeal getInstancetype] getObject:UserInfoKey]];
        [userInfoDic removeObjectForKey:@"photo"];
        
        [userInfoDic setObject:imagePath forKey:@"photo"];
        [[CacheDeal getInstancetype] removeDataKey:UserInfoKey];
        [[CacheDeal getInstancetype] saveObject:userInfoDic key:UserInfoKey];
        staticUserInfoClass = [UserInfoClass mj_objectWithKeyValues:userInfoDic];
    }
}

+ (UserInfoClass *)setValue:(id)value forKey:(NSString *)key {
    if (value == nil ||
        key == nil) {
        return nil;
    }
    UserInfoClass *userInfoClass = [UserInfoClass getUserInfoClass];
    [userInfoClass setValue:value forKey:key];
    [userInfoClass saveUserInfoClass];
    staticUserInfoClass = userInfoClass;
    return userInfoClass;
}
@end
