//
//  UserModelClass.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/3/2.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserModelClass.h"

@implementation UserModelClass

- (void)updatePhotoImagesByImags:(UIImage *)img
                         Request:(void(^)(NSString *errorMsg))request {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    
    [AllRequest uploadImagesByImags:@[img] ImagNames:@[fileName] Request:^(NSString *message, NSString *errorMsg) {
        if (message) {
            self.photoStr = message;
            [AllRequest requestUpdatePhotoByPhoto:message request:^(NSString *message, BOOL success, NSString *errorMsg, BOOL error) {
                if (success && !error) {
                    request(nil);
                }else {
                    request(errorMsg);
                }
            }];
        }else {
            request(errorMsg);
        }
    }];
}

@end
