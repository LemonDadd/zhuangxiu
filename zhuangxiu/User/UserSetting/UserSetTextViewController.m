//
//  UserSetTextViewController.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/28.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UserSetTextViewController.h"

@interface UserSetTextViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation UserSetTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.title =_isNick?@"修改昵称":@"修改我的店铺地址";
    self.edgesForExtendedLayout =UIRectEdgeNone;
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@55);
    }];
    
    self.textField = ({
        UITextField *field = [UITextField new];
        field.backgroundColor = [UIColor whiteColor];
        field.placeholder =_isNick?@"请输入姓名":@"请输入地址";
        field.clearButtonMode = UITextFieldViewModeAlways;
        [bg addSubview:field];
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@13);
            make.right.equalTo(@-13);
            make.height.equalTo(@55);
        }];
        field.font = [UIFont systemFontOfSize:15];
        field;
    });
    
    ({
        UIView *line = [UIView new];
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(bg);
            make.height.equalTo(@0.5);
        }];
        line.backgroundColor = CLineColor;
    });
    
}

- (void)rightBarButtonItemClick {
   
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
