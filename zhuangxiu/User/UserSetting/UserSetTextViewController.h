//
//  UserSetTextViewController.h
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/28.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN



@protocol UserSetTextViewControllerDelegate <NSObject>

- (void)saveTextWithStr:(NSString *)text isNick:(BOOL)nick;

@end

@interface UserSetTextViewController : BaseViewController

@property (nonatomic, assign)BOOL isNick;
@property (nonatomic, weak)id<UserSetTextViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
