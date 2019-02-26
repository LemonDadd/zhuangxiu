//
//  ShoucangViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/17.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ShoucangViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeCollectionViewLayout.h"
#import "AllRequest.h"
#import "HomeMode.h"
#import "DetailViewController.h"

@interface ShoucangViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HomeCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView      *col;
@property (nonatomic, strong) NSArray *pArray;
@property (nonatomic, strong) NSMutableArray *allResource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ShoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    HomeCollectionViewLayout *flowLayout = [[HomeCollectionViewLayout alloc] init];
    flowLayout.columns = 2;
    flowLayout.columMargin =10;
    flowLayout.rowMargin = 10;
    flowLayout.delegate = self;
    
    _col = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_col setBackgroundColor:kColorWithHex(0xf6f6f8)];
    [_col setDelegate:self];
    [_col setDataSource:self];
    _col.showsVerticalScrollIndicator = NO;
    _col.showsHorizontalScrollIndicator = NO;
    //        //注册
    [_col registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [self.view addSubview:_col];
    [_col mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _col.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"暂无数据"
                                                  titleStr:@""
                                                 detailStr:@""];
    
    [self addHistoryData];
}



/**
 *  刷新数据
 */
- (void)addHistoryData{
    
    kWeakSelf(self);
    _col.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself reStartRequestData];
    }];
    // 马上进入刷新状态
    [_col.mj_header beginRefreshing];
}

- (void)upPull {
    kWeakSelf(self);
    _col.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.page++;
        [weakself reStartRequestData];
    }];
}

- (void)reStartRequestData {
    kWeakSelf(self);
    [AllRequest requestGetHomeListBySkip:_page request:^(NSArray * _Nonnull message, NSString * _Nonnull errorMsg) {
        [weakself updateData:[self getShoucang]];
    }];
}





- (void)updateData:(NSArray *)resourceData {
    [_col.mj_header endRefreshing];
    [_col.mj_footer endRefreshing];
    [_col.mj_footer setHidden:false];
    if (self.page == 0) {
        [self.allResource removeAllObjects];
        [self.allResource addObjectsFromArray:[resourceData copy]];
        [_col reloadData];
    } else {
        [self.allResource addObjectsFromArray:[resourceData copy]];
        if (self.page == 9) {
            [_col.mj_footer setHidden:true];
        }
        [_col reloadData];
        
    }
    
}

-(CGFloat)waterFlow:(HomeCollectionViewLayout *)flow heightForWidth:(CGFloat)width indexPath:(NSIndexPath *)index {
    HomeMode *model =[HomeMode mj_objectWithKeyValues:self.allResource[index.row]];
    return  [self getCellHightByCollectionModel:model andCellWidth:width];
}

//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allResource.count;
}

//每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [_col dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    HomeMode *model =[HomeMode mj_objectWithKeyValues:self.allResource[indexPath.row]];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.photo_img_m]];
    cell.count.text = model.photo_fav_nums;
    [self.view layoutIfNeeded];
    return cell;
}

//是否可以选择Item
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//选择某个Item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc= [DetailViewController new];
    vc.indx = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
}

-(CGFloat)getCellHightByCollectionModel:(HomeMode *)model andCellWidth:(CGFloat)width{
    
    return  [model.height floatValue]/[model.width integerValue]*width;
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
