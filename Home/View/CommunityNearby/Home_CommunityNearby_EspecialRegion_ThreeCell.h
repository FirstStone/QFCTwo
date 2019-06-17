//
//  Home_CommunityNearby_EspecialRegion_ThreeCell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeCommunityNearbyEspecialRegionThreeCellDelegate <NSObject>

- (void)HomeCommunityNearbyEspecialRegionThreeCellImageLiftClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyEspecialRegionThreeCellMiddleImageClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyEspecialRegionThreeCellRightImageClick:(NSString *) goodsid;

@end

@interface Home_CommunityNearby_EspecialRegion_ThreeCell : UITableViewCell

- (void)setDataSoureToCell:(NSMutableArray *)dataArray;

@property (nonatomic, assign) id <HomeCommunityNearbyEspecialRegionThreeCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
