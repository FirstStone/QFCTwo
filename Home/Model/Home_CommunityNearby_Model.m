//
//  Home_CommunityNearby_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Model.h"

@implementation Home_CommunityNearby_Model
/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Style_id" : @"id", @"Type_name" : @"typename"};
}

@end


@implementation Home_CommunityNearby_Activity_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"activity_id" : @"id"};
}

@end

@implementation Home_CommunityNearby_ActivityBranch_Model

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
