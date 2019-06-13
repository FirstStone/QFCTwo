//
//  SquareTitle_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/5.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SquareTitle_Model.h"

@implementation SquareTitle_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Title_ID" : @"id", @"Type_name" : @"typename"};
}

@end


@implementation SquareRecommend_Model
/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"SquareRecommend_ID" : @"id", @"Type_name" : @"typename"};
}

@end
