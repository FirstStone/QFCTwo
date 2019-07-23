//
//  Home_KDR_Order_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/7/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_KDR_Order_Model : NSObject
/**
 address = "\U6d1e\U6cfe\U9547\U957f\U5174\U8def98\U5f04";
 addressid = 402;
 createtime = "16:14";
 details = "68\U680b";
 id = 253;
 phone = 15038607764;
 realname = "\U77f3\U4f73\U7537";
 status = 0;
 type = 4;
 village = "\U6d77\U6b23\U57ce\U65b0\U4e16\U7eaa\U5bb6\U56ed";
 */
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *addressid;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *Orderid;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *village;

@end

@interface Home_KDR_YQList_Model : NSObject
/**
 avatar = "http://thirdwx.qlogo.cn/mmopen/vi_32/4TbceJuo32eeNSWspesx7Q3Y5iaoInDiavtdsDsZ26lYxUVxGv6fHYb0R0zLFbVVfolM8iaYQG6Xn9IfZv2Kt2Z9g/132";
 createtime = "2019-07-19 10:24";
 nickname = "\U715c\U661f";
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *nickname;

@end

@interface KDR_People_Model : NSObject
/**
 address = "\U6d1e\U6cfe\U9547\U957f\U5174\U8def98\U5f04";
 against = "https://www.txkuaiyou.com/uploads/fileimg/15632462231-2019-07-16.png";
 age = 18;
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1563246223278-2019-07-16.png";
 city = "\U4e0a\U6d77\U5e02";
 county = "\U677e\U6c5f\U533a";
 createtime = 1563246227;
 "get_status" = 0;
 hand = "https://www.txkuaiyou.com/uploads/fileimg/156324622346-2019-07-16.png";
 id = 98;
 invite = 0;
 just = "https://www.txkuaiyou.com/uploads/fileimg/1563246223615-2019-07-16.png";
 latitude = "31.082749";
 longitude = "121.278097";
 "order_sum" = 6;
 phone = 15038607764;
 province = "\U4e0a\U6d77\U5e02";
 realname = "\U77f3\U4f73\U7537";
 sex = 1;
 uid = 7;
 village = "\U96f7\U4e01\U5c0f\U57ce";
 */

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *against;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *get_status;
@property (nonatomic, strong) NSString *hand;
@property (nonatomic, strong) NSString *KDR_id;
@property (nonatomic, strong) NSString *invite;
@property (nonatomic, strong) NSString *just;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *order_sum;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *village;
@end

@interface Home_KDR_Card_Model : NSObject
/**
 audit = 0;
 avatar = "http://thirdwx.qlogo.cn/mmopen/vi_32/1gzC2R9J7FhHjgtez4V73F7ib1ZXEzJ05bnZnXTzqIyspDuLya78KCDHDfqBIIWCrn4tPc6icRS0C8g89mSDIPyA/132";
 endtime = 29;
 experience = 0;
 id = 25;
 nickname = "\U7d2b\U8272\U70df\U82b1";
 openid = "oNDkG1g_JUBm8oC5YO7Vlbmc-LdQ";
 status = 1;
 type = 1;
 "type_id" = 4;
 */
@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *uid_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *type_id;

@end

NS_ASSUME_NONNULL_END
