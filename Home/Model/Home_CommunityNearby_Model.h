//
//  Home_CommunityNearby_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_CommunityNearby_Model : NSObject

@property (nonatomic, strong) NSString *Type_name;
@property (nonatomic, strong) NSString *Style_id;
@property (nonatomic, strong) NSString *imgurl;


@end


@interface Home_CommunityNearby_Activity_Model : NSObject

@property (nonatomic, strong) NSString *activity_name;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *activity_price;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *activity_id;

@end
/**
 "goods_name": "青少年风衣男夏季韩版潮男中长款薄宽松学生防晒开衫男士外套披风",
 "id": 1,
 "goods_img": "https://www.kuaiyoushequ.com/uploads/fileimg/1557386938985-2019-05-09.jpg",
 "goods_unit": "件",
 "price": "100",
 "activity_price": "80",
 "sales_sum": 0,
 "wide": 468,
 "height": 702
 */
@interface Home_CommunityNearby_ActivityBranch_Model : NSObject
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_unit;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *activity_price;
@property (nonatomic, strong) NSString *sales_sum;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *Branch_id;
@property (nonatomic, strong) NSString *wide;
@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *distance;
@end


NS_ASSUME_NONNULL_END
