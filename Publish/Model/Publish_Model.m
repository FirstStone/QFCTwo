//
//  Publish_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/21.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Publish_Model.h"

@implementation Publish_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Publish_id" : @"id"};
}

@end

@implementation Publish_Location_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end
