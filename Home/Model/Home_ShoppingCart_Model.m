//
//  Home_ShoppingCart_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCart_Model.h"

@implementation Home_ShoppingCart_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
///**key 值替换*/
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"City_id" : @"id"};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"goods" : [Home_ShoppingCart_Branch_Model class]};
}

@end

@implementation Home_ShoppingCart_Branch_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Branch_id" : @"id"};
}

@end
