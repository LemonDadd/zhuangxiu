//
//  WangjiView.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"
#import "LogTextView.h"
#import "ForGetViewModelClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface WangjiView : BaseView

@property (nonatomic, strong)LogTextView *phoneView;//手机号
@property (nonatomic, strong)LogTextView *passWordView;//密码
@property (nonatomic, strong)LogTextView *msgView;//验证码
@property (nonatomic, strong)LogTextView *passNewView;//用户名
@property (nonatomic, strong)UIButton *okBtn;
@property (nonatomic, strong)UIImageView *logoImageView;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)ForGetViewModelClass *modelClass;

@end

NS_ASSUME_NONNULL_END
