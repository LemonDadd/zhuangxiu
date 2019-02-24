//
//  DetailTopView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "DetailTopView.h"

@interface DetailTopView ()

@property (nonatomic, strong)UIView *contentView;

@end

@implementation DetailTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        _name = [UILabel new];
        _name.font = [UIFont systemFontOfSize:16];
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@10);
            make.right.equalTo(self).offset(-10);
        }];
        
        _detailLabel = [UILabel new];
        _detailLabel.numberOfLines = 2;
        _detailLabel.textColor =kColorWithHex(GRAYCOLOR);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).offset(5);
        }];
        
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.name);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
            make.height.equalTo(@40);
            make.bottom.equalTo(self).offset(-10);
        }];
        
    }
    return self;
}

@end
