//
//  Square_Tableview.h
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Square_Tableview : Basic_TableView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, strong) NSString *Style_id;

- (void)LoadingDataSoure;

@end

NS_ASSUME_NONNULL_END
