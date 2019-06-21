//
//  Mine_BeginAnd_EndTimeCell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_BeginAnd_EndTimeCell.h"

@interface Mine_BeginAnd_EndTimeCell ()

@property (strong, nonatomic) IBOutlet UILabel *Begin_Label;

@property (strong, nonatomic) IBOutlet UILabel *End_Label;

@end

@implementation Mine_BeginAnd_EndTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *BeginZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LableClick:)];
    [self.Begin_Label addGestureRecognizer:BeginZer];
    
    UITapGestureRecognizer *EndZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(EndClick:)];
    [self.End_Label addGestureRecognizer:EndZer];
}

- (void)LableClick:(UITapGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(MineBeginAndEndTimeCellLabelClick:)]) {
        [self.delegate MineBeginAndEndTimeCellLabelClick:1];
    }
}

- (void)EndClick:(UITapGestureRecognizer *)Zer {
    if ([self.delegate respondsToSelector:@selector(MineBeginAndEndTimeCellLabelClick:)]) {
        [self.delegate MineBeginAndEndTimeCellLabelClick:2];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Mine_MyShopStore_Model *)model {
    self.Begin_Label.text = model.beginbusiness;
    self.End_Label.text = model.endbusiness;
}

@end
