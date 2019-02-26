//
//  DetailScrView.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "DetailScrView.h"

@implementation DetailScrView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.clipsToBounds = YES;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        [_imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setContentX:(CGFloat)contentX{
    
    _contentX = contentX;
    _imageView.frame = CGRectMake(contentX, 0, self.frame.size.width, self.frame.size.height);
    
}

@end
