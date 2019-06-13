//
//  Message_FansList_Model.m
//  QFC
//
//  Created by tiaoxin on 2019/5/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_FansList_Model.h"

@implementation Message_FansList_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Fans_id" : @"id"};
}


@end

@implementation Message_Apex_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Apex_id" : @"id"};
}

@end

@implementation Message_Comment_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Comment_id" : @"id"};
}

@end

@implementation Message_RunErrands_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"RunErrands_id" : @"id"};
}

@end


@implementation Message_Shoping_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Shoping_id" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"goods" : [Message_Shoping_Branch_Model class]};
}

@end


@implementation Message_Shoping_Branch_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end


@implementation Message_Housekeeping_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}
/**key 值替换*/
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Housekeeping_id" : @"id"};
}


@end

@implementation Message_infromLists_Model

/**空替换为空字符串*/
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end
