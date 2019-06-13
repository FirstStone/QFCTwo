//
//  Square_ES_Header_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_ES_Header_Cell.h"

@interface Square_ES_Header_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *Image_View;
@property (weak, nonatomic) IBOutlet UILabel *Title_Label;
@property (weak, nonatomic) IBOutlet UILabel *Text_Label;



@end

@implementation Square_ES_Header_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setDataSoureTocell {
    self.Image_View.image = [UIImage imageNamed:@"icon_zuhang"];
}


@end
