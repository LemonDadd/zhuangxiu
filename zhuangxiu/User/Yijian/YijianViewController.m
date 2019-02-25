//
//  YijianViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "YijianViewController.h"
#import "LogTextView.h"

@interface YijianViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeHolderLabel;
@property(strong,nonatomic)UILabel *numLabel;
@property(strong,nonatomic)UIButton *saveBtn;
@property (strong,nonatomic)LogTextView *phoneLabel;

@end

@implementation YijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _textView =[[UITextView alloc]init];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = kColorWithHex(MCOLOR).CGColor;
    _textView.layer.borderWidth = 2;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@80);
        make.height.equalTo(@150);
    }];
    
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
    _placeHolderLabel.text = @"请输入意见反馈";
    _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_placeHolderLabel];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textView.width-65, _textView.height-30, 60, 30)];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = @"0/150";
    _numLabel.font = [UIFont systemFontOfSize:12];
    _numLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_numLabel];
    
    
    _phoneLabel = [LogTextView new];
    _phoneLabel.titleView.text = @"手  机";
    _phoneLabel.textField.placeholder =@"请输入手机号(选填)";
    [self.view addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(kWidth(10));
        make.right.equalTo(self).offset(kWidth(-10));
        make.height.mas_equalTo(kHeight(50));
    }];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 5;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:kColorWithHex(MCOLOR)];
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
}

-(void)saveAction
{
    NSLog(@"------------->意见反馈");
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [_textView becomeFirstResponder];
    //    NSLog(@"文本开始编辑");
    _placeHolderLabel.hidden = YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    //    NSLog(@"文本在变化");
    _numLabel.text = [NSString stringWithFormat:@"%d/150",150-(int)textView.text.length];
    
    if (textView.text.length >= 150) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的字数超过150个字了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        _textView.text = [textView.text substringToIndex:20];
        _numLabel.text = [NSString stringWithFormat:@"0/20"];
    }else if (textView.text.length ==0){
        _placeHolderLabel.hidden = NO;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex ==1) {
        NSLog(@"确定");
    }else{
        NSLog(@"取消");
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    //     NSLog(@"文本结束编辑");
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
