//
//  NewsHTableViewCell.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsHTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *shouc;
@property (weak, nonatomic) IBOutlet UILabel *kan;
@property (weak, nonatomic) IBOutlet UILabel *fenlei;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end

NS_ASSUME_NONNULL_END
