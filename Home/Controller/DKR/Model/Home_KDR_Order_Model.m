//
//  Home_KDR_Order_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/7/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Order_Model.h"

@implementation Home_KDR_Order_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Orderid" : @"id"};
}


@end
