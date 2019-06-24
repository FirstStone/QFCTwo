//
//  Mine_HouseKeep_Service_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_HouseKeep_Service_Cell.h"

@interface Mine_HouseKeep_Service_Cell ()

@property (strong, nonatomic) IBOutlet UIButton *Lift_Button;

@property (strong, nonatomic) IBOutlet UIButton *Right_Button;


@end

@implementation Mine_HouseKeep_Service_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)LiftButtonClick:(id)sender {
    if ((self.Lift_Button.selected == YES) && (self.Right_Button.selected == NO)) {
        [MBProgressHUD py_showError:@"至少选择一种服务" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        self.Lift_Button.selected = !self.Lift_Button.selected;
        [self SetBackGroundColorTobutton];
        [self returnType];
    }
}

- (IBAction)RightButtonClick:(id)sender {
    if ((self.Right_Button.selected == YES) && (self.Lift_Button.selected == NO)) {
        [MBProgressHUD py_showError:@"至少选择一种服务" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        self.Right_Button.selected = !self.Right_Button.selected;
        [self SetBackGroundColorTobutton];
        [self returnType];
    }
}

- (void)returnType {
    if ([self.delegate respondsToSelector:@selector(MineHouseKeepServiceCellButtonClick:)]) {
        if (self.Lift_Button.selected && self.Right_Button.selected == NO) {
            [self.delegate MineHouseKeepServiceCellButtonClick:@"1"];
        }else if (self.Lift_Button.selected == NO && self.Right_Button.selected) {
            [self.delegate MineHouseKeepServiceCellButtonClick:@"2"];
        }else {
            [self.delegate MineHouseKeepServiceCellButtonClick:@"3"];
        }
    }
}

- (void)setDataSoureToCell:(Mine_MyHouseKeep_Model *)model {
    if ([model.type intValue] == 1) {
        self.Lift_Button.selected = YES;
        self.Right_Button.selected = NO;
    }else if ([model.type intValue] == 2) {
        self.Lift_Button.selected = NO;
        self.Right_Button.selected = YES;
        
    }else {
        self.Lift_Button.selected = YES;
        self.Right_Button.selected = YES;
    }
    [self SetBackGroundColorTobutton];
}

- (void)SetBackGroundColorTobutton {
    if (self.Lift_Button.selected == YES) {
        self.Lift_Button.backgroundColor = QFC_Color_30AC65;
    }else {
        self.Lift_Button.backgroundColor = QFC_Color_F5F5F5;
    }
    
    if (self.Right_Button.selected == YES) {
        self.Right_Button.backgroundColor = QFC_Color_30AC65;
    }else {
        self.Right_Button.backgroundColor = QFC_Color_F5F5F5;
    }
    
}

@end
