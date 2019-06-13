//
//  Home_ShangQiang_CollectionViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/4.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShangQiang_CollectionViewCell.h"

@implementation Home_ShangQiang_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self = [[NSBundle mainBundle] loadNibNamed:@"Home_ShangQiang_CollectionViewCell" owner:self options:nil].lastObject;
    }
    return self;
}


@end
