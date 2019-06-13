//
//  Mine_Follow_Publish_Collection_Tableview.h
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MineTableViewFollow,
    MineTableViewPublish,
    MineTableViewCollection,
} MineTableViewStyle;

@interface Mine_Follow_Publish_Collection_Tableview : Basic_TableView

@property (nonatomic, assign) MineTableViewStyle MineStyle;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

- (void)TabelViewBeginDataSoure;

@end

NS_ASSUME_NONNULL_END
