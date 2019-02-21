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
@property (nonatomic, strong)NSMutableArray *allResource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger pageSize;

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
    [self addHistoryData];
    [self upPull];
    
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}

/**
 *  刷新数据
 */
- (void)addHistoryData{
    
    kWeakSelf(self);
    _tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself reStartRequestData];
    }];
    
}

- (void)upPull {
    kWeakSelf(self);
    _tab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.page++;
        [weakself reStartRequestData];
    }];
}

- (void)reStartRequestData {
    kWeakSelf(self);
//    [AllRequest requestGetNewListBySize:_page Skip:_pageSize type:_type request:^(NSArray * _Nonnull message, NSString * _Nonnull errorMsg) {
//        [weakself updateData:message];
//    }];
}

- (void)updateData:(NSArray *)resourceData {
    [_tab.mj_header endRefreshing];
    [_tab.mj_footer endRefreshing];
    if (self.page == 0) {
        [self.allResource removeAllObjects];
    }
    [self.allResource addObjectsFromArray:[resourceData copy]];
    [_tab reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allResource.count;
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
    UserModel *model = [UserModel mj_objectWithKeyValues:self.allResource[indexPath.section]];
    UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
}


@end
