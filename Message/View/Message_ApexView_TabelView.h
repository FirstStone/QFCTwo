//
//  Message_ApexView_TabelView.h
//  QFC
//
//  Created by tiaoxin on 2019/5/25.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_TableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message_ApexView_TabelView : Basic_TableView

/**
 *滑动菜单，选择的索引
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@end

NS_ASSUME_NONNULL_END
