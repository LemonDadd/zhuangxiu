//
//  FenleiModel.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/19.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FenleiModel : NSObject

@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, copy) NSString *condition_key;
@property (nonatomic, strong) NSArray *condition_list;

@end

@interface ConditionListModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@end

NS_ASSUME_NONNULL_END
