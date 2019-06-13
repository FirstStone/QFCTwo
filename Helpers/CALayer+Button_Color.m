//
//  CALayer+Button_Color.m
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "CALayer+Button_Color.h"
#import <UIKit/UIKit.h>
@implementation CALayer (Button_Color)


- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


@end
