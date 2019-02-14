//
//  HttpHelper.h
//  zjproject
//
//  Created by rockontrol on 15/4/14.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject

/**
 *  Post
 *
 *  @param urlString
 *  @param paramDictionary
 *  @param requestFun
 */
+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
                request:(void(^)(BOOL finish, NSString* data))requestFun;

/**
 *  Post TimeOut
 *
 *  @param urlString
 *  @param paramDictionary
 *  @param timeOutSeconds
 *  @param requestFun
 */
+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
         TimeOutSeconds:(NSInteger)timeOutSeconds
                request:(void(^)(BOOL finish, NSString* data))requestFun;

/**
 *  Get
 *
 *  @param urlString
 *  @param paramDictionary
 *  @param requestFun
 */
+ (void)httpDataRequestByGetMethod:(NSString *)urlString
                   paramDictionary:(NSDictionary *)paramDictionary
                           request:(void (^)(BOOL, NSString *))requestFun;

/**
 *  Get TimeOut
 *
 *  @param urlString
 *  @param paramDictionary
 *  @param timeOutSeconds
 *  @param requestFun
 */
+ (void)httpDataRequestByGetMethod:(NSString *)urlString
                   paramDictionary:(NSDictionary *)paramDictionary
                    TimeOutSeconds:(NSInteger)timeOutSeconds
                           request:(void (^)(BOOL, NSString *))requestFun;

@end












