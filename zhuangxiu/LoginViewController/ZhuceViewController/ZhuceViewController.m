//
//  ZhuceViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ZhuceViewController.h"
#import "ZhuceView.h"

@interface ZhuceViewController ()

@property (nonatomic, strong)ZhuceView *zhuce;

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _zhuce = [ZhuceView new];
    [self.view addSubview:_zhuce];
    [_zhuce mas_makeConstraints:^(MASConstraintMaker *make) {
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
