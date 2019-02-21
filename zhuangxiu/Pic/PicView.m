//
//  PicView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/15.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "PicView.h"
#import "PicTableViewCell.h"
#import "UserModel.h"
#import "DetailViewController.h"

@interface PicView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSMutableArray *allResource;
@property (nonatomic, strong)NSArray *picArray;
@property (nonatomic, strong)NSMutableArray *userArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
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
     
        
        [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([PicTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"pic"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shuju" ofType:@"plist"];
        _picArray = [NSArray arrayWithContentsOfFile:path];
        NSString *upath = [[NSBundle mainBundle] pathForResource:@"ren" ofType:@"plist"];
        NSArray *uArray = [NSArray arrayWithContentsOfFile:upath];
        
        _userArray = [NSMutableArray array];
        NSUInteger itemsRemaining = uArray.count;
        int j = 0;
        while(itemsRemaining) {
            NSRange range = NSMakeRange(j, MIN(10, itemsRemaining));
            NSArray *subLogArr = [uArray subarrayWithRange:range];
            [_userArray addObject:subLogArr];
            itemsRemaining-=range.length;
            j+=range.length;
        }
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
    // 马上进入刷新状态
    [_tab.mj_header beginRefreshing];
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
    [AllRequest requestGetPicListBySize:_page Skip:_pageSize request:^(NSArray * _Nonnull message, NSString * _Nonnull errorMsg) {
        if (weakself.page == weakself.userArray.count) {
            return;
        }
        NSMutableArray *obj = [NSMutableArray array];
        NSArray *arr = weakself.userArray[weakself.page];
        for (NSDictionary *dic in arr) {
            UserModel *user = [UserModel mj_objectWithKeyValues:dic];
            int x = arc4random() % weakself.picArray.count;
            NSString *str = weakself.picArray[x];
            NSArray *p = [JsonToDic dictionaryWithJsonString:str];
            int y = arc4random() % p.count;
            HomeMode *h = [HomeMode mj_objectWithKeyValues:p[y]];
            user.model =h;
            [obj addObject:user];
            
        }
        [self updateData:[NSArray arrayWithArray:obj]];
    }];
}

- (void)updateData:(NSArray *)resourceData {
    [_tab.mj_header endRefreshing];
    [_tab.mj_footer endRefreshing];
    [_tab.mj_footer setHidden:false];
    if (self.page == 0) {
        [self.allResource removeAllObjects];
        [self.allResource addObjectsFromArray:[resourceData copy]];
        [_tab reloadData];
    } else {
        [self.allResource addObjectsFromArray:[resourceData copy]];
        if (self.page == _userArray.count) {
            [_tab.mj_footer setHidden:true];
        }
        [_tab reloadData];
        
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allResource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *user = self.allResource[indexPath.section];
    PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:user.user_imgfile]];
    cell.name.text = user.user_nickname;
    cell.time.text = user.favorite_time;
    [cell.topImage sd_setImageWithURL:[NSURL URLWithString:user.model.photo_img_l]];
    cell.kan.text = user.model.photo_fav_nums;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc= [DetailViewController new];
    vc.indx = indexPath.row;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
}

@end
