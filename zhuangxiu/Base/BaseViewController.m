//
//  BaseViewController.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "BaseNavController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)saveShouCang:(HomeMode *)model {
    NSArray *list = [[NSUserDefaults standardUserDefaults]objectForKey: ShouCang];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:list];
    [arr addObject:model];
    NSArray *save = [NSArray arrayWithArray:arr];
    [[NSUserDefaults standardUserDefaults]setObject:save forKey:ShouCang];
    
}


- (NSArray *)getShoucang {
    NSArray *list = [[NSUserDefaults standardUserDefaults]objectForKey: ShouCang];
    return list;
}

- (void)gotoLoginViewController {
    LoginViewController *login = [LoginViewController new];
    BaseNavController *navi = [[BaseNavController  alloc]initWithRootViewController:login];
    [self presentViewController:navi animated:YES completion:nil];
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
