//
//  Mine_CV_Public_HeaderViewCRV.m
//  QFC
//
//  Created by tiaoxin on 2019/4/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_CV_Public_HeaderViewCRV.h"

@implementation Mine_CV_Public_HeaderViewCRV

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)MinePublicHeaderViewRightButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineCVPublicHeaderViewCRVRightButtonChange:)]) {
        [self.delegate MineCVPublicHeaderViewCRVRightButtonChange:self.Header_Number];
    }
}




@end
