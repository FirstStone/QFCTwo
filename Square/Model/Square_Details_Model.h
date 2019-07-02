//
//  Square_Details_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Square_Details_Model : NSObject

/**
 "id": 4,
 "uid": 3,
 "content": "阿凡达开办费不是的客服表示肯定不付款安抚",
 "type_id": 1,
 "imgurl": [
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg"
 ],
 "parent": 0,
 "discuss_sum": 0,
 "like_sum": 0,
 "share_sum": 0,
 "createtime": "刚刚",
 "label": [
 "阿萨德",
 "士大夫",
 "防守打法"
 ],
 "avatar": "https://wx.qlogo.cn/mmopen/vi_32/ibUJTHFt6ZoqrOibWXBke26jm1CZAwfUdE3oBfI39XwmME2ZJrKicw6N0giaPicCPQa2YmCfxrQUuRXBSvhfNLOW5HQ/132",
 "nickname": "煜星",
 "attention": 0,
 "collect": 0,
 "like": 0
 */

@property (nonatomic, strong) NSString *Details_id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSArray *imgurl;
/**顶*/
@property (nonatomic, strong) NSString *parent;
/**评论*/
@property (nonatomic, strong) NSString *discuss_sum;
/**顶数量*/
@property (nonatomic, strong) NSString *like_sum;
/**分享*/
@property (nonatomic, strong) NSString *share_sum;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSArray *label;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *nickname;
/**关注*/
@property (nonatomic, strong) NSString *attention;
/**收藏*/
@property (nonatomic, strong) NSString *collect;
/**喜欢状态*/
@property (nonatomic, strong) NSString *like;


@end

/**
 "id": 1,
 "content": "东方市分公司答复水电费水电费",
 "createtime": "1970-01-01",
 "uid": 2,
 "avatar": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1DcJmzT9WdomNdqicy3hSzictdyyfOib6SKjj50s8pKhojURBdjRLX5Q4GicKvvuQECUxib0l5tcC2Ww/132",
 "like_sum": 0,
 "nickname": "Horizon",
 "pid": 0,
 "pavatar": "",
 "pnickname": "",
 "status": 0
 */

@interface Square_detailsDiscuss_Model : NSObject


@property (nonatomic, strong) NSString *detailsDiscuss_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *like_sum;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *pavatar;
@property (nonatomic, strong) NSString *pnickname;
@property (nonatomic, strong) NSString *status;

@end

/**
 list =     (
 {
 avatar = "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1DcJmzT9WdomNdqicy3hSzictdyyfOib6SKjj50s8pKhojURBdjRLX5Q4GicKvvuQECUxib0l5tcC2Ww/132";
 content = "\U957f\U6c99\Uff0c\U6e56\U5357\U7701\U7701\U4f1a\Uff0c\U662f\U957f\U6c5f\U4e2d\U6e38\U5730\U533a\U91c
3001\U56fd\U5185\U9996\U53f03D\U70e7\U7ed3\U6253\U5370\U673a\U7b49\U79d1\U7814\U6210\U679c\U3002";
 createtime = "2019-05-14 18:01:50";
 "discuss_sum" = 0;
 id = 2;
 imgurl =             (
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg"
 );
 "like_sum" = 1;
 likestatus = 1;
 nickname = Horizon;
 "share_sum" = 0;
 status = 1;
 uid = 2;
 }
 );
 status = 1;
 */
@interface Square_QuestionsAndAnswers_List_Model : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSArray *imgurl;
@property (nonatomic, strong) NSString *like_sum;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *share_sum;
/**1为有图文  2为只有文字*/
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *likestatus;

@end

@interface Square_QuestionsAndAnswers_Top_Model : NSObject
/**
 info =     (
 {
 attention = 0;
 avatar = "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1DcJmzT9WdomNdqicy3hSzictdyyfOib6SKjj50s8pKhojURBdjRLX5Q4GicKvvuQECUxib0l5tcC2Ww/132";
 collect = 0;
 content = "发送快递费看见爱上的接口分布爱是";
 "discuss_sum" = 1;
 id = 5;
 list =             (
 );
 nickname = Horizon;
 "type_id" = 4;
 uid = 2;
 }
 );
 status = 1;
 */



@property (nonatomic, strong) NSString *attention;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *collect;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *Top_id;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *uid;

@end

@interface Square_information_Model : NSObject
/**
 "id": 1,
 "nickname": "Xutao",
 "sex": 1,        //1男2女
 "country": "中国",
 "province": "山东省",
 "year": 70,        //70后
 "avatar":    //头像
 "createtime": 124,
 "fans_sum": 0,         //粉丝总数
 "attention_sum": 10,      //关注总数
 "plaza_sum": 0,      //发布总数
 "type_id": 3   //1跑腿2家政3商家
 */
@property (nonatomic, strong) NSString *information_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *fans_sum;
@property (nonatomic, strong) NSString *attention_sum;
@property (nonatomic, strong) NSString *plaza_sum;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *merchant_id;


@end


NS_ASSUME_NONNULL_END
