//
//  ZhuceView.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"
#import "LogTextView.h"
#import "RegisterViewModelClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhuceView : BaseView

@property (nonatomic, strong)LogTextView *phoneView;//手机号
@property (nonatomic, strong)LogTextView *passWordView;//密码
@property (nonatomic, strong)LogTextView *msgView;//验证码
@property (nonatomic, strong)LogTextView *accView;//用户名
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UIButton *registerBtn;
@property (nonatomic, strong)UIButton *forgetBtn;
@property (nonatomic, strong)UIImageView *logoImageView;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)RegisterViewModelClass *modelClass;

@end

NS_ASSUME_NONNULL_END
