//
//  HtmlViewController.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "HtmlViewController.h"
#import <WebKit/WebKit.h>
#import <UShareUI/UShareUI.h>
#import "NSString+BHURLHelper.h"

@interface HtmlViewController ()<WKNavigationDelegate>
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)WKWebView *web;
@end

@implementation HtmlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor =[UIColor colorWithHexString:@"0xd8d8d8"];
    [self.view addSubview:_bottomView];
    
    if (self.showBottom) {
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@44);
        }];
        
        NSArray *images = @[@"zuo",@"you",@"shuaxin",@"zhuye"];
        NSMutableArray *btns = [NSMutableArray new];
        for (int i=0; i<images.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            [_bottomView addSubview:btn];
            [btns addObject:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnSeleted:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
        [btns mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.bottomView);
        }];
    } else {
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@0);
        }];
    }
    
    
    
    
    _web = [WKWebView new];
    _web.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    _web.scrollView.bounces = NO;
    [_web loadRequest:request];
    [self.view addSubview:_web];
    [_web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void)btnSeleted:(UIButton *)sender {
    if (sender.tag == 0) {
        if (_web.canGoBack) {
            [_web goBack];
        }
    } else if (sender.tag ==1) {
        if (_web.canGoForward) {
            [_web goForward];
        }
    } else if (sender.tag == 2) {
        [_web reload];
    } else if (sender.tag == 3) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [_web loadRequest:request];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *path = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    if ([path hasPrefix:@"unsafe:com.hpyshark.homer://detail"]) {
        NSArray *arr = [path componentsSeparatedByString:@"?"];
        HtmlViewController *vc= [HtmlViewController new];
        vc.url = [NSString stringWithFormat:@"http://api.homer.app887.com/article.html?%@",arr.lastObject];
        [self.navigationController pushViewController:vc animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([path hasPrefix:@"unsafe:com.hpyshark.homer://share"]){
        NSLog(@"分享:%@",path);
        //type:3wx  2pyq  1weibo
        if ([path containsString:@"&type=3"]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession url:path];
        }
        if ([path containsString:@"&type=2"]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine url:path];
        }
        if ([path containsString:@"&type=1"]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina url:path];
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%@",path);

}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType url:(NSString *)url
{
    
    NSDictionary *dict =  [url parseURLParameters];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:dict[@"title"] descr:@"" thumImage:[UIImage imageNamed:@"logo_icon"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:@"http://api.homer.app887.com/article.html?id=%@&type=%ld",dict[@"url"],(long)platformType];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
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
