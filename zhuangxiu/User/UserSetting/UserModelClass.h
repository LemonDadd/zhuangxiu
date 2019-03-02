//
//  UserModelClass.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/3/2.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModelClass : NSObject

@property (nonatomic, copy)NSString *photoStr;

- (void)updatePhotoImagesByImags:(UIImage *)img
                         Request:(void(^)(NSString *errorMsg))request;

@end

NS_ASSUME_NONNULL_END
