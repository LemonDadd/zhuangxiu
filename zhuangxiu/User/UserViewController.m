//
//  UserViewController.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserViewController.h"
#import "UserView.h"
#import "UserSettingViewController.h"

@interface UserViewController ()

@property (nonatomic, strong)UserView *user;

@end

@implementation UserViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_user reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _user = [UserView new];
    [self.view addSubview:_user];
    [_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
