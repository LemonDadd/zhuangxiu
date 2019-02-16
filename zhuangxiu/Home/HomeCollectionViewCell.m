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
        
        _count = [UILabel new];
        _count.textAlignment = NSTextAlignmentCenter;
        _count.font = [UIFont fontByName:@"" fontSize:22];
        _count.textColor = [UIColor whiteColor];
        //_title.text = @"【铜器】";
        [self addSubview:_count];
        [_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(kHeight(60));
        }];
        
        
        
    }
    return self;
}
@end
