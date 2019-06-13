//
//  Mine_MyOrder_User_Tableview.h
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_TableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mine_MyOrder_User_Tableview : Basic_TableView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

- (void)TabelViewBeginDataSoure;

@end

NS_ASSUME_NONNULL_END
