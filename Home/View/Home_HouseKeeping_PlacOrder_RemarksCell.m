//
//  Home_HouseKeeping_PlacOrder_RemarksCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_PlacOrder_RemarksCell.h"

@interface Home_HouseKeeping_PlacOrder_RemarksCell ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *text_Field;

@end

@implementation Home_HouseKeeping_PlacOrder_RemarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.text_Field.delegate = self;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyBoard) name:@"" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(textFieldText:)]) {
        [self.delegate textFieldText:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.text_Field resignFirstResponder];
    return YES;
}
- (void)setTextToTextField:(NSString *)string {
    self.text_Field.text = string;
}

- (void)dismissKeyBoard {
    [self.text_Field resignFirstResponder];
}



@end
