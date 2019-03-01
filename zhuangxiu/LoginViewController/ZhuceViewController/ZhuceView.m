//
//  ZhuceView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ZhuceView.h"
#import "WangjiViewController.h"
//#import <SMS_SDK/SMSSDK.h>

@implementation ZhuceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat both = 10;
        _modelClass = [RegisterViewModelClass new];
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg"];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"logo_icon"];
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
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        _titlelabel.text = [infoDictionary objectForKey:@"CFBundleDisplayName"];
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
            make.top.equalTo(self.titlelabel.mas_bottom).offset(kHeight(5*both));
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
        kWeakSelf(self)
        _msgView.msgEvent = ^{
            [weakself sendMsg];
        };
        
        
        _accView = [LogTextView new];
        _accView.titleView.text = @"用户名";
        _accView.textField.placeholder =@"请输入6-14字符";
        [self addSubview:_accView];
        [_accView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self->_phoneView);
            make.top.equalTo(self->_msgView.mas_bottom).offset(both);
        }];
        
        _passWordView = [LogTextView new];
        _passWordView.titleView.text = @"密  码";
        _passWordView.textField.placeholder =@"请输入密码";
        _passWordView.textField.secureTextEntry = YES;
        [self addSubview:_passWordView];
        [_passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.phoneView);
            make.top.equalTo(self.accView.mas_bottom).offset(both);
        }];
        
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont fontWithName:@"" size:20];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.backgroundColor = kColorWithHex(MCOLOR);
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius =5.f;
        [self addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_passWordView);
            make.top.equalTo(self->_passWordView.mas_bottom).offset(kHeight(4*both));
            make.height.mas_equalTo(kHeight(45));
        }];
        
        UILabel *login = [UILabel new];
        login.font = [UIFont fontWithName:@"" size:14];
        login.text = @"登录";
        login.textColor = kColorWithHex(0xa8a8a8);
        [self addSubview:login];
        [login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_registerBtn);
            make.top.equalTo(self->_registerBtn.mas_bottom);
        }];
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor clearColor];
        [_loginBtn addTarget:self action:@selector(loginBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(login);
        }];
        
        UILabel *wangji = [UILabel new];
        wangji.font = [UIFont fontWithName:@"" size:14];
        wangji.textColor = kColorWithHex(0xa8a8a8);
        wangji.text = @"忘记密码?";
        [self addSubview:wangji];
        [wangji mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.registerBtn);
           make.top.equalTo(self.registerBtn.mas_bottom);
        }];
        
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.backgroundColor = [UIColor clearColor];
        [_forgetBtn addTarget:self action:@selector(forgetBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forgetBtn];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wangji);
        }];
    }
    return self;
}

-(void)loginBtnEvent {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (void)forgetBtnEvent {
    WangjiViewController *vc = [WangjiViewController new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

//发送短信
- (void)sendMsg {
    if (!_phoneView.textField.text.length ) {
        [CustomView alertMessage:@"请输入手机号" view:self];
        return;
    }
    if (_phoneView.textField.text.length !=11 ) {
        [CustomView alertMessage:@"请输入正确的手机号码" view:self];
        return;
    }
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneView.textField.text zone:@"86" template:@"956846" result:^(NSError *error) {
//
//        if (!error)
//        {
//
//        }
//        else
//        {
//            // error
//        }
//    }];
}

- (void)registerBtnEvent {
    
//    [SMSSDK commitVerificationCode:_msgView.textField.text phoneNumber:_phoneView.textField.text zone:@"86" result:^(NSError *error) {
//        
//        if (!error)
//        {
//            // 验证成功
//            [self registerUser];
//        }
//        else
//        {
//            // error
//            [CustomView alertMessage:@"请输入正确的短信验证码" view:self];
//        }
//    }];
}

- (void)registerUser {
    
    if (![self validateUserName:_accView.textField.text]) {
        [CustomView alertMessage:@"用户名请输入6-14位数字、字母、汉字的组合(包括下划线)" view:self];
        return;
    }
    
    if (!_phoneView.textField.text.length ) {
        [CustomView alertMessage:@"请输入手机号" view:self];
        return;
    }
    if (_phoneView.textField.text.length !=11 ) {
        [CustomView alertMessage:@"请输入正确的手机号码" view:self];
        return;
    }
    
    if (!_accView.textField.text.length ) {
        [CustomView alertMessage:@"请输入用户名" view:self];
        return;
    }
    
    if (![self validateUserName:_accView.textField.text]) {
        [CustomView alertMessage:@"用户名请输入6-14位数字、字母、汉字的组合(包括下划线)" view:self];
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
    
    if ( !_msgView.textField.text.length) {
        [CustomView alertMessage:@"请输入手机验证码" view:self];
        return;
    }
    
    kWeakSelf(self);
    [[CustomView getInstancetype]showWaitView:@"请稍后..." byView:self];
    [_modelClass requestUserRegByUserName:_accView.textField.text passwd:_passWordView.textField.text mobile:_phoneView.textField.text validCode:_msgView.textField.text validid:@"" request:^(NSString *errorMsg) {
        [[CustomView getInstancetype]closeHUD];
        if (errorMsg == nil) {
            [CustomView alertMessage:@"注册成功" view:weakself];
            [weakself.viewController.navigationController popViewControllerAnimated:YES];
        }else {
            [CustomView alertMessage:errorMsg view:weakself];
        }
    }];
}


- (BOOL) validateUserName:(NSString *)userName
{
    NSString *regex = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{6,14}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:userName];
}


@end
