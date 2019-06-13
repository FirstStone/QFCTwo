//
//  Home_CommunityNearby_Branch_CollectionView.h
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_CommunityNearby_Branch_CollectionView : UICollectionView
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UINavigationController *My_NAVC;

@property (nonatomic, strong) NSString *Type_ID;

- (void)LoadingDataSoure;

@end

NS_ASSUME_NONNULL_END
