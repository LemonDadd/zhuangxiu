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

@interface HomeViewController ()<MoreDropDownMenuDataSource,MoreDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray               *cates;
@property (nonatomic, strong) NSArray               *states;
@property (nonatomic, strong) NSArray               *sorts;
@property (nonatomic, strong) MoreDropDownMenu       *menu;
@property (nonatomic, strong) UICollectionView      *col;
@property (nonatomic, strong) NSMutableArray *allResource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cates = @[@"空间",@"风格",@"颜色",@"局部"];
    
    _menu = [[MoreDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:49.5];
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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//滚动视图的方向
    
    flowLayout.minimumInteritemSpacing =0;
    flowLayout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    flowLayout.sectionInset = UIEdgeInsetsMake(0.f,5, 0.f, 5);
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
        make.top.equalTo(self.menu);
    }];
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
    return self.cates[indexPath.row];
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
        [weakself reStartRequestData];
    }];
    // 马上进入刷新状态
    [_col.mj_header beginRefreshing];
}

- (void)reStartRequestData {
    kWeakSelf(self);
//    [_antiqueModelClass requestAntiqueRequest:^(NSString *errorMsg) {
//        if (errorMsg == nil) {
//            [weakself updateData];
//        }else {
//            [weakself.mainCollectionView .mj_header endRefreshing];
//            [CustomView alertMessage:errorMsg view:weakself];
//        }
//    }];
}


- (void)updateData {
    [_col .mj_header endRefreshing];
    [_col reloadData];
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
    
    if (self.allResource.count >indexPath.row) {
//        AntiqueModel *model = _antiqueModelClass.allResource[indexPath.row];
//        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:SmallDefault]];
    }
    
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([DeviceInfo ScreenSize].width-15)/2,([DeviceInfo ScreenSize].width-15)/2);
}

//是否可以选择Item
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//选择某个Item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


-(NSMutableArray *)allResource {
    if (_allResource == nil) {
        _allResource = [NSMutableArray array];
    }
    return _allResource;
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
