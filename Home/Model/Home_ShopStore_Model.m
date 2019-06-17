//
//  Home_ShopStore_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_Model.h"

@implementation Home_ShopStore_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Shop_id" : @"id"};
}

@end

@implementation Home_ShopStoreStyle_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Style_id" : @"id"};
}


@end


@implementation Home_ShopStore_Branch_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Goods_id" : @"id"};
}

@end

@implementation Home_ShopStore_Total_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end
