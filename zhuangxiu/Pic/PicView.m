//
//  PicView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/15.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "PicView.h"
#import "PicTableViewCell.h"

@interface PicView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSMutableArray *allResource;
@end

@implementation PicView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tab = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tab.backgroundColor = kColorWithHex(0xf9f9f9);
        _tab.delegate =self;
        _tab.dataSource =self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tab];
        [self setExtraCellLineHidden:_tab];
        [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.bottom.equalTo(self).offset(-[DeviceInfo ScreenNavgationBarHeight]);
        }];
        [self addHistoryData];

        [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([PicTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
    }
    return self;
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
        [weakself reStartRequestData];
    }];
    // 马上进入刷新状态
    [_tab.mj_header beginRefreshing];
}

- (void)reStartRequestData {
    kWeakSelf(self);
    [self updateData];
//    [_modelClass requestHomerequest:^(NSString *errorMsg) {
//        if (errorMsg == nil) {
//            [weakself updateData];
//        }else {
//            [weakself.mainTableView .mj_header endRefreshing];
//            [CustomView alertMessage:errorMsg view:weakself];
//        }
//    }];
}

- (void)updateData {
    [_tab .mj_header endRefreshing];
    [_tab reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.allResource.count>indexPath.section) {
        PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
        return cell;
    }
    return UITableViewCellNone;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
}


@end
