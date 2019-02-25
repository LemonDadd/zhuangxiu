//
//  LogTextView.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MsgEvent)(void);

@interface LogTextView : BaseView

@property (nonatomic, strong)UILabel *titleView;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *msgLabel;
@property (nonatomic, strong)UIButton *msgBtn;
@property (nonatomic, assign)BOOL showMsgBtn;

@property (nonatomic, copy)MsgEvent msgEvent;

@end

NS_ASSUME_NONNULL_END
