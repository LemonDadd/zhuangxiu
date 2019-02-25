//
//  LoginView.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"
#import "LogTextView.h"
#import "LoginViewModelClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : BaseView

@property (nonatomic, strong)LoginViewModelClass *loginViewModelClass;
@property (nonatomic, strong)LogTextView *accView;
@property (nonatomic, strong)LogTextView *passWordView;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UIButton *registerBtn;
@property (nonatomic, strong)UIButton *forgetBtn;
@property (nonatomic, strong)UIImageView *logoImageView;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UIImageView *bgImageView;

@end

NS_ASSUME_NONNULL_END
