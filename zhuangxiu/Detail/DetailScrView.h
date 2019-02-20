//
//  DetailScrView.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailScrView : BaseView
@property (nonatomic, strong) UIImageView * imageView;

/**
 imageView的横坐标 用于拖拽过程中的动画
 */
@property (nonatomic, assign) CGFloat contentX;
@end

NS_ASSUME_NONNULL_END
