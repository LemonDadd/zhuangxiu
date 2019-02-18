//
//  HomeCollectionViewLayout.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/18.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomeCollectionViewLayout;

@protocol HomeCollectionViewLayoutDelegate <NSObject>


/**
 根据每列的宽度获得对应的item 的高度
 
 @param flow  流水对象
 @param width 列宽
 @param index 索引
 
 @return height
 */
@required
-(CGFloat)waterFlow:(HomeCollectionViewLayout*)flow heightForWidth:(CGFloat)width indexPath:(NSIndexPath*)index;

@end

@interface HomeCollectionViewLayout : UICollectionViewLayout

//列数
@property(nonatomic,assign)NSInteger  columns;

//列间距
@property(nonatomic,assign)NSInteger columMargin;

//行间距
@property(nonatomic,assign)NSInteger rowMargin;

//容器离屏间距
@property(nonatomic,assign)UIEdgeInsets marginInsets;

//delegate
@property(nonatomic,weak)id<HomeCollectionViewLayoutDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
