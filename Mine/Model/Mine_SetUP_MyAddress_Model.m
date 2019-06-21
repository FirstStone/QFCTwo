//
//  Mine_SetUP_MyAddress_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_MyAddress_Model.h"

@implementation Mine_SetUP_MyAddress_Model



/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"MyAddress_id" : @"id"};
}


@end

@implementation Mine_UserMessage_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"User_id" : @"id"};
}

@end


@implementation Mine_MyShopStore_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ShopID" : @"id"};
}

@end
