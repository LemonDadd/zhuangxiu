//
//  UserTopTableViewCell.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserTopTableViewCell.h"

@implementation UserTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *HUDView = [[UIVisualEffectView alloc] initWithEffect:blur];
    HUDView.alpha = 0.8f;
    HUDView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/2);
    [self.bg addSubview:HUDView];
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = 40.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
