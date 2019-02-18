//
//  HomeCollectionViewLayout.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "HomeCollectionViewLayout.h"

@interface HomeCollectionViewLayout ()

//item属性数组
@property(nonatomic,strong)NSMutableArray * attributeArray;

//存放每列的高度
@property(nonatomic,strong)NSMutableDictionary * columHeightDic;

@end

@implementation HomeCollectionViewLayout


-(instancetype)init{
    self = [super init];
    if (self) {
        //初始化：列数，列间距，行间距，容器离屏间距。
        self.columns = 2;
        self.columMargin = 5;
        self.rowMargin = 5;
        self.marginInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.attributeArray = [NSMutableArray array];
        self.columHeightDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    for (int i = 0; i<self.columns; i++) {
        
        NSString * key = [NSString stringWithFormat:@"%d",i];
        [self.columHeightDic setObject:@(self.marginInsets.top) forKey:key];
    }
    
    [self.attributeArray removeAllObjects];
    //item数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i<items; i ++) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attributeArray addObject:attrs];
        
    }
    
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attributeArray;
}

-(CGSize)collectionViewContentSize{
    
    __block NSString * maxColum = @"0";
    [self.columHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSNumber * obj, BOOL * _Nonnull stop) {
        if ([obj floatValue]>[self.columHeightDic[maxColum]floatValue]) {
            maxColum = key;
        }
    }];
    
    return CGSizeMake(0, self.marginInsets.bottom+[self.columHeightDic[maxColum]floatValue]);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    __block NSString * minHeightCloum =@"0";
    [self.columHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * colum, NSNumber * maxY, BOOL * _Nonnull stop) {
        
        if ([maxY floatValue]<[self.columHeightDic[minHeightCloum] floatValue]) {
            minHeightCloum = colum;
        }
    }];
    
    
    //计算size
    CGFloat width =  (self.collectionView.frame.size.width - self.marginInsets.left - self.marginInsets.right -  self.columMargin * (self.columns -1))/self.columns;
    
    CGFloat height = [self.delegate waterFlow:self heightForWidth:width indexPath:indexPath];
    
    //计算位置
    CGFloat x = self.marginInsets.left + (self.columMargin +width) * [minHeightCloum intValue];
    
    CGFloat y =  [self.columHeightDic[minHeightCloum]floatValue] +self.rowMargin;
    
    
    [self.columHeightDic setObject:@(y+height) forKey:minHeightCloum];
    
    UICollectionViewLayoutAttributes * attr =  [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, width, height);
    return attr;
}


@end
