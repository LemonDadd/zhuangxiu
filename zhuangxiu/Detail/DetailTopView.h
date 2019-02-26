//
//  DetailTopView.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"
#import "HomeMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailTopView : BaseView

@property (nonatomic, strong)UIButton *shoucangButton;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)HomeMode *model;

@end

NS_ASSUME_NONNULL_END
