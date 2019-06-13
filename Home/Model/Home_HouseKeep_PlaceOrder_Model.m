//
//  Home_HouseKeep_PlaceOrder_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeep_PlaceOrder_Model.h"

@implementation Home_HouseKeep_PlaceOrder_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"PlaceOrder_ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"list" : [Home_HouseKeep_PlaceOrderBranch_Model class]};
}

@end


@implementation Home_HouseKeep_PlaceOrderBranch_Model
/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Branch_ID" : @"id"};
}

@end

@implementation Home_HouseKeep_PlaceOrderOrdinary_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"PlaceOrder_ID" : @"id"};
}

@end
