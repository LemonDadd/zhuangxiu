//
//  UserNameTabViewCell.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/27.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UserNameTabViewCell.h"

@implementation UserNameTabViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _name = [UILabel new];
        _name.text = @"哈尼店主";
        _name.font = [UIFont systemFontOfSize:15];
        _name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        UILabel *label = [UILabel new];
        label.text =@"昵称";
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
