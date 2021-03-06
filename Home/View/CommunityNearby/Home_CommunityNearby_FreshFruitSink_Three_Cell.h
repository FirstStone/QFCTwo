//
//  Home_CommunityNearby_FreshFruitSink_Three_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeCommunityNearbyFreshFruitSinkThreeCellDelegate <NSObject>

- (void)HomeCommunityNearbyFreshFruitSinkThreeCellImageLiftClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyFreshFruitSinkThreeCellMiddleImageClick:(NSString *) goodsid;
- (void)HomeCommunityNearbyFreshFruitSinkThreeCellRightImageClick:(NSString *) goodsid;

@end

@interface Home_CommunityNearby_FreshFruitSink_Three_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *LiftMoney_Label;
@property (strong, nonatomic) IBOutlet UILabel *MiddleMoney_Label;
@property (strong, nonatomic) IBOutlet UILabel *RightMoney_Label;

- (void)setLabelHiddle:(BOOL)Hiddle;


- (void)setDataSoureToCell:(NSMutableArray *)dataArray;

- (void)setDataSourefruitslistToCell:(NSMutableArray *)dataArray;

@property (nonatomic, assign) id <HomeCommunityNearbyFreshFruitSinkThreeCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
