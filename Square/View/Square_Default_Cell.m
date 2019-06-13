//
//  Square_Default_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_Default_Cell.h"

@interface Square_Default_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_View;


@end

@implementation Square_Default_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick:)];
    [self.icon_View addGestureRecognizer:tapZer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)iconImageViewClick:(UIGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(iconViewClick:)]) {
        [self.delegate iconViewClick:@"111111"];
    }
}



@end
