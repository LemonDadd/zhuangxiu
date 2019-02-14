//
//  UrlSetting.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#ifndef UrlSetting_h
#define UrlSetting_h
#ifndef Api_IP

//日志
#if EnvironmentalType == 2  //测试环境

#define Api_IP @"http://wunmest.com/museum/"

#else
#define Api_IP @"http://museum.sxsxjyjs.com:8061/museum/"
#endif

#endif

#define PhotoBase @"http://221.204.177.145:8061"
#define ArBase @"http://museum.sxsxjyjs.com:8061/museum_ar/main"
#

#define BaseUrl(api_IP, lastUrl) ([NSString stringWithFormat:@"%@%@", (api_IP), (lastUrl)])

#endif /* UrlSetting_h */
