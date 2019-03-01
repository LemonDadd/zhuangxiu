//
//  UserSettingViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserSettingViewController.h"
#import "UserHeaderTabViewCell.h"
#import "UserNameTabViewCell.h"
#import "UserPhoneTabViewCell.h"
#import "UserAddressTabViewCell.h"
#import "UserShopTabViewCell.h"
#import "UserShopImageTabViewCell.h"
#import "UserSetTextViewController.h"
#import "UploadPicViewController.h"
#import "ACActionSheet.h"
#import "JJImagePicker.h"
#import "UpdatePassViewController.h"

@interface UserSettingViewController ()<UITableViewDelegate,UITableViewDataSource,ACActionSheetDelegate,UserSetTextViewControllerDelegate>

@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSMutableArray *shopImages;
@property (nonatomic, strong)UIButton *bottomButton;
@property (nonatomic, copy)NSString *address;

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"设置";
    
    _tab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tab.delegate =self;
    _tab.dataSource =self;
    _tab.estimatedRowHeight =50;
    _tab.estimatedSectionFooterHeight=0;
    _tab.estimatedSectionHeaderHeight =0;
    _tab.separatorColor =kColorWithHex(LINECOLOR);
    [self.view addSubview:_tab];
    [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setExtraCellLineHidden:_tab];
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:kColorWithHex(MCOLOR)];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.f;
    [footer addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footer);
        make.left.equalTo(@45);
        make.right.equalTo(@-45);
        make.height.equalTo(@40);
    }];
    _tab.tableFooterView = footer;
}

- (void)tuichu {
    [[UserInfoClass getUserInfoClass]clearUserInfoClass];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
//    [UserViewControllerRequest requestgetAuerbachByuserId:[Global sharedInstance].id request:^(Global * _Nonnull message, NSString * _Nonnull errorMsg) {
//        if (message) {
//            if (message.shopFaceImage.count) {
//                [self.shopImages addObjectsFromArray:message.shopFaceImage];
//            }
//            [self.tab reloadData];
//            if (message.isboss == 0) {
//                [self.bottomButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
//            } else if (message.isboss == 1) {
//                [self.bottomButton setImage:[UIImage imageNamed:@"审核成功"] forState:UIControlStateNormal];
//            } else {
//                [self.bottomButton setImage:[UIImage imageNamed:@"审核中"] forState:UIControlStateNormal];
//            }
//        }
//    }];
}

#pragma mark -tabviewDelgate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UserHeaderTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHeaderTabViewCell"];
        if (cell == nil) {
            cell = [[UserHeaderTabViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserHeaderTabViewCell"];
        }
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PhotoBase,[UserInfoClass getUserInfoClass].photo]] placeholderImage:[UIImage imageNamed:@"默认"]];
        return cell;
    }
    if (indexPath.section == 1) {
        UserNameTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserNameTabViewCell"];
        if (cell == nil) {
            cell = [[UserNameTabViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserNameTabViewCell"];
        }
        cell.name.text =[UserInfoClass getUserInfoClass].username;
        return cell;
    }
    
    if (indexPath.section == 2) {
        UserPhoneTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPhoneTabViewCell"];
        if (cell == nil) {
            cell = [[UserPhoneTabViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserPhoneTabViewCell"];
        }
        cell.phone.text =[UserInfoClass getUserInfoClass].mobile;
        return cell;
    }
    
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"修改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    
    return [UITableViewCell new];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UploadPicViewController *vc = [UploadPicViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1) {
        UserSetTextViewController *vc= [UserSetTextViewController new];
        vc.delegate =self;
        vc.isNick = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
        UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UpdatePassViewController *vc =[main instantiateViewControllerWithIdentifier:@"UpdatePassViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)uploadShopImage {
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet show];
}

#pragma mark - ACActionSheet delegate
- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[JJImagePicker sharedInstance] showImagePickerWithType:JJImagePickerTypeCamera InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
            [self.shopImages addObject:image];
            [self.tab reloadData];
        }];
    }
    if (buttonIndex == 1) {
        [[JJImagePicker sharedInstance] showImagePickerWithType:JJImagePickerTypePhoto InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
            [self.shopImages addObject:image];
            [self.tab reloadData];
        }];
    }
}

#pragma mark - UserSetTextViewControllerDelegate

-(void)saveTextWithStr:(NSString *)text isNick:(BOOL)nick {
    if (!nick) {
        _address = text;
    }
    [_tab reloadData];
}

#pragma mark - load

-(NSMutableArray *)shopImages {
    if (!_shopImages ) {
        _shopImages = [NSMutableArray array];
    }
    return _shopImages;
}

- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
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
