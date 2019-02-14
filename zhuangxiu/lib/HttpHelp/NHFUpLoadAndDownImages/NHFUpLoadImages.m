//
//  NHFUpLoadImages.m
//  jinhe
//
//  Created by 今合网技术部 on 16/1/15.
//  Copyright © 2016年 rockontrol. All rights reserved.
//

#import "NHFUpLoadImages.h"
#import "HttpHelpBase.h"

@implementation NHFUpLoadImages

static NHFUpLoadImages *DefaultManager = nil;

+ (NHFUpLoadImages *)defaultManager {
    if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];
    return DefaultManager;
}

- (void)uploadMutableImageByUrlString:(NSString *)urlString
                               params:(NSDictionary *)params
                               images:(NSArray*)images
                           imageNames:(NSArray *)imageNames
                              process:(void(^)(CGFloat))process
                              request:(void(^)(NSString *message,
                                               BOOL success,
                                               NSString *errorMsg,
                                               BOOL error))request{
    if (images.count > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //https
        //[manager setSecurityPolicy:[HttpHelpBase customSecurityPolicy]];
        [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0;  i < images.count; i++) {
                UIImage *imageObj = images[i];
                NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                NSString *photoName = [imageNames objectAtIndex:i];
                [formData appendPartWithFileData:imageData name:photoName fileName:photoName mimeType:@"image/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (process != nil) {
                if (images.count > 1) {
                    process(1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
                } else {
                    NSInteger fractionCompleted = uploadProgress.fractionCompleted * 100;
                    CGFloat number = fractionCompleted/100.f;
                    process(number);
                }
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *data = [responseObject mj_JSONString];
            request(data, true, nil, false);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSDictionary *dic = [error userInfo];
            request(nil, false, dic[@"NSLocalizedDescription"], true);
        }];
    }
}

@end
