//
//  DetailViewController.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/15.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailScrView.h"
#import "HomeMode.h"
#import "DetailTopView.h"
#import "DetailBottomView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCROLLVIEW_WIDTH SCREEN_WIDTH

#define BaseTag 10

/**
 动画偏移量 是指rightView相对于leftView的偏移量
 */
#define AnimationOffset 100

@interface DetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrView;
@property (nonatomic, strong)DetailTopView *topView;
@property (nonatomic, strong)DetailBottomView *bottomView;
@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)NSArray *userList;
@property (nonatomic, strong)NSMutableArray *picArray;

@property (nonatomic, strong)UIButton *rightItem;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图片详情";
    
    _rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightItem setImage:[UIImage imageNamed:@"收藏1"] forState:UIControlStateNormal];
    [_rightItem setImage:[UIImage imageNamed:@"已收藏1"] forState:UIControlStateSelected];
    [_rightItem addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightItem];
    
    
    
    _scrView = [UIScrollView new];
    _scrView.delegate =self;
    _scrView.pagingEnabled = YES;
    _scrView.bounces = NO;
    _scrView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrView];
    [_scrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.bottom.equalTo(@-100);
        make.left.right.equalTo(self.view);
    }];
    
    
    _contentView = [UIView new];
    [_scrView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrView);
        make.height.equalTo(self.scrView);
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shuju" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSString *str in arr) {
        NSArray *list = [JsonToDic dictionaryWithJsonString:str];
        [self.picArray addObjectsFromArray:list];
    }
    UIView *lastV = nil;
    for (int i=0; i<self.picArray.count;i++) {
        HomeMode *model =[HomeMode mj_objectWithKeyValues:self.picArray[i]];
        DetailScrView * view = [[DetailScrView alloc] init];
        [view.imageView sd_setImageWithURL:[NSURL URLWithString:model.photo_img_l]];
        [_contentView addSubview:view];
        view.tag = BaseTag + i;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(self.scrView);
            if (lastV == nil) {
                make.left.equalTo(self.contentView);
            } else {
                make.left.equalTo(lastV.mas_right);
            }
        }];
        lastV = view;
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastV);
    }];
    
    _topView = [DetailTopView new];
    _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(self.view);
    }];
    
    _bottomView = [DetailBottomView new];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_scrView setContentOffset:CGPointMake(self->_indx*SCREEN_WIDTH,0) animated:false];
        HomeMode *model =[HomeMode mj_objectWithKeyValues:self.picArray[self->_indx]];
        self->_topView.name.text = model.subject_info.subject_name;
        self->_topView.detailLabel.text = model.photo_des;
        [self.view layoutIfNeeded];
    });
    
    
   
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    
    NSInteger leftIndex = x/SCROLLVIEW_WIDTH;
       NSLog(@"%ld",leftIndex);
     HomeMode *model =[HomeMode mj_objectWithKeyValues:self.picArray[leftIndex]];
    _topView.name.text = model.subject_info.subject_name;
    _topView.detailLabel.text = model.photo_des;
    
    //这里的left和right是区分拖动中可见的两个视图
    DetailScrView * leftView = [scrollView viewWithTag:(leftIndex + BaseTag)];
    DetailScrView * rightView = [scrollView viewWithTag:(leftIndex + 1 + BaseTag)];
    
    
    
    //    leftView.contentX = -(SCROLLVIEW_WIDTH - x + (leftIndex * SCROLLVIEW_WIDTH));
    //    rightView.contentX = (SCROLLVIEW_WIDTH + x - ((leftIndex + 1) * SCROLLVIEW_WIDTH));
    
    
    rightView.contentX = -(SCROLLVIEW_WIDTH - AnimationOffset) + (x - (leftIndex * SCROLLVIEW_WIDTH))/SCROLLVIEW_WIDTH * (SCROLLVIEW_WIDTH - AnimationOffset);
    leftView.contentX = ((SCROLLVIEW_WIDTH - AnimationOffset) + (x - ((leftIndex + 1) * SCROLLVIEW_WIDTH))/SCROLLVIEW_WIDTH * (SCROLLVIEW_WIDTH - AnimationOffset));
    
}


- (void)right:(UIButton *)sender {
    sender.selected = !sender.selected;
}

-(NSMutableArray *)picArray {
    if (_picArray == nil) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
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
