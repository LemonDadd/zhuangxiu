//
//  WangjiView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "WangjiView.h"
#import "LoginViewController.h"

@implementation WangjiView

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat both = 10;
        
        _modelClass = [ForGetViewModelClass new];
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg"];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"icon_logo"];
        _logoImageView.backgroundColor = [UIColor whiteColor];
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.layer.cornerRadius = kWidth(47.f) ;
        [self addSubview:_logoImageView];
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(kHeight(7*both));
            make.width.height.mas_equalTo(kWidth(94));
        }];
        
        _titlelabel =[UILabel new];
        _titlelabel.font = [UIFont fontWithName:@"" size:18];
        _titlelabel.textColor = kColorWithHex(BLACKCOLOR);
        _titlelabel.text = @"太原市博物馆";
        [self addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self->_logoImageView.mas_bottom).offset(15);
        }];
        
        
        _phoneView = [LogTextView new];
        _phoneView.titleView.text = @"手机号";
        _phoneView.textField.placeholder =@"请输入手机号";
        [self addSubview:_phoneView];
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_titlelabel.mas_bottom).offset(kHeight(5*both));
            make.centerX.equalTo(self);
            make.left.equalTo(self).offset(kWidth(5*both));
            make.right.equalTo(self).offset(kWidth(-5*both));
            make.height.mas_equalTo(kHeight(4*both));
        }];
        
        _msgView = [LogTextView new];
        _msgView.showMsgBtn = YES;
        _msgView.titleView.text = @"验证码";
        [self addSubview:_msgView];
        [_msgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self->_phoneView);
            make.top.equalTo(self->_phoneView.mas_bottom).offset(both);
        }];
        
        _passWordView = [LogTextView new];
        _passWordView.titleView.text = @"新密码";
        _passWordView.textField.placeholder =@"请输入新密码";
        _passWordView.textField.secureTextEntry = YES;
        [self addSubview:_passWordView];
        [_passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self->_phoneView);
            make.top.equalTo(self->_msgView.mas_bottom).offset(both);
        }];
        
        _passNewView = [LogTextView new];
        _passNewView.titleView.text = @"确  认";
        _passNewView.textField.placeholder =@"请重复密码";
        _passNewView.textField.secureTextEntry = YES;
        [self addSubview:_passNewView];
        [_passNewView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self->_phoneView);
            make.top.equalTo(self->_passWordView.mas_bottom).offset(both);
        }];
        
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(registerBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.titleLabel.font = [UIFont fontWithName:@"" size:20];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okBtn.backgroundColor = kColorWithHex(MCOLOR);
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.cornerRadius =5.f;
        [self addSubview:_okBtn];
        [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_passNewView);
            make.top.equalTo(self->_passNewView.mas_bottom).offset(kHeight(4*both));
            make.height.mas_equalTo(kHeight(45));
        }];
        
    }
    return self;
}

- (void)registerBtnEvent {
    if (!_phoneView.textField.text.length ) {
        [CustomView alertMessage:@"请输入手机号" view:self];
        return;
    }
    if (_phoneView.textField.text.length !=11 ) {
        [CustomView alertMessage:@"请输入正确的手机号码" view:self];
        return;
    }
    if ( !_passWordView.textField.text.length) {
        [CustomView alertMessage:@"请输入密码" view:self];
        return;
    }
    if ( _passWordView.textField.text.length<6) {
        [CustomView alertMessage:@"请输入最少六个字符的密码" view:self];
        return;
    }
    
    if (!_passNewView.textField.text.length ) {
        [CustomView alertMessage:@"请输入用户名" view:self];
        return;
    }
    
    if ( !_msgView.textField.text.length) {
        [CustomView alertMessage:@"请输入手机验证码" view:self];
        return;
    }
    kWeakSelf(self);
    [[CustomView getInstancetype]showWaitView:@"请稍后..." byView:self];
    [_modelClass requestResetPasswordBypasswd:_passNewView.textField.text mobile:_phoneView.textField.text validCode:_msgView.textField.text validid:@"" request:^(NSString *errorMsg) {
        [[CustomView getInstancetype]closeHUD];
        if (errorMsg == nil) {
            [CustomView alertMessage:@"注册成功" view:weakself];
            [weakself loginBtnEvent];
        }else {
            [CustomView alertMessage:errorMsg view:weakself];
        }
    }];
}

-(void)loginBtnEvent {
    for (UIViewController* vc in self.viewController.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            [self.viewController.navigationController popToViewController:vc animated:YES];
        }
    }
}

@end
