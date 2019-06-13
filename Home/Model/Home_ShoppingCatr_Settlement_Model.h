//
//  Home_ShoppingCatr_Settlement_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_ShoppingCatr_Settlement_Model : NSObject

/**
 "merchant_id": 1,
 "merchant": "鹅鹅鹅",
 "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1557209308150-2019-05-07.png",
 "sum_price": 199,
 "distance": 0,
 "goods": [
 */
@property (nonatomic, strong) NSString *merchant_id;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *sum_price;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, strong) NSString *RunPrice;
@property (nonatomic, strong) NSString *ShoppingId;
@property (nonatomic, strong) NSString *Remark;
@property (nonatomic, assign) BOOL DeliveryState;

@end

@interface Home_ShoppingCatr_Settlement_Branch_Model : NSObject
/**
 "id": 16,
 "goods_sum": 1,
 "specification": " 咖啡色 S 100% 纯棉",
 "goods_name": "UR2019夏季新品男装休闲日常拼色翻领T恤MF19S4EN2015款式简约，拼色翻领，适合日常搭配",
 "price": "199",
 "goods_img": "https://www.txkuaiyou.com/uploads/fileimg/1557803102435-2019-05-14.png",
 "goods_id": 28,
 "merchant_id": 1,
 "merchant": "鹅鹅鹅",
 "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1557209308150-2019-05-07.png"
 */
@property (nonatomic, strong) NSString *Branch_id;
@property (nonatomic, strong) NSString *goods_sum;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *merchant_id;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *avatar;

@end


NS_ASSUME_NONNULL_END
