//
//  Message_FansList_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message_FansList_Model : NSObject
/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 createtime = "2019-05-24 11:38:27";
 id = 9;
 nickname = "\U5047\U88c5\U5f88\U5e0512";
 status = 1;
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *Fans_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *status;
@end



@interface Message_Apex_Model : NSObject
/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 content = "\U6d4b\U8bd5\U7ed3\U679c\U663e\U793a\U65f6\U95f4\U5df2\U7ecf\U4e0d";
 createtime = "\U524d\U5929";
 discusscontent = "\U4efd\U989d\U6211\U54e6\U6211";
 id = 96;
 imgurl = "";
 nickname = "\U5047\U88c5\U5f88\U5e0512";
 status = 0;
 "transmit_id" = 0;
 userid = 9;
 */

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discusscontent;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *transmit_id;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *Apex_id;
@property (nonatomic, strong) NSString *remove;

@end

@interface Message_Comment_Model : NSObject

/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 content = "\U6d4b\U8bd5\U7ed3\U679c\U663e\U793a\U65f6\U95f4\U5df2\U7ecf\U4e0d";
 createtime = "3\U5929\U524d";
 "discount_content" = "";
 "discount_id" = "";
 "discount_nickname" = "";
 discuss = "hello\U60a8\U7ed9";
 id = 96;
 imgurl = "https://www.txkuaiyou.com/uploads/fileimg/1558500877904-2019-05-22.png";
 nickname = Xutao;
 parent = 0;
 "plaza_id" = 96;
 status = 2;
 "transmit_id" = 0;
 userid = 1;
 */

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discount_content;
@property (nonatomic, strong) NSString *discount_id;
@property (nonatomic, strong) NSString *discount_nickname;
@property (nonatomic, strong) NSString *discuss;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *transmit_id;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *Comment_id;
@property (nonatomic, strong) NSString *parent;
@property (nonatomic, strong) NSString *plaza_id;

@end


@interface Message_RunErrands_Model : NSObject

/**
 avatar = "https://thirdwx.qlogo.cn/mmopen/vi_32/m4VozO5oRZtfsv1l5mEialpapD2d9vsWjRSjR1P2aq2y9T3IDJeRcfDezrlFEnOMYxHZ9HSichypcwbXq9T0PfVQ/132";
 "begin_address" = "\U4e0a\U6d77\U5e02\U6d4b\U8bd5\U5355\U5143\U4e00";
 "begin_phone" = 2773784;
 "begin_realname" = "\U771f\U540d";
 createtime = "8\U5929\U524d";
 distance = 38117;
 "errand_price" = "";
 "finish_address" = "\U4e0a\U6d77\U5e02\U6d4b\U8bd5\U5355\U5143\U4e00";
 "finish_phone" = 2773784;
 "finish_realname" = "\U771f\U540d";
 id = 183;
 nickname = "\U7e41\U534e\U5f85\U6458\Uff0c\U53ea\U7b49\U4f0a\U4eba";
 ordersn = KY2019051820090111238;
 "press_price" = "0.01";
 status = 1;
 "sum_price" = "";
 type = 1;
 userid = 4;
 weight = "\U6587\U4ef6,\U5c0f\U4e8e5kg";
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *begin_address;
@property (nonatomic, strong) NSString *begin_phone;
@property (nonatomic, strong) NSString *begin_realname;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *errand_price;
@property (nonatomic, strong) NSString *finish_address;
@property (nonatomic, strong) NSString *finish_phone;
@property (nonatomic, strong) NSString *finish_realname;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *press_price;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *RunErrands_id;

@end

@interface Message_Shoping_Model : NSObject
/**
 "actual_price" = "258.00";
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 createtime = "4\U5929\U524d";
 "finish_address" = "\U4e0a\U6d77\U5e02\U677e\U6c5f\U533a\U65b0\U57ce";
 "finish_phone" = 18538383881;
 "finish_realname" = "\U54e6\U5dcd\U5ce8";
 goods =             (
 {
 
 }
 );
 id = 1237;
 "merchant_errand" = 1;
 nickname = "\U5047\U88c5\U5f88\U5e0512";
 ordersn = KY2019052317490844213;
 status = 4;
 "sum_price" = "258.00";
 userid = 9;
 weight = "";
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *actual_price;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *finish_address;
@property (nonatomic, strong) NSString *finish_phone;
@property (nonatomic, strong) NSString *finish_realname;
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, strong) NSString *merchant_errand;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *press_price;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *Shoping_id;

@end

@interface Message_Shoping_Branch_Model : NSObject
/**
 "goods_id" = 26;
 "goods_img" = "https://www.txkuaiyou.com/uploads/fileimg/1557799546851-2019-05-14.png";
 "goods_name" = "UR2019\U590f\U5b63\U65b0\U54c1\U7537\U88c5\U7b80\U7ea6\U7eaf\U8272\U5706\U9886\U9488\U7ec7T\U6064MF22S9BN2001\U7eaf\U8272\U5706\U9886\Uff0c\U9488\U7ec7\U9762\U6599\Uff0c\U7b80\U7ea6\U6613\U642d\U914d";
 "goods_sum" = 1;
 price = "239.00";
 specification = " \U7070\U8272 S \U68c986%  ";
 */

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_sum;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *specification;

@end

@interface Message_Housekeeping_Model : NSObject
/**
 "actual_price" = "400.00";
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 createtime = "18\U5929\U524d";
 fetchtime = "1970-01-01 08:33:39";
 "finish_address" = "\U4e0a\U6d77\U5e02\U9ec4\U6d66\U533a\U4eba\U6c11\U5927\U9053200\U53f7\U4e1c\U65b9\U8857\U90531206\U53f71205\U5ba4";
 "finish_phone" = 17717557393;
 "finish_realname" = "\U738b\U5927\U9646";
 "hyusbandry_type" = 2;
 id = 23;
 nickname = "\U5047\U88c5\U5f88\U5e0512";
 ordersn = KY2019051009441224566;
 status = 1;
 "sum_price" = "400.00";
 userid = 9;
 weight = "\U5355\U72ec\U53a8\U536b";
 */

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *actual_price;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *fetchtime;
@property (nonatomic, strong) NSString *finish_address;
@property (nonatomic, strong) NSString *finish_phone;
@property (nonatomic, strong) NSString *finish_realname;
@property (nonatomic, strong) NSString *hyusbandry_type;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *Housekeeping_id;

@end

@interface Message_infromLists_Model : NSObject

/**
 "userid": 2,
 "nickname": "Horizon",
 "avatar": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1DcJmzT9WdomNdqicy3hSzictdyyfOib6SKjj50s8pKhojURBdjRLX5Q4GicKvvuQECUxib0l5tcC2Ww/132",
 "createtime": "1977-06-04"
 */
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *createtime;


@end

NS_ASSUME_NONNULL_END
