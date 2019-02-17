//
//  UserShopTabViewCell.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/27.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UserShopTabViewCell.h"

@implementation UserShopTabViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [UILabel new];
        label.text =@"店铺门头照";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@15);
        }];
        
        UILabel *dis = [UILabel new];
        dis.textColor = C999;
        dis.font = [UIFont systemFontOfSize:14];
        dis.text =@"(非必填,最多可上传两张)";
        [self.contentView addSubview:dis];
        [dis mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label);
            make.left.equalTo(label.mas_right);
        }];
        
        
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadBtn setBackgroundImage:[UIImage imageNamed:@"上传按钮"] forState:UIControlStateNormal];
        _uploadBtn.titleLabel.textColor = [UIColor whiteColor];
        _uploadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_uploadBtn];
        [_uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(label);
        }];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
