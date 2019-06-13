//
//  Square_HT_Details_First_Cell.h
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PYPhotosView;
@class Square_Details_Model;

@protocol SquareHTDetailsFirstCellDelegate <NSObject>


/**1 为关注按钮  2为收藏  3 顶   4为分享*/
- (void)SquareHTDetailsFirstCellButton:(NSInteger)index model:(Square_Details_Model *)model;

@end

@interface Square_HT_Details_First_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet PYPhotosView *Image_View;

- (void)setModelToCell:(Square_Details_Model *)model;


@property (nonatomic, assign) id <SquareHTDetailsFirstCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
