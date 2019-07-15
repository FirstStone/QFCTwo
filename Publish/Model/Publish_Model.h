//
//  Publish_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/21.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Publish_Model : NSObject

/**
 id = 44;
 name = "\U989d\U5916\U4f46\U662f\U65e0\U6cd5";
 */
@property (nonatomic, strong) NSString *Publish_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL State;

@end

@interface Publish_Location_Model : NSObject
/**name*/
@property (nonatomic, strong) NSString *Name;
/**address*/
@property (nonatomic, strong) NSString *SubName;
@property (nonatomic, strong) NSString *latStr;
@property (nonatomic, strong) NSString *longStr;
/**省*/
@property (nonatomic, strong) NSString *Province;
/**市*/
@property (nonatomic, strong) NSString *City;
/**区*/
@property (nonatomic, strong) NSString *District;
@property (nonatomic, assign) BOOL State;

@end

NS_ASSUME_NONNULL_END
