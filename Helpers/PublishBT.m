//
//  PublishBT.m
//  QFC
//
//  Created by tiaoxin on 2019/5/21.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PublishBT.h"

@interface PublishBT ()

@end

@implementation PublishBT

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (UIButton *)Delect_BT {
    if (!_Delect_BT) {
        _Delect_BT = [[UIButton alloc] init];
        [_Delect_BT setImage:[UIImage imageNamed:@"icon_Login_QX"] forState:UIControlStateNormal];
    }
    return _Delect_BT;
}

- (void)setUPUI {
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 22.0f);
    [self addSubview:self.Delect_BT];
    [self.Delect_BT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(10.0f);
//        make.bottom.equalTo(self.mas_bottom).offset(-10.0f);
        make.right.equalTo(self.mas_right).offset(-10.0f);
//        make.width.offset(15.0f);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(12.0f, 12.0f));
    }];
}



@end
