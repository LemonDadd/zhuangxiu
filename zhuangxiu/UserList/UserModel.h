//
//  UserModel.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/19.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, copy)NSString *user_base_id;
@property (nonatomic, copy)NSString *user_nickname;
@property (nonatomic, copy)NSString *user_imgfile;
@property (nonatomic, copy)NSString *user_imgfile_l;
@property (nonatomic, copy)NSString *favorite_time;

@end

NS_ASSUME_NONNULL_END
