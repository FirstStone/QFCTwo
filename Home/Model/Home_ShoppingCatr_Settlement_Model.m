//
//  Home_ShoppingCatr_Settlement_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShoppingCatr_Settlement_Model.h"

@implementation Home_ShoppingCatr_Settlement_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"goods" : [Home_ShoppingCatr_Settlement_Branch_Model class]};
}


@end


@implementation Home_ShoppingCatr_Settlement_Branch_Model

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
