//
//  Home_KDRState_View.m
//  QFC
//
//  Created by tiaoxin on 2019/7/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDRState_View.h"

@interface Home_KDRState_View ()
@property (nonatomic, assign) CGFloat multiple;

@end

@implementation Home_KDRState_View


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CALayer *animationLayer = [CALayer layer];
    CABasicAnimation *animation = [self scaleAnimation];
    
    // 新建一个动画 Layer，将动画添加上去
    CALayer *pulsingLayer = [self pulsingLayer:rect animation:animation];
    
    //将动画 Layer 添加到 animationLayer
    [animationLayer addSublayer:pulsingLayer];
    
    [self.layer addSublayer:animationLayer];
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(_multiple);
    scaleAnimation.beginTime = CACurrentMediaTime();
    scaleAnimation.duration = 3;
    scaleAnimation.repeatCount = HUGE;// 重复次数设置为无限
    return scaleAnimation;
}

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CABasicAnimation *)animation {
    CALayer *pulsingLayer = [CALayer layer];
    
    pulsingLayer.borderWidth = 0.5;
    pulsingLayer.borderColor = [UIColor blackColor].CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animation forKey:@"plulsing"];
    
    return pulsingLayer;
}

@end
