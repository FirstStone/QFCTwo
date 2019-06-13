//
//  Home_HouseKeep_PlaceOrder_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**家政深度清洁*/
@interface Home_HouseKeep_PlaceOrder_Model : NSObject
/*
 "id": 1,
 "names": "厨房",
 "list": [
 {
 "content": "单独厨卫",
 "id": 1,
 "price": "400.00"
 }
 ]
 */

@property (nonatomic, strong) NSString *PlaceOrder_ID;
@property (nonatomic, strong) NSString *names;
@property (nonatomic, strong) NSMutableArray *list;

@end

@interface Home_HouseKeep_PlaceOrderBranch_Model : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *Branch_ID;
@property (nonatomic, assign) BOOL Button_State;

@end
/**家政普通清洁*/
@interface Home_HouseKeep_PlaceOrderOrdinary_Model : NSObject
/**
 "content": "50平米以内",
 "times": 2,
 "price": "80.00",
 "id": 1
 */
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *PlaceOrder_ID;
@property (nonatomic, assign) BOOL Button_State;

@end

NS_ASSUME_NONNULL_END
