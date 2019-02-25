//
//  LogTextView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "LogTextView.h"

@implementation LogTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _lineView = [UIView new];
        _lineView.backgroundColor = kColorWithHex(MCOLOR);
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
        
        CGFloat width = [UILabel labelConstrainedToSize:@"手机号" font:[UIFont fontWithName:@"" size:18]].width;
        
        _titleView = [UILabel new];
        _titleView.font =  [UIFont fontWithName:@"" size:18];
        [self addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.width.mas_equalTo(width);
            make.bottom.equalTo(self->_lineView.mas_top);
        }];
        
        _textField = [UITextField new];
        _textField.font = [UIFont fontWithName:@"" size:16];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self->_titleView);
            make.left.equalTo(self->_titleView.mas_right);
            make.right.equalTo(self);
        }];
        
    }
    return self;
}

-(void)setShowMsgBtn:(BOOL)showMsgBtn {
    _showMsgBtn = showMsgBtn;
    if (showMsgBtn) {
        _msgLabel = [UILabel new];
        _msgLabel.font =  [UIFont fontWithName:@"" size:16];
        _msgLabel.text  =@"获取验证码";
        _msgLabel.textColor = kColorWithHex(BLACKCOLOR);
        [self addSubview:_msgLabel];
        [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
        }];
        
        _msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _msgBtn.backgroundColor = [UIColor clearColor];
        [_msgBtn addTarget:self action:@selector(msgBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_msgBtn];
        [_msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_msgLabel);
        }];
        
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self->_titleView);
            make.left.equalTo(self->_titleView.mas_right);
            make.right.equalTo(self->_msgLabel.mas_left).offset(-10);
        }];
        [self layoutIfNeeded];
    }
}

- (void)msgBtnEvent:(UIButton *)sender {
    
    if (_msgEvent) {
        _msgEvent();
    }
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_msgLabel.text =@"获取验证码";
                sender.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                self->_msgLabel.text  =[NSString stringWithFormat:@"%zds",(long)timeout];
                [UIView commitAnimations];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
