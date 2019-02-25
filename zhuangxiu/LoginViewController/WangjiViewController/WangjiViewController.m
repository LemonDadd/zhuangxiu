//
//  WangjiViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "WangjiViewController.h"
#import "WangjiView.h"

@interface WangjiViewController ()

@property (nonatomic, strong)WangjiView *wangji;

@end

@implementation WangjiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    _wangji = [WangjiView new];
    [self.view addSubview:_wangji];
    [_wangji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.left.equalTo(@10);
        make.width.height.mas_equalTo(30);
    }];
    
}

- (void)closeEvent {
    [self.navigationController popViewControllerAnimated:YES];
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
