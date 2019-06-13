//
//  Mine_CV_Public_HeaderViewCRV.h
//  QFC
//
//  Created by tiaoxin on 2019/4/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MineCVPublicHeaderViewCRVDelegate <NSObject>

- (void)MineCVPublicHeaderViewCRVRightButtonChange:(NSInteger)ClickNumber;

@end

@interface Mine_CV_Public_HeaderViewCRV : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UILabel *Title_Lable;
@property (strong, nonatomic) IBOutlet UIButton *Right_BT;
@property (nonatomic, assign) NSInteger Header_Number;

@property (nonatomic, assign) id <MineCVPublicHeaderViewCRVDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
