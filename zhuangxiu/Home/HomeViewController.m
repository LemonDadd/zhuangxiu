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
#import "FenleiModel.h"

@interface HomeViewController ()<MoreDropDownMenuDataSource,MoreDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate,HomeCollectionViewLayoutDelegate>

@property (nonatomic, strong) NSArray               *cates;
@property (nonatomic, strong) NSArray               *states;
@property (nonatomic, strong) NSArray               *sorts;
@property (nonatomic, strong) MoreDropDownMenu       *menu;
@property (nonatomic, strong) UICollectionView      *col;
@property (nonatomic, strong) NSArray *pArray;
@property (nonatomic, strong) NSMutableArray *allResource;
@property (nonatomic, assign) NSInteger page;


@property (nonatomic, assign)NSInteger tip;
@property (nonatomic, assign)NSInteger tip1;
@property (nonatomic, assign)NSInteger tip2;
@property (nonatomic, assign)NSInteger tip3;
@property (nonatomic, assign)NSInteger luan;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tip = _tip1 = _tip2 = _tip3 = 0;
    
    NSString *fenlei = [[NSBundle mainBundle] pathForResource:@"fenlei" ofType:@"plist"];
    self.cates = [NSArray arrayWithContentsOfFile:fenlei];
    
    _menu = [[MoreDropDownMenu alloc] initWithOrigin:CGPointMake(0,64) andHeight:49.5];
    _menu.delegate = self;
    _menu.dataSource = self;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    [self.view addSubview:_menu];
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
    [_menu hideMenu];
}

#pragma mark - MoreDropDownMenuDataSource and MoreDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(MoreDropDownMenu *)menu{
    return self.cates.count;
}

- (NSInteger)menu:(MoreDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    FenleiModel *model  = [FenleiModel mj_objectWithKeyValues:self.cates[column]];
    return model.condition_list.count;
}

- (NSString *)menu:(MoreDropDownMenu *)menu titleForRowAtIndexPath:(MoreIndexPath *)indexPath{
    FenleiModel *model  = [FenleiModel mj_objectWithKeyValues:self.cates[indexPath.column]];
    ConditionListModel *list =[ConditionListModel mj_objectWithKeyValues:model.condition_list[indexPath.row]];
    return list.name;
//    return model.group_name;
}

// 新增 detailText ,right text
- (NSString *)menu:(MoreDropDownMenu *)menu detailTextForRowAtIndexPath:(MoreIndexPath *)indexPath {
     FenleiModel *model  = [FenleiModel mj_objectWithKeyValues:self.cates[indexPath.column]];
    
    ConditionListModel *list =[ConditionListModel mj_objectWithKeyValues:model.condition_list[indexPath.row]];
    return list.name;
}
- (NSArray *)menu:(MoreDropDownMenu *)menu arrayForRowAtIndexPath:(MoreIndexPath *)indexPath{
    FenleiModel *model  = [FenleiModel mj_objectWithKeyValues:self.cates[indexPath.column]];
    return model.condition_list;
}

- (void)menu:(MoreDropDownMenu *)menu didSelectRowAtIndexPath:(MoreIndexPath *)indexPath{
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    
    if (indexPath.column == 0) {
        _tip = indexPath.row;
    }
    if (indexPath.column == 1) {
        _tip1 = indexPath.row;
    }
    if (indexPath.column == 2) {
        _tip2 = indexPath.row;
    }
    if (indexPath.column == 3) {
        _tip3 = indexPath.row;
    }
    if (_tip  == 0&& _tip1== 0 && _tip2== 0 && _tip3== 0) {
        _luan = NO;
    } else {
        _luan = YES;
    }
    [self.col.mj_header beginRefreshing];
    
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
        NSMutableArray *ma = [NSMutableArray array];
        
        
        if (self->_luan == YES) {
            for (int i=0; i<arr.count; i++) {
                int x = arc4random() % arr.count;
                HomeMode *model =[HomeMode mj_objectWithKeyValues:arr[x]];
                NSString *upath = [[NSBundle mainBundle] pathForResource:@"ren" ofType:@"plist"];
                NSArray *uArray = [NSArray arrayWithContentsOfFile:upath];
                
                NSMutableArray *list = [NSMutableArray array];
                for (int i=0; i<[model.photo_fav_nums integerValue]; i++) {
                    int x = arc4random() % uArray.count;
                    [list addObject:uArray[x]];
                }
                model.userList = [NSArray arrayWithArray:list];
                [ma addObject:model];
            }
        } else {
            for ( NSDictionary *dic in arr) {
                HomeMode *model =[HomeMode mj_objectWithKeyValues:dic];
                NSString *upath = [[NSBundle mainBundle] pathForResource:@"ren" ofType:@"plist"];
                NSArray *uArray = [NSArray arrayWithContentsOfFile:upath];
                
                NSMutableArray *list = [NSMutableArray array];
                for (int i=0; i<[model.photo_fav_nums integerValue]; i++) {
                    int x = arc4random() % uArray.count;
                    [list addObject:uArray[x]];
                }
                model.userList = [NSArray arrayWithArray:list];
                [ma addObject:model];
            }
        }
        [weakself updateData:[ma copy]];
        
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
    HomeMode *model =self.allResource[index.row];
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
    HomeMode *model =self.allResource[indexPath.row];
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
    vc.list = [self.allResource copy];
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
