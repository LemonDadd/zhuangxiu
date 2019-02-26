//
//  UserListViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/15.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListTableViewCell.h"
#import "UserModel.h"

@interface UserListViewController  ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)BaseTableView *tab;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户列表";
    _tab = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tab.backgroundColor = kColorWithHex(0xf9f9f9);
    _tab.delegate =self;
    _tab.dataSource =self;
    [self.view addSubview:_tab];
    [self setExtraCellLineHidden:_tab];
    [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.bottom.equalTo(self).offset(-[DeviceInfo ScreenNavgationBarHeight]);
    }];
    
    
    [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([UserListTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"UserListTableViewCell"];
    
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *model = [UserModel mj_objectWithKeyValues:_listArray[indexPath.section]];
    UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListTableViewCell"];
    cell.name.text = model.user_nickname;
    [cell.leftImg sd_setImageWithURL:[NSURL URLWithString:model.user_imgfile_l]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
