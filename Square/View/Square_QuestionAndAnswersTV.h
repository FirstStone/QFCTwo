//
//  Square_QuestionAndAnswersTV.h
//  QFC
//
//  Created by tiaoxin on 2019/4/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Square_QuestionAndAnswersTV : Basic_TableView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, strong) NSString *item_ID;

- (void)LoadingDataSoure;

@end

NS_ASSUME_NONNULL_END
