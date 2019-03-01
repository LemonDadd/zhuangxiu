//
//  AppDelegate+ShareInit.m
//  Museum
//
//  Created by keneng17 on 2017/12/22.
//  Copyright © 2017年 xuannalisha. All rights reserved.
//

#import "AppDelegate+ShareInit.h"

@implementation AppDelegate (ShareInit)

- (void)ShareInit {
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5c780d94203657990d000054"];
    
    [self configUSharePlatforms];
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6aa1d736821afb60" appSecret:@"7785d6b2035c1790f6368d259a89c36a" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx6aa1d736821afb60" appSecret:@"7785d6b2035c1790f6368d259a89c36a" redirectURL:nil];
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921504649"  appSecret:@"8617309af114930bff77e7e5c19eca60" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
