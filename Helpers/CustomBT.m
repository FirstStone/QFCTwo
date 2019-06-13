//
//  CustomBT.m
//  eKang
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CustomBT.h"

@implementation CustomBT

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.Interval) {
        self.Interval = 0.0f;
    }
    if (!self.ImageTopTitleBottom_MultipliedBy) {
        self.ImageTopTitleBottom_MultipliedBy = 1.0f;
    }
    switch (self.BTStyle) {
        case ImageTopTitleBottom:
        {
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - CGRectGetWidth(self.frame) * self.ImageTopTitleBottom_MultipliedBy) / 2.0f, self.Interval, CGRectGetWidth(self.frame) * self.ImageTopTitleBottom_MultipliedBy, CGRectGetWidth(self.frame) * self.ImageTopTitleBottom_MultipliedBy);
            self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * (1.0f - self.ImageTopTitleBottom_MultipliedBy));
            /*[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(self.Interval);
                //        make.size.mas_offset(CGSizeMake(self.frame.size.height/3*2, self.frame.size.height/3*2));
                make.height.equalTo(self.mas_height).multipliedBy(self.ImageTopTitleBottom_MultipliedBy);
                make.width.equalTo(self.mas_height).multipliedBy(self.ImageTopTitleBottom_MultipliedBy);
                make.centerX.equalTo(self.mas_centerX);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                //        make.top.equalTo(self.imageView.mas_bottom);
                make.left.equalTo(self.mas_left);
                make.height.equalTo(self.mas_height).multipliedBy(1.0f - self.ImageTopTitleBottom_MultipliedBy);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
            }];*/
        }
            break;
        case ImageLeftTitleRight:
        {
            NSLog(@"%f=========%f",self.Interval, self.ImageORTitle_Interval);
            self.imageView.frame = CGRectMake(self.Interval, self.Interval, CGRectGetHeight(self.frame) - self.Interval * 2, CGRectGetHeight(self.frame) - self.Interval * 2);
            self.titleLabel.frame = CGRectMake(CGRectGetMaxY(self.imageView.frame) + self.ImageORTitle_Interval, 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.imageView.frame) - self.ImageORTitle_Interval, CGRectGetHeight(self.frame));
            /*[self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(self.Interval);
                make.bottom.equalTo(self.mas_bottom).offset(-self.Interval);
                make.left.equalTo(self.mas_left).offset(self.Interval);
                make.width.equalTo(self.mas_height).offset(- self.Interval * 2.0f);//.offset(- 4.0f);
            }];
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self.imageView.mas_right).offset(self.ImageORTitle_Interval);//.priorityHigh();
                make.right.equalTo(self.mas_right);
            }];*/
        }
            break;
        case ImageRightTitleLeft:
        {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(self.Interval);
                make.bottom.equalTo(self.mas_bottom).offset(-self.Interval);
                make.right.equalTo(self.mas_right).offset(-self.Interval);
                make.width.equalTo(self.mas_height).offset(- self.Interval * 2.0f);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.imageView.mas_left);
            }];
        }
            break;
        default:
            break;
    }
}

@end
