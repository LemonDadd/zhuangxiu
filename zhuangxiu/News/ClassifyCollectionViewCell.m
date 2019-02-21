//
//  ClassifyCollectionViewCell.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ClassifyCollectionViewCell.h"

@implementation ClassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [UIImageView new];
        [self addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _title = [UILabel new];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont fontByName:@"" fontSize:25];
        _title.textColor = [UIColor whiteColor];
        //_title.text = @"【铜器】";
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(kHeight(60));
        }];
        
        
        
    }
    return self;
}

@end
