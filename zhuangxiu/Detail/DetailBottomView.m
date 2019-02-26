//
//  DetailBottomView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "DetailBottomView.h"

@implementation DetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        
        _name = [UILabel new];
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont systemFontOfSize:16];
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@10);
            make.right.equalTo(self).offset(-10);
        }];
        
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor =kColorWithHex(GRAYCOLOR);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-20);
        }];
    }
    return self;
}

@end
