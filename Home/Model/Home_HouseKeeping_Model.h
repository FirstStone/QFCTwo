//
//  Home_HouseKeeping_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_HouseKeeping_Model : NSObject
/*
 age = 25;
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1557221168402-2019-05-07.png";
 grade = 10;
 id = 1;
 province = "\U4e0a\U6d77\U5e02";
 realname = "\U2018\U7ecf\U6d4e";
 sex = 1;
 */
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *HouseKeeping_id;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *one;
@property (nonatomic, strong) NSString *two;
@property (nonatomic, strong) NSString *labelone;
@property (nonatomic, strong) NSString *labeltwo;
@end

NS_ASSUME_NONNULL_END
