//
//  UserListTableViewCell.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserListTableViewCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *leftImg;
@property (nonatomic, weak)IBOutlet UILabel *name;

@end

NS_ASSUME_NONNULL_END
