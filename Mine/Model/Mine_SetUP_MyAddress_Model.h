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

NS_ASSUME_NONNULL_END
