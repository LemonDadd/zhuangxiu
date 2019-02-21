//
//  ClassifyViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassifyCollectionViewCell.h"
@interface ClassifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *mainCollectionView;
@property (nonatomic, strong)NSArray *array;

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//滚动视图的方向
    
    flowLayout.minimumInteritemSpacing =0;
    flowLayout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    flowLayout.sectionInset = UIEdgeInsetsMake(0.f,5, 0.f, 5);
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView setBackgroundColor:kColorWithHex(0xf6f6f8)];
    [_mainCollectionView setDelegate:self];
    [_mainCollectionView setDataSource:self];
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    //        //注册
    [_mainCollectionView registerClass:[ClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"ClassifyCollectionViewCell"];
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _array = @[@"家居设计",@"家饰搭配",@"装修指南",@"装修风水"];
    
//    [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
//    [_tab registerNib:[UINib nibWithNibName:NSStringFromClass([NewsHTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"NewsHTableViewCell"];
}

- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}


//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _array.count;
}

//每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyCollectionViewCell *cell = [_mainCollectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyCollectionViewCell" forIndexPath:indexPath];
    cell.title.text =_array[indexPath.row];
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
    if (_delegate && [_delegate respondsToSelector:@selector(classifyViewControllerdidClick:)]) {
        [_delegate classifyViewControllerdidClick:_array[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
