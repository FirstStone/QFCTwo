//
//  SquareTitle_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/5.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SquareTitle_Model : NSObject

@property (nonatomic, strong) NSString *Title_ID;
@property (nonatomic, strong) NSString *Type_name;

@end

/*
 {
 "id": 1,
 "uid": 1,
 "nickname": "假装很帅",
 "avatar": "http://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "content": "你认为那个城市最适合居住?",
 "imgurl": [
 ""
 ],
 "label": [
 ""
 ],
 "address": "地址",
 "createtime": "2006-12-04 10:09:16",
 "discuss_sum": 1,
 "like_sum": 0,
 "transmit_id": 0,
 "share_sum": 0,
 "type_id": 4,
 "typename": "问答",
 "status": 3
 }
 */

@interface SquareRecommend_Model : NSObject

@property (nonatomic, strong) NSString *SquareRecommend_ID;
@property (nonatomic, strong) NSString *like_sum;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *imgurl;
@property (nonatomic, strong) NSArray *label;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *transmit_id;
@property (nonatomic, strong) NSString *share_sum;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *Type_name;
/**1文字2图文3回答*/
@property (nonatomic, strong) NSString *status;
/**0没有点赞1已点赞*/
@property (nonatomic, strong) NSString *likestatus;
/**个人资料*/
@property (nonatomic, strong) NSString *answer_content;
@property (nonatomic, strong) NSString *parent;
@property (nonatomic, strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
