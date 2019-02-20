//
//  NewsViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsView.h"
@interface NewsViewController ()

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
