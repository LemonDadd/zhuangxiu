//
//  DetailTopView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "DetailTopView.h"
#import "UserModel.h"
#import "UserListViewController.h"
#import "BaseViewController.h"

@interface DetailTopView ()

@property (nonatomic, strong)NSArray *userList;

@end

@implementation DetailTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        
        _shoucangButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shoucangButton addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shoucangButton];
        [_shoucangButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.center.equalTo(self);
            make.height.width.equalTo(@20);
        }];
        
        _contentV = [UIView new];
        [self addSubview:_contentV];
        [_contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self.shoucangButton);
            make.height.equalTo(@30);
            make.right.equalTo(self.shoucangButton.mas_left).offset(-10);
        }];
        
    }
    return self;
}

- (void)shoucang:(UIButton *)sender {
    _model.shoucang = !_model.shoucang;
    [self setbuttonImage];
}

- (void)setbuttonImage {
    if (_model.shoucang) {
        [_shoucangButton setImage:[UIImage imageNamed:@"xihuan-3"] forState:UIControlStateNormal];
        [(BaseViewController *)self.viewController saveShouCang:_model];
    } else {
         [_shoucangButton setImage:[UIImage imageNamed:@"xihuan-2"] forState:UIControlStateNormal];
         [(BaseViewController *)self.viewController deleteShouCang:_model];
    }
}

- (void)setModel:(HomeMode *)model {

    _model = model;
    [self setbuttonImage];
    for (UIView *v in _contentV.subviews) {
        [v  removeFromSuperview];
    }
//    NSString *upath = [[NSBundle mainBundle] pathForResource:@"ren" ofType:@"plist"];
//    NSArray *uArray = [NSArray arrayWithContentsOfFile:upath];
//    
//    NSMutableArray *list = [NSMutableArray array];
//    for (int i=0; i<[model.photo_fav_nums integerValue]; i++) {
//        int x = arc4random() % uArray.count;
//        [list addObject:uArray[x]];
//    }
//    
//    _userList = [NSArray arrayWithArray:list];
    
    NSInteger count =model.userList.count >5?5:model.userList.count;
    
    UIImageView *last = nil;
    for (int i=0; i<count; i++) {
        UIImageView *img = [UIImageView new];
        UserModel *user = [UserModel mj_objectWithKeyValues:model.userList[i]];
        [img sd_setImageWithURL:[NSURL URLWithString:user.user_imgfile]];
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = 15.f;
        [_contentV addSubview:img];
        if (last == nil) {
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(self.contentV);
                make.width.equalTo(img.mas_height);
            }];
        } else {
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.width.equalTo(last);
                make.left.equalTo(last.mas_right).offset(5);
            }];
        }
        last = img;
    }
    
    if (count == 5) {
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"gengduo-2"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [_contentV addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(last);
            make.left.equalTo(last.mas_right).offset(5);
        }];
    }
    
}

- (void)more {
    UserListViewController *vc= [UserListViewController new];
    vc.listArray = _model.userList;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
