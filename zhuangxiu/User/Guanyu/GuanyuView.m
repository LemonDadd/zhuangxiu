//
//  GuanyuView.m
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/25.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "GuanyuView.h"

@implementation GuanyuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *aboutImageV = [UIImageView new];
        aboutImageV.image = [UIImage imageNamed:@"log_login_biao"];
        [self addSubview:aboutImageV];
        [aboutImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(50);
            make.width.equalTo(@57);
            make.height.equalTo(@(91));
        }];
        
        UILabel *title = [UILabel new];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(aboutImageV.mas_bottom).offset(5);
        }];
        title.font = [UIFont systemFontOfSize:18];
        title.text = @"今合健康";
        title.textAlignment = NSTextAlignmentCenter;
        
        UIView *line = [UIView new];
        line.backgroundColor = kColorWithHex(LINECOLOR);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(30);
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.height.equalTo(@1);
        }];
        
        NSString *str = @"        今合健康APP，为您提供在线健康咨询服务，整合用户身体历史、现状指标，提供连续的、高度个人化的日常健康生活方式养成计划，成为24小时陪护你的医学专家，督促和干预你管理健康，渗透日常点滴，改善亚健康病态。";
        
        UILabel *aboutLab = [UILabel new];
        [self addSubview:aboutLab];
        [aboutLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(line.mas_bottom).offset(25);
            
        }];
        
        aboutLab.numberOfLines = 0;
        aboutLab.attributedText =[self getAttributedStringWithString:str lineSpace:13.f];
        
        
        
    }
    return self;
}

//设置行间距
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kColorWithHex(BLACKCOLOR) range:range];
    return attributedString;
}


@end
