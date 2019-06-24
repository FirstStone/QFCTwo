//
//  Mine_SetUP_MyAddress_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_SetUP_MyAddress_Model : NSObject


/*
 "address": "上海市",
 "details": "上海市",
 "id": 10,
 "realname": "真名",
 "phone": "123456789",
 "sex": 1
 */
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *MyAddress_id;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *status;

@end

@interface Mine_UserMessage_Model : NSObject

/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";
 city = "\U83cf\U6cfd\U5e02";
 county = "\U66f9\U53bf";
 day = 24;
 id = 1;
 month = 10;
 nickname = Xutao;
 phone = 15210165663;
 province = "\U5c71\U4e1c\U7701";
 qrcode = "http://www.txkuaiyou.com/uploads/qrcode/kyuser_1.jpg";
 sex = 1;
 signature = "";
 year = 1970;
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *qrcode;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *User_id;

@end

@interface Mine_MyShopStore_Model : NSObject
/**
 address = "\U4e0a\U6d77\U5e02\U677e\U6c5f\U533a";
 "attention_sum" = 5;
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1560669894343-2019-06-16.png";
 beginbusiness = "00:00";
 endbusiness = "23:59";
 grade = "9.27";
 id = 1;
 latitude = "31.09255";
 longitude = "121.32384";
 merchant = "\U679c\U5b50\U94fa";
 phone = 17639895136;
 range = "\U6c34\U679c\Uff0c\U852c\U83dc\Uff0c\U719f\U98df\Uff0c\U7cd5\U70b9\Uff0c\U5e72\U8d27\Uff0c\U6c34\U4ea7\Uff0c\U8089\U7c7b";
 */
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *attention_sum;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *beginbusiness;
@property (nonatomic, strong) NSString *endbusiness;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *ShopID;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *range;

@end

@interface Mine_MyHouseKeep_Model : NSObject
/**
 address = "\U4e0a\U6d77\U516c\U5171\U4ea4\U901a\U5361\U670d\U52a1\U7ad9(\U8398\U5e84\U7ad9\U5206\U7ad9)";
 age = 18;
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1561346096497-2019-06-24.png";
 grade = 10;
 id = 2;
 label =         (
 "\U8001\U5b9e\U672c\U5206",
 "\U52e4\U594b\U80fd\U5e72"
 );
 latitude = "<null>";
 longitude = "<null>";
 phone = 15038607764;
 province = "\U4e0a\U6d77\U5e02";
 realname = "\U77f3\U5148\U751f";
 sex = 1;
 type = 3;
 */
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *HouseKeep_ID;
@property (nonatomic, strong) NSArray *label;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
