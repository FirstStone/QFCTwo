//
//  Home_CommunityNearby_FirstEnjoy_ThreeCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeCommunityNearbyFirstEnjoyThreeCellDelegate <NSObject>

- (void)HomeCommunityNearbyFirstEnjoyThreeCellLiftImageClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyFirstEnjoyThreeCellMiddleImageClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyFirstEnjoyThreeCellRightImageClick:(NSString *) goodsid;

@end

@interface Home_CommunityNearby_FirstEnjoy_ThreeCell : UITableViewCell

- (void)setDataSoureToCell:(NSMutableArray *)dataArray;

@property (nonatomic, assign) id <HomeCommunityNearbyFirstEnjoyThreeCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
