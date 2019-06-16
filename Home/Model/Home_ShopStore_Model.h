//
//  Home_ShopStore_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_ShopStore_Model : NSObject

/**
 avatar = "https://www.txkuaiyou.com/uploads/fileimg/1560662426439-2019-06-16.png";
 beginbusiness = "06:00";
 business = 1;
 distance = "";
 endbusiness = "23:00";
 grade = 10;
 id = 2;
 merchant = "\U5bb6\U5bb6\U4e50\U852c\U679c\U5e97";
 */
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *beginbusiness;
@property (nonatomic, strong) NSString *business;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *endbusiness;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *Shop_id;
@property (nonatomic, strong) NSString *merchant;


@end

@interface Home_ShopStoreStyle_Model : NSObject
/*
 id = 1;
 names = "\U65b0\U9c9c\U852c\U83dc";
 */
@property (nonatomic, strong) NSString *Style_id;
@property (nonatomic, strong) NSString *names;


@end

@interface Home_ShopStore_Branch_Model : NSObject
/**
 "activity_price" = "0.00";
 "goods_img" = "https://www.txkuaiyou.com/uploads/fileimg/156043167978-2019-06-13.png";
 "goods_name" = "\U9999\U82b9";
 "goods_unit" = 500;
 id = 12;
 price = "2.90";
 "sales_sum" = 0;
 sum = 0;
 */

@property (nonatomic, strong) NSString *activity_price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_unit;
@property (nonatomic, strong) NSString *Goods_id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *sales_sum;
@property (nonatomic, strong) NSString *sum;

@end

NS_ASSUME_NONNULL_END
