//
//  Mine_Goods_Supervise_View.h
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    MineGoodsSuperviseAll,
    MineGoodsSuperviseUP,
    MineGoodsSuperviseDown,
} MineGoodsSuperviseStyle;

@interface Mine_Goods_Supervise_View : UIView
/**
 *滑动菜单，选择的索引
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, assign) MineGoodsSuperviseStyle mineGoodsSuperviseStyle;


- (void)UpDataUPButtonFram:(NSInteger)buttonTip;

- (void)TabelViewBeginDataSoure;
@end

NS_ASSUME_NONNULL_END
