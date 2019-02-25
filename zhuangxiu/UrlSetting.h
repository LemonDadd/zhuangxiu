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

/**
 *  发送验证码
 *
 *  @param Api_IP
 *  @param @"api/common/sendValidCode"
 *
 *  @return
 */
#define SendValidCodeBaseUrl BaseUrl(Api_IP, @"api/common/sendValidCode")

/**
 *  上传图片
 *
 *  @param Api_IP
 *  @param @"api/common/upload"
 *
 *  @return
 */
#define UploadBaseUrl BaseUrl(Api_IP, @"api/common/upload")

/**
 *  登录接口
 *
 *  @param Api_IP
 *  @param @"api/user/passwordLogin"
 *
 *  @return
 */
#define LoginBaseUrl BaseUrl(Api_IP, @"api/user/passwordLogin")

/**
 *  注册接口
 *
 *  @param Api_IP
 *  @param @"api/user/reg"
 *
 *  @return
 */
#define UserRegBaseUrl BaseUrl(Api_IP, @"api/user/reg")

/**
 *  重置密码接口
 *
 *  @param Api_IP
 *  @param @"api/user/resetPassword"
 *
 *  @return
 */
#define ResetPasswordBaseUrl BaseUrl(Api_IP, @"api/user/resetPassword")

/**
 *  修改绑定手机
 *
 *  @param Api_IP
 *  @param @"api/user/updateMobile"
 *
 *  @return
 */
#define UpdateMobileBaseUrl BaseUrl(Api_IP, @"api/user/updateMobile")

/**
 *  修改密码
 *
 *  @param Api_IP
 *  @param @"api/user/updatePassword"
 *
 *  @return
 */
#define UpdatePasswordBaseUrl BaseUrl(Api_IP, @"api/user/updatePassword")


#endif /* UrlSetting_h */
