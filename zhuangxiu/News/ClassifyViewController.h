//
//  ClassifyViewController.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseViewController.h"

@protocol ClassifyViewControllerDelgate <NSObject>

- (void)classifyViewControllerdidClick:(NSString *)tip;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ClassifyViewController : BaseViewController

@property (nonatomic, weak)id<ClassifyViewControllerDelgate>delegate;

@end

NS_ASSUME_NONNULL_END
