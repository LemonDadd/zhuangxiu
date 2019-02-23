//
//  UserTopTableViewCell.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTopTableViewCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *bg;
@property (nonatomic, weak)IBOutlet UIImageView *userImg;
@property (nonatomic, weak)IBOutlet UILabel *user;

@end

NS_ASSUME_NONNULL_END
