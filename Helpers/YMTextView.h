//
//  YMTextView.h
//  LStar
//
//  Created by JIN CHAO on 2017/7/20.
//  Copyright © 2017年 於建光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;
@end
