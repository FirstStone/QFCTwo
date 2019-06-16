//
//  Home_CommunityNearby_Branch_CollectionViewCell.h
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Home_CommunityNearby_ActivityBranch_Model;
@interface Home_CommunityNearby_Branch_CollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

- (void)setModelToCell:(Home_CommunityNearby_ActivityBranch_Model *)model;


@end

NS_ASSUME_NONNULL_END
