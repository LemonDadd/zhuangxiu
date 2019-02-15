//
//  BaseTableView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/15.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 200;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

@end
