//
//  UserAddressTabViewCell.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/27.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UserAddressTabViewCell.h"

@implementation UserAddressTabViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _address = [UILabel new];
        _address.font = [UIFont systemFontOfSize:15];
        _address.textColor = C999;
        [self.contentView addSubview:_address];
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        UILabel *label = [UILabel new];
        label.text =@"我的店铺地址";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(@15);
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
