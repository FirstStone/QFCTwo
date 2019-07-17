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

NS_ASSUME_NONNULL_END
