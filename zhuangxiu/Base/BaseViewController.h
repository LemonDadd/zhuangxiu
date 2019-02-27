//
//  BaseViewController.h
//  zhuangxiu
//
//  Created by quanqiuwa on 2019/2/14.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)saveShouCang:(HomeMode *)model;
- (void)deleteShouCang:(HomeMode *)model;
- (NSArray *)getShoucang;
- (void)gotoLoginViewController;

@end

NS_ASSUME_NONNULL_END
