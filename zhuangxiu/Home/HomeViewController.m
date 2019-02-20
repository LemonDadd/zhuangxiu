//
//  HomeViewController.m
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "HomeViewController.h"
#import "MoreDropDownMenu.h"
#import "HomeCollectionViewCell.h"
#import "HomeCollectionViewLayout.h"
#import "HtmlViewController.h"
#import "HomeMode.h"
#import "DetailViewController.h"

@interface HomeViewController ()<MoreDropDownMenuDataSource,MoreDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate,HomeCollectionViewLayoutDelegate>

@property (nonatomic, strong) NSArray               *cates;
@property (nonatomic, strong) NSArray               *states;
@property (nonatomic, strong) NSArray               *sorts;
@property (nonatomic, strong) MoreDropDownMenu       *menu;
@property (nonatomic, strong) UICollectionView      *col;
@property (nonatomic, strong) NSArray *pArray;
@property (nonatomic, strong) NSMutableArray *allResource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cates = @[@"空间",@"风格",@"颜色",@"局部"];
    
    _menu = [[MoreDropDownMenu alloc] initWithOrigin:CGPointMake(0,64) andHeight:49.5];
    _menu.delegate = self;
    _menu.dataSource = self;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    [self.view addSubview:_menu];
    _menu.finishedBlock=^(MoreIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    [_menu selectIndexPath:[MoreIndexPath indexPathWithCol:1 row:1]];
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
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.menu.mas_bottom);
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shuju" ofType:@"plist"];
    _pArray = [NSArray arrayWithContentsOfFile:path];
    [self addHistoryData];
    [self upPull];
}

- (void)gotoWebView:(NSString *)url {
    HtmlViewController *vc = [HtmlViewController new];
    vc.url = url;
    vc.showBottom = YES;
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
}


- (void)dismiss{
    //self.classifys = @[@"美食",@"今日新单",@"电影"];
    [_menu hideMenu];
}




#pragma mark - MoreDropDownMenuDataSource and MoreDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(MoreDropDownMenu *)menu{
    return self.cates.count;
}

- (NSInteger)menu:(MoreDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    if (column == 0) {
        return self.cates.count;
    }else if (column == 1){
        return self.states.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(MoreDropDownMenu *)menu titleForRowAtIndexPath:(MoreIndexPath *)indexPath{
    return self.cates[indexPath.column];
}
- (NSArray *)menu:(MoreDropDownMenu *)menu arrayForRowAtIndexPath:(MoreIndexPath *)indexPath{
    if (indexPath.column == 0) {
        return self.cates;
    } else if (indexPath.column == 1){
        return self.states;
    } else {
        return self.sorts;
    }
}

- (void)menu:(MoreDropDownMenu *)menu didSelectRowAtIndexPath:(MoreIndexPath *)indexPath{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)didTapMenu:(MoreDropDownMenu *)menu{
    //    if (self.moveScroll) {
    //        self.moveScroll(self.tableView);
    //    }
    
    NSLog(@"点击了菜单");
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
        NSString *str = weakself.pArray[weakself.page];
        NSArray *arr = [JsonToDic dictionaryWithJsonString:str];
        [weakself updateData:arr];
        
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
