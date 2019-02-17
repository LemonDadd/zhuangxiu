//
//  UserShopImageTabViewCell.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/27.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UserShopImageTabViewCell.h"

@interface UserShopImageTabViewCell ()

@property (nonatomic, strong)UIView *content;

@end

@implementation UserShopImageTabViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _content = [UIView new];
        [self.contentView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@15);
            make.bottom.right.equalTo(@-10);
        }];
        
    }
    return self;
}

-(void)setImgs:(NSArray *)imgs {
    for (UIView *v in _content.subviews) {
        [v removeFromSuperview];
    }
    
    UIView *lastv = nil;
    for (int i = 0; i<imgs.count; i++) {
        UIImageView *imageV = [UIImageView new];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        if ([imgs[i] isKindOfClass:[UIImage class]]) {
            imageV.image = imgs[i];
        } else {
            [imageV sd_setImageWithURL:[NSURL URLWithString:imgs[i]]];
        }
        [_content addSubview:imageV];
        if (!lastv) {
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self.content);
                make.right.equalTo(self.content.mas_centerX).offset(-5);
                make.height.equalTo(imageV.mas_width).multipliedBy(.5);
            }];
        } else {
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(self.content);
                make.width.height.equalTo(lastv);
            }];
        }
        lastv = imageV;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
