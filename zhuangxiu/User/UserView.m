//
//  UserView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserView.h"
#import "UserTopTableViewCell.h"
#import "GuanyuViewController.h"
#import "YijianViewController.h"
#import "ShoucangViewController.h"
#import "HtmlViewController.h"
#import "UserSettingViewController.h"
#import "LoginViewController.h"
#import "BaseViewController.h"

@interface UserView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSArray *userArray;

@end

@implementation UserView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tab = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tab.backgroundColor = kColorWithHex(0xf9f9f9);
        _tab.delegate =self;
        _tab.dataSource =self;
        [self addSubview:_tab];
        [self setExtraCellLineHidden:_tab];
        [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.bottom.equalTo(self).offset(-[DeviceInfo ScreenNavgationBarHeight]);
        }];
        
        [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([UserTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"UserTopTableViewCell"];
        _userArray = @[@"我的收藏",@"意见反馈",@"关于我们",@"去评分",@"更多服务",@"清除缓存"];
    }
    return self;
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _userArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UserTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTopTableViewCell"];
        if ([UserInfoClass getUserInfoClass]) {
            [cell.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PhotoBase,[UserInfoClass getUserInfoClass].photo]] placeholderImage:[UIImage imageNamed:@"默认"]];
            cell.user.text =[UserInfoClass getUserInfoClass].username;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text =_userArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        return cell;
    }
    
    return UITableViewCellNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ([UserInfoClass getUserInfoClass]) {
            UserSettingViewController *vc = [UserSettingViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else {
            [(BaseViewController *)self.viewController  gotoLoginViewController];
        }
    } else {
        if (indexPath.row == 0) {
            if ([UserInfoClass getUserInfoClass]) {
                ShoucangViewController *vc = [ShoucangViewController new];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            } else {
                [(BaseViewController *)self.viewController  gotoLoginViewController];
            }
        } else if (indexPath.row ==1){
            if ([UserInfoClass getUserInfoClass]) {
                YijianViewController *vc = [YijianViewController new];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            } else {
                [(BaseViewController *)self.viewController  gotoLoginViewController];
            }
            
        } else if (indexPath.row ==2){
            GuanyuViewController *vc = [GuanyuViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row ==3){
            NSString *str = [NSString stringWithFormat:  @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=123"];
            [[UIApplication  sharedApplication] openURL:[NSURL URLWithString:str]];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
//
//            }];
        } else if (indexPath.row ==4){
            HtmlViewController *vc = [HtmlViewController new];
            vc.url = @"https://m.to8to.com/tubatu/decorateStyle.html?ptag=2_1_1_2324";
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row ==5){
           //q清除缓存
            //清除缓存
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"缓存大小为%@,确定要清理缓存吗？",[self getCache]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[SDImageCache sharedImageCache]clearMemory];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            
            [self.viewController presentViewController:alertController animated:YES completion:nil];
        } else if (indexPath.row ==6){
            UserSettingViewController *vc = [UserSettingViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (NSString *)getCache {
    unsigned long long size = [SDImageCache sharedImageCache].getSize;
    //fileSize是封装在Category中的。
    
    //CustomFile + SDWebImage 缓存
    
    //设置文件大小格式
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) {
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        sizeText = [NSString stringWithFormat:@"%lluB", size];
    }
    return sizeText;
}


- (void)reloadData {
    [_tab reloadData];
}

@end
