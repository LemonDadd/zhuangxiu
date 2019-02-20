//
//  NewsModel.h
//  zhuangxiu
//
//  Created by 关云秀 on 2019/2/20.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class NewsIdModel;

@interface NewsModel : NSObject
@property (nonatomic, strong)NewsIdModel *_id;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *urls;
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *sourcename;
@property (nonatomic, copy)NSString *content168;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *imglink;
@property (nonatomic, copy)NSString *videolink;
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *titlespelling;
@property (nonatomic, copy)NSString *TYPE;
@property (nonatomic, copy)NSString *SORT;
@property (nonatomic, assign)BOOL PUBLISH;
@property (nonatomic, assign)BOOL OPENSOURCE;
@property (nonatomic, assign)BOOL DELFLAG;
@property (nonatomic, copy)NSString *CTIME;
@property (nonatomic, assign)NSInteger TYPESETTING;
@property (nonatomic, assign)NSInteger readarts;
@property (nonatomic, assign)NSInteger sharearts;
@property (nonatomic, assign)NSInteger talkcount;
@property (nonatomic, assign)NSInteger likecount;
@property (nonatomic, assign)NSInteger faved;
@property (nonatomic, assign)NSInteger liked;
@property (nonatomic, assign)NSInteger recommond;
@property (nonatomic, strong)NSArray *talks;

@end

@interface NewsIdModel : NSObject

@property (nonatomic, assign)NSInteger inc;
@property (nonatomic, assign)NSInteger machine;
@property (nonatomic, assign)NSInteger time;
@property (nonatomic, assign)NSInteger timeSecond;

@end

@interface NewsTalksModel : NSObject
@property (nonatomic, strong)NewsIdModel *_id;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *USERS;
@property (nonatomic, copy)NSString *CONTENTS;
@property (nonatomic, copy)NSString *TEXTS;
@property (nonatomic, copy)NSString *TYPEID;
@property (nonatomic, copy)NSString *TALKS;
@property (nonatomic, copy)NSString *DELFLAG;
@property (nonatomic, copy)NSString *CTIME;
@end



NS_ASSUME_NONNULL_END
