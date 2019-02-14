//
//  NHFDownImages.h
//  jinhe
//
//  Created by 今合网技术部 on 16/4/14.
//  Copyright © 2016年 rockontrol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownLoadRequest)(NSData *message,BOOL success,NSString *errorMsg,BOOL error);
@interface NHFDownImages : NSObject

/**
 *  获取单例
 *
 *  @return
 */
+ (NHFDownImages *)defaultManager;

/**
 下载文件

 @param urlString
 @param localFilePath
 @param params
 @param process
 @param request 
 */
- (void)downFileByUrlString:(NSString *)urlString
              localFilePath:(NSString *)localFilePath
                     params:(NSDictionary *)params
                    process:(void(^)(CGFloat))process
                    request:(DownLoadRequest)request;

@end













