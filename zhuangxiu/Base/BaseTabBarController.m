//
//  BaseTabBarController.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "PicViewController.h"
#import "NewsViewController.h"
#import "UserViewController.h"
#import "BaseNavController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeViewController *home = [HomeViewController new];
    [self addChildVc:home title:@"首页" image:@"首页 (1)" selectedImage:@"首页"];
    
    PicViewController *pic = [PicViewController new];
    [self addChildVc:pic title:@"动态" image:@"动态" selectedImage:@"动态 (1)"];
    
    NewsViewController *html = [NewsViewController new];
    [self addChildVc:html title:@"资讯" image:@"资讯 (1)" selectedImage:@"资讯"];
    
    UserViewController *user = [UserViewController new];
    [self addChildVc:user title:@"我的" image:@"我的" selectedImage:@"我的 (1)"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (kSystemVersion >= 7.0) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
        childVc.tabBarItem.image = [UIImage imageNamed:image];
    }
    
    
    // 设置文字的样式
    // 设置文字的样式
    // 默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = kColorWithHex(BLACKCOLOR);
    
    // 选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = kColorWithHex(MCOLOR);
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
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
