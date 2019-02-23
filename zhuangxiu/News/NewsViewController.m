//
//  NewsViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsView.h"
#import "ClassifyViewController.h"
@interface NewsViewController ()<ClassifyViewControllerDelgate>

@property (nonatomic, strong)NewsView *news;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _news = [NewsView new];
    _news.indx =0;
    [self.view addSubview:_news];
    [_news mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leimupinleifenleileibie"] style:UIBarButtonItemStylePlain target:self action:@selector(right)];
}

- (void)right {
    ClassifyViewController *vc = [ClassifyViewController new];
    vc.delegate =self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)classifyViewControllerdidClick:(NSString *)tip {
    NSInteger indx = 0;
    self.title = tip;
    if ([tip isEqualToString:@"家居设计"]) {
        indx = 0;
    }
    if ([tip isEqualToString:@"家饰搭配"]) {
        indx = 1;
    }
    if ([tip isEqualToString:@"装修指南"]) {
        indx = 2;
    }
    if ([tip isEqualToString:@"装修风水"]) {
        indx = 3;
    }
    
    _news.indx= indx;
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
