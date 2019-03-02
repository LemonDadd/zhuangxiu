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
        aboutImageV.image = [UIImage imageNamed:@"logo_icon"];
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
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        title.text = [infoDictionary objectForKey:@"CFBundleDisplayName"];
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
        
        NSString *str = @"        《盒装》作为新式家居图库应用平台,帮助更多用户体验不同的家居生活方式。总说,家是装不满、装不够的；随着时间流逝,家的装修设计也在不停地更新变化者,在盒装的世界里,大大小小的空间、千姿百态的风格与色彩斑斓的的格调都能满足你对灵感美图的渴求和阅读选择的体验。让自己成为自家的设计能手,让家日日都在变,天天都不同。";
        
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
