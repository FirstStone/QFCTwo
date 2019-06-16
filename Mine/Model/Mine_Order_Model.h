//
//  Mine_Order_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_Order_Model : NSObject
/**
 "id": 152,
 "ordersn": "KY2019051418080893878",
 "createtime": "2019-05-14 18:08:08",
 "type": 1,
 "parcel_pw": "OVpnY",
 "service_id": "",
 "errandid": "",
 "begin_address": "上海市一单元",
 "begin_phone": "234234",
 "begin_realname": "真名sssssdffsd",
 "finish_realname": "真名s",
 "finish_address": "上海市一单元sdfgsdfg",
 "finish_phone": "23423445645",
 "weight": "文件,小于5kg",
 "press_price": "0.01",
 "price": "",
 "actual_price": "",
 "sum_price": "",
 "errand_price": "",
 "status": 0,
 "hyusbandry_type": "",
 "merchant_errand": "",
 "goodslist": [],
 "service_name": "",
 "service_avatar": ""
 service_phone
 */
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userimg;
@property (nonatomic, strong) NSString *userid;
/**订单ID*/
@property (nonatomic, strong) NSString *order_ID;
/**订单号*/
@property (nonatomic, strong) NSString *ordersn;
/**下单时间*/
@property (nonatomic, strong) NSString *createtime;
/**1跑腿2家政3商家*/
@property (nonatomic, strong) NSString *type;
/***/
@property (nonatomic, strong) NSString *service_id;
@property (nonatomic, strong) NSString *errandid;
@property (nonatomic, strong) NSString *begin_address;
@property (nonatomic, strong) NSString *begin_phone;
@property (nonatomic, strong) NSString *begin_realname;
@property (nonatomic, strong) NSString *finish_realname;
@property (nonatomic, strong) NSString *finish_address;
@property (nonatomic, strong) NSString *finish_phone;
/**家政服务套餐*/
@property (nonatomic, strong) NSString *weight;
/**跑腿预约费用*/
@property (nonatomic, strong) NSString *press_price;
/**家政 里*/
@property (nonatomic, strong) NSString *price;
/**家政 外*/
@property (nonatomic, strong) NSString *actual_price;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *errand_price;
/**订单状态*/
@property (nonatomic, strong) NSString *status;
/**1 日常保洁 2 深度保洁*/
@property (nonatomic, strong) NSString *hyusbandry_type;
@property (nonatomic, strong) NSString *merchant_errand;
@property (nonatomic, strong) NSMutableArray *goodslist;
/**家政姓名*/
@property (nonatomic, strong) NSString *service_name;
/**家政头像*/
@property (nonatomic, strong) NSString *service_avatar;
/**家政手机号*/
@property (nonatomic, strong) NSString *service_phone;
/**退款状态*/
@property (nonatomic, strong) NSString *refundstatus;

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *avatar;

@end


@interface Mine_Follow_Model : NSObject
/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 createtime = "4\U5929\U524d";
 id = 1;
 nickname = Xutao;
 "type_id" = 3;
 */

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *Follow_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *type_id;


@end


@interface Mine_Goods_Supervise_Model : NSObject
/**
 "activity_price" = "0.00";
 "goods_img" = "https://www.kuaiyoushequ.com/uploads/fileimg/1557380510396-2019-05-09.jpg";
 "goods_name" = "\U5e06\U5e03\U5305\U59732019\U65b0\U6b3e\U590f\U5b63\U65f6\U5c1ains\U5927\U5bb9\U91cf\U5355\U80a9\U624b\U63d0\U6258\U7279\U5973\U5305\U5e03\U888b";
 "goods_unit" = "\U4ef6";
 id = 2;
 price = "269.00";
 status = 0;
 */
@property (nonatomic, strong) NSString *activity_price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_unit;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *Goods_id;

@end

@interface Mine_Order_Details_Model : NSObject

/**
 info =     {
 "actual_price" = "199.00";
 "begin_address" = "\U4e0a\U6d77\U5e02\U677e\U6c5f\U533a\U6f15\U6cb3\U6cfe\U5f00\U53d1\U533a\U677e\U6c5f\U56ed\U533a";
 "begin_phone" = 15210165663;
 "begin_realname" = "\U5f90\U6d9b";
 createtime = "2019-06-03 10:43:25";
 "discount_price" = 0;
 "errand_avatar" = "";
 "errand_id" = "";
 "errand_name" = "";
 "errand_phone" = "";
 "errand_price" = "0.00";
 errandid = "";
 fetchtime = "";
 "finish_address" = "\U4e0a\U6d77\U5e02\U677e\U6c5f\U533a\U4e2d\U5c71\U4e8c\U8def594\U53f7";
 "finish_phone" = 18538383881;
 "finish_realname" = "\U5df4\U4e3a\U7131";
 goodslist =         (
 {
 "goods_id" = 31;
 "goods_img" = "https://www.txkuaiyou.com/uploads/fileimg/1557828377509-2019-05-14.png";
 "goods_name" = "\U6d4b\U8bd5\U5546\U54c1";
 "goods_sum" = 2;
 price = "111.00";
 specification = "<null>";
 },
 );
 "hyusbandry_type" = "";
 id = 232;
 "merchant_errand" = 2;
 "merchant_status" = 0;
 ordersn = KY2019060310432580858;
 "parcel_pw" = "";
 "pay_status" = 0;
 pid = 1;
 "press_price" = "";
 price = "";
 remark = "";
 "service_avatar" = "https://www.txkuaiyou.com/uploads/fileimg/1557209308150-2019-05-07.png";
 "service_id" = 1;
 "service_name" = "\U9e45\U9e45\U9e45";
 "service_phone" = 15210165663;
 status = 0;
 "sum_price" = "199.00";
 type = 3;
 uid = 9;
 weight = "";
 };
 status = 1;
 */

@property (nonatomic, strong) NSString *actual_price;
@property (nonatomic, strong) NSString *begin_address;
@property (nonatomic, strong) NSString *begin_phone;
@property (nonatomic, strong) NSString *begin_realname;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discount_price;
@property (nonatomic, strong) NSString *errand_avatar;
@property (nonatomic, strong) NSString *errand_id;
@property (nonatomic, strong) NSString *errand_name;
@property (nonatomic, strong) NSString *errand_phone;
@property (nonatomic, strong) NSString *errand_price;
@property (nonatomic, strong) NSString *errandid;
@property (nonatomic, strong) NSString *fetchtime;
@property (nonatomic, strong) NSString *finish_address;
@property (nonatomic, strong) NSString *finish_phone;
@property (nonatomic, strong) NSString *finish_realname;
@property (nonatomic, strong) NSMutableArray *goodslist;
@property (nonatomic, strong) NSString *hyusbandry_type;
@property (nonatomic, strong) NSString *orderDetails_id;
@property (nonatomic, strong) NSString *merchant_errand;
@property (nonatomic, strong) NSString *merchant_status;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *parcel_pw;
@property (nonatomic, strong) NSString *pay_status;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *press_price;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *service_avatar;
@property (nonatomic, strong) NSString *service_id;
@property (nonatomic, strong) NSString *service_name;
@property (nonatomic, strong) NSString *service_phone;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *weight;


@end

@interface Mine_MyActivity_Model : NSObject
/**
 "activity_name" = "\U6d4b\U8bd5\U6d3b\U52a8";
 begintime = "2019-06-04";
 cate = 2;
 createtime = "2019-06-04 16:10:52";
 endtime = "2019-06-30";
 goodslist =             (
 {
 "activity_price" = "0.09";
 "activity_status" = 2;
 discount = 10;
 "goods_id" = 5;
 "goods_img" = "https://www.txkuaiyou.com/uploads/fileimg/155954826374-2019-06-03.png";
 "goods_name" = Poker2;
 price = "0.10";
 },
 );
 id = 9;
 status = 1;
 type = 1;
 */
@property (nonatomic, strong) NSString *activity_name;
@property (nonatomic, strong) NSString *begintime;
@property (nonatomic, strong) NSString *cate;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSMutableArray *goodslist;
@property (nonatomic, strong) NSString *Activity_id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;

@end

@interface Mine_MyActivity_Branch_Model : NSObject
/**
 "activity_price" = "0.09";
 "activity_status" = 2;
 discount = 10;
 "goods_id" = 5;
 "goods_img" = "https://www.txkuaiyou.com/uploads/fileimg/155954826374-2019-06-03.png";
 "goods_name" = Poker2;
 price = "0.10";
 */
@property (nonatomic, strong) NSString *activity_price;
@property (nonatomic, strong) NSString *activity_status;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *price;

@end

@interface Mine_MyCard_Model : NSObject
/**
 begintime = "2019-06-06";
 cate = 1;
 createtime = "2019-06-06 15:07:41";
 discount = "";
 "discount_status" = 1;
 endtime = "2019-06-30";
 fullprice = 100;
 id = 12;
 minusprice = 20;
 repertory = 100;
 status = 1;
 type = 1;
 discountstatus
 */
@property (nonatomic, strong) NSString *begintime;
@property (nonatomic, strong) NSString *cate;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *discount_status;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *fullprice;
@property (nonatomic, strong) NSString *minusprice;
@property (nonatomic, strong) NSString *repertory;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *MyCard_id;
@property (nonatomic, strong) NSString *discountstatus;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *remove;

@end

@interface Mine_MyOrder_Evalute_Model : NSObject

/**
 "type": 1,
 "content": "此用户暂无评价",
 "imgurl": [],
 "createtime": "刚刚",
 "grade": 5,
 "left_id": 1,
 "left_name": "李三",
 "left_avatar": "https://www.txkuaiyou.com/uploads/fileimg/156048080689-2019-06-14.png",
 "left_remark": "",
 "userid": 7,
 "nickname": "快友1023",
 "avatar": "https://www.txkuaiyou.com/uploads/images/20190523143914.png"
 */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *imgurl;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *left_id;
@property (nonatomic, strong) NSString *left_name;
@property (nonatomic, strong) NSString *left_avatar;
@property (nonatomic, strong) NSString *left_remark;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;


@end

NS_ASSUME_NONNULL_END
