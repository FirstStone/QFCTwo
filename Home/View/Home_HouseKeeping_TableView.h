//
//  Home_HouseKeeping_TableView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_HouseKeeping_TableView : Basic_TableView
/**
 *滑动菜单，选择的索引
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@end

NS_ASSUME_NONNULL_END
