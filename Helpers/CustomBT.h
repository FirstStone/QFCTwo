//
//  CustomBT.h
//  eKang
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, ButtonStyle) {
    //图片在上，标题在下
    ImageTopTitleBottom,
    //图片在左，标题在右
    ImageLeftTitleRight,
    //图片在右 标题在左
    ImageRightTitleLeft
};

@interface CustomBT : UIButton

@property (nonatomic, assign) ButtonStyle BTStyle;
/**间隔*/
@property (nonatomic, assign) CGFloat Interval;
/**图片与标题的间隔*/
@property (nonatomic, assign) CGFloat ImageORTitle_Interval;
/**ImageTopTitleBottom 图片大小相对于父视图大小的比例*/
@property (nonatomic, assign) CGFloat ImageTopTitleBottom_MultipliedBy;
@end

NS_ASSUME_NONNULL_END
