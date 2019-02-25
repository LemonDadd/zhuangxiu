//
//  GuanyuViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "GuanyuViewController.h"
#import "GuanyuView.h"

@interface GuanyuViewController ()

@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"关于我们";
    GuanyuView *view = [GuanyuView new];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
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
