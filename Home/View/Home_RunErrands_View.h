//
//  Home_RunErrands_View.h
//  QFC
//
//  Created by tiaoxin on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeRunErrandsViewDelegate <NSObject>

- (void)AddressSelectItem:(Mine_SetUP_MyAddress_Model *)model Number:(NSInteger)number;

@end

@interface Home_RunErrands_View : UIView

@property (nonatomic, assign) NSInteger Number;

@property (nonatomic, strong) UINavigationController *Navigation;

@property (nonatomic, strong) UILabel *Title_Label;

@property (nonatomic, assign) id <HomeRunErrandsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
