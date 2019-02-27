//
//  HomeMode.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/19.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SubjectMode;

@interface HomeMode : NSObject

@property (nonatomic, copy) NSString *photo_id;
@property (nonatomic, copy) NSString *photo_des;
@property (nonatomic, copy) NSString *photo_img_s;
@property (nonatomic, copy) NSString *photo_img_m;
@property (nonatomic, copy) NSString *photo_img_l;
@property (nonatomic, copy) NSString *photo_fav_nums;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, strong)SubjectMode *subject_info;
@property (nonatomic, copy) NSString *subject_id;
@property (nonatomic, copy) NSString *is_recommended;
@property (nonatomic, copy) NSString *recommend_algorithm;
@property (nonatomic, copy) NSString *is_jiatu_processed;
@property (nonatomic, strong)NSArray *userList;
@property (nonatomic, assign)BOOL shoucang;

@end

@interface SubjectMode : NSObject

@property (nonatomic, copy) NSString *subject_id;
@property (nonatomic, copy) NSString *subject_name;
@property (nonatomic, copy) NSString *subject_title_img_s;
@property (nonatomic, copy) NSString *subject_title_img_m;
@property (nonatomic, copy) NSString *subject_title_img_l;
@property (nonatomic, copy) NSString *style_id;
@property (nonatomic, copy) NSString *style_name;
@property (nonatomic, copy) NSString *house_type_id;
@property (nonatomic, copy) NSString *house_type_name;
@property (nonatomic, copy) NSString *price_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *area;

@end


NS_ASSUME_NONNULL_END
