//
//  HttpHelper.m
//  zjproject
//
//  Created by rockontrol on 15/4/14.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import "HttpHelper.h"
#import <AFNetworking/AFNetworking.h>
#import "HttpHelpBase.h"

@implementation HttpHelper

+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
                request:(void(^)(BOOL finish, NSString* data))requestFun
{
    NSMutableDictionary *theDic = [[NSMutableDictionary alloc] initWithDictionary:paramDictionary];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //https
    //[manager setSecurityPolicy:[HttpHelpBase customSecurityPolicy]];
    
    [manager POST:urlString parameters:theDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSString *responseString = [responseObject mj_JSONString];
        requestFun(true, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        requestFun(false, dic[@"NSLocalizedDescription"]);
    }];
}

+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
         TimeOutSeconds:(NSInteger)timeOutSeconds
                request:(void(^)(BOOL finish, NSString* data))requestFun
{
    NSMutableDictionary *theDic = [[NSMutableDictionary alloc] initWithDictionary:paramDictionary];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //https
    //[manager setSecurityPolicy:[HttpHelpBase customSecurityPolicy]];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeOutSeconds;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
   
    
    [manager POST:urlString parameters:theDic  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [responseObject mj_JSONString];
        requestFun(true, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        requestFun(false, dic[@"NSLocalizedDescription"]);
    }];
}

+ (void)httpDataRequestByGetMethod:(NSString *)urlString
                   paramDictionary:(NSDictionary *)paramDictionary
                           request:(void (^)(BOOL, NSString *))requestFun{
     NSMutableDictionary *theDic = [[NSMutableDictionary alloc] initWithDictionary:paramDictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //https
    //[manager setSecurityPolicy:[HttpHelpBase customSecurityPolicy]];
    [manager GET:urlString parameters:theDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [responseObject mj_JSONString];
        requestFun(true, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        requestFun(false, dic[@"NSLocalizedDescription"]);
    }];
}

+ (void)httpDataRequestByGetMethod:(NSString *)urlString
                   paramDictionary:(NSDictionary *)paramDictionary
                    TimeOutSeconds:(NSInteger)timeOutSeconds
                           request:(void (^)(BOOL, NSString *))requestFun {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //https
    //[manager setSecurityPolicy:[HttpHelpBase customSecurityPolicy]];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeOutSeconds;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:urlString parameters:paramDictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [responseObject mj_JSONString];
        requestFun(true, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        requestFun(false, dic[@"NSLocalizedDescription"]);
    }];
}

@end












