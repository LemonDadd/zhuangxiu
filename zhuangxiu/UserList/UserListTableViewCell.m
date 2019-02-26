//
//  UserListTableViewCell.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserListTableViewCell.h"

@implementation UserListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftImg.layer.masksToBounds = YES;
    self.leftImg.layer.cornerRadius = 20.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
