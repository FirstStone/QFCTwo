//
//  Mine_OrderQrcode_View.m
//  QFC
//
//  Created by tiaoxin on 2019/6/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_OrderQrcode_View.h"

@interface Mine_OrderQrcode_View ()

@property (nonatomic, strong) UIImageView *image_View;

@property (nonatomic, strong) UIView *BackView;

@end

@implementation Mine_OrderQrcode_View

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPUI];
    }
    return self;
}

- (UIImageView *)image_View {
    if (!_image_View) {
        _image_View = [[UIImageView alloc] init];
    }
    return _image_View;
}

- (void)setUPUI {
    UITapGestureRecognizer *backViewZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backHiddle:)];
    [self addGestureRecognizer:backViewZer];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.frame = [UIScreen mainScreen].bounds;
    UIView *BackView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:BackView];
    [BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(200, 200));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [BackView addSubview:self.image_View];
    [self.image_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)backHiddle:(UIGestureRecognizer *)Zer {
    self.hidden = YES;
}

- (void)SetImageViewToCell:(NSString *)imageURL {
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

@end
