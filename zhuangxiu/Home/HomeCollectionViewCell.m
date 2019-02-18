//
//  HomeCollectionViewCell.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/16.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [UIImageView new];
        [self addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _shouc = [UIImageView new];
        [self addSubview:_shouc];
        [_shouc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.image).offset(-10);
            make.left.equalTo(self.image).offset(10);
            make.width.height.equalTo(@15);
        }];
        
        _count = [UILabel new];
        _count.textAlignment = NSTextAlignmentCenter;
        _count.font = [UIFont fontByName:@"" fontSize:12];
        _count.textColor = [UIColor whiteColor];
        _count.text = @"10";
        [self addSubview:_count];
        [_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shouc);
            make.left.equalTo(self.shouc.mas_right).offset(8);
        }];
        
        
        
    }
    return self;
}
@end
