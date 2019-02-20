//
//  NewsView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NewsView.h"
#import "NewsHTableViewCell.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
@interface NewsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSMutableArray *allResource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, copy)NSString *type;

@end

@implementation NewsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageSize =10;
        _tab = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tab.backgroundColor = kColorWithHex(0xf9f9f9);
        _tab.delegate =self;
        _tab.dataSource =self;
        [self addSubview:_tab];
        [self setExtraCellLineHidden:_tab];
        [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.bottom.equalTo(self).offset(-[DeviceInfo ScreenNavgationBarHeight]);
        }];
        
        
        [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
        [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([NewsHTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"NewsHTableViewCell"];
        [self addHistoryData];
        [self upPull];
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
    [AllRequest requestGetNewListBySize:_page Skip:_pageSize type:_type request:^(NSArray * _Nonnull message, NSString * _Nonnull errorMsg) {
       [weakself updateData:message];
    }];
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
        NewsModel *model = [NewsModel mj_objectWithKeyValues:self.allResource[indexPath.section]];
        if (_indx == 0||_indx == 1) {
            NewsHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsHTableViewCell"];
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:model.imglink]];
            cell.shouc.text = [NSString stringWithFormat:@"%ld",(long)model.likecount];
            cell.kan.text = [NSString stringWithFormat:@"%ld",(long)model.readarts];
            cell.fenlei.text = model.titlespelling;
            cell.name.text = model.title;
            return cell;
        } else {
            NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell"];
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:model.imglink]];
            cell.shouc.text = [NSString stringWithFormat:@"%ld",(long)model.likecount];
            cell.kan.text = [NSString stringWithFormat:@"%ld",(long)model.readarts];
            cell.name.text = model.title;
            return cell;
        }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
}


-(void)setIndx:(NSInteger)indx {
    _indx = indx;
    switch (indx) {
        case 0:
            _type = @"家居设计";
            break;
        case 1:
            _type = @"家饰搭配";
            break;
        case 2:
            _type = @"装修指南";
            break;
        case 3:
            _type = @"装修风水";
            break;
        default:
            break;
    }
    // 马上进入刷新状态
    [_tab.mj_header beginRefreshing];
}

-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
}

@end
