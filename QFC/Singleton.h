//
//  Singleton.h
//  QFC
//
//  Created by tiaoxin on 2019/5/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

+ (instancetype)sharedSingleton;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;
- (id)copyWithZone:(nullable NSZone *)zone;
- (id)mutableCopyWithZone:(nullable NSZone *)zone;

/*
 "password": "77d3b7ed9db7d236b9eac8262d27f6a5",
 "salt": 123,
 "id": 1,
 "nickname": "假装很帅",
 "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "type_id": 3,
 "address": "上海漕河泾开发区松江高科技园26号楼",
 "soleid": 666666,
 "audit": 2
 */
@property (nonatomic, strong) NSString *salt;
/**用户ID*/
@property (nonatomic, strong) NSString *Mid;
/**用户昵称*/
@property (nonatomic, strong) NSString *nickname;
/**用户头像*/
@property (nonatomic, strong) NSString *avatar;
/**用户类型  0普通 1 跑腿 2家政 3商家 4快代扔*/
@property (nonatomic, strong) NSString *type_id;
/**用户地址*/
@property (nonatomic, strong) NSString *address;
/**用户显示的ID*/
@property (nonatomic, strong) NSString *soleid;
/**审核状态。1审核通过 2待审核 3审核未通过*/
@property (nonatomic, strong) NSString *audit;
/**性别*/
@property (nonatomic, strong) NSString *sex;
/**二维码*/
@property (nonatomic, strong) NSString *qrcode;
/**关注*/
@property (nonatomic, strong) NSString *attention_sum;
/**发布*/
@property (nonatomic, strong) NSString *plaza_sum;
/**收藏*/
@property (nonatomic, strong) NSString *collect_sum;
/**余额*/
@property (nonatomic, strong) NSString *balance;
#pragma mark----定位
/**经度*/
@property (nonatomic, strong) NSString *longitude;
/**纬度*/
@property (nonatomic, strong) NSString *latitude;
/**定位地址*/
@property (nonatomic, strong) NSString *formattedAddress;
/**定位城市*/
@property (nonatomic, strong) NSString *City;
/**手机号*/
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSDictionary *weiXinIfon;

@end

NS_ASSUME_NONNULL_END
