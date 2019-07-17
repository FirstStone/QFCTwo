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

// 设置静态常量 pulsingCount ，表示 Layer 的数量
static NSInteger const pulsingCount = 2;
// 设置静态常量 animationDuration ，表示动画时间
static double const animationDuration = 4;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiple = 1.734;;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CALayer *animationLayer = [CALayer layer];
    
    for (int i = 0; i < pulsingCount; i ++) {
        // 这里同时创建[缩放动画、背景色渐变、边框色渐变]三个简单动画
        NSArray *animationArray = [self animationArray];
        // 将三个动画合并为一个动画组
        CAAnimationGroup *animationGroup = [self animationGroupAnimations:animationArray index:i];
//    CAAnimationGroup *animationGroup = [self animationGroupAnimations:animationArray];
    
        //修改方法，将原先添加的动画由“简单动画”改为“动画组”
        CALayer *pulsingLayer = [self pulsingLayer:rect animation:animationGroup];
        
        //将动画 Layer 添加到 animationLayer
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
    
    
    
    
    
    /*CABasicAnimation *animation = [self scaleAnimation];
    
    // 新建一个动画 Layer，将动画添加上去
    CALayer *pulsingLayer = [self pulsingLayer:rect animation:animation];
    
    //将动画 Layer 添加到 animationLayer
    [animationLayer addSublayer:pulsingLayer];
    
    [self.layer addSublayer:animationLayer];*/
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(_multiple);
//    scaleAnimation.beginTime = CACurrentMediaTime();
//    scaleAnimation.duration = 3;
//    scaleAnimation.repeatCount = HUGE;// 重复次数设置为无限
    return scaleAnimation;
}

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CAAnimationGroup *)animationGroup {
    CALayer *pulsingLayer = [CALayer layer];
    
//    pulsingLayer.borderWidth = 0.5;
//    pulsingLayer.borderColor = QFC_RColor(9,209,90, 0.5).CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
    return pulsingLayer;
}

/*- (CALayer *)pulsingLayer:(CGRect)rect animation:(CABasicAnimation *)animation {
    CALayer *pulsingLayer = [CALayer layer];
    
    pulsingLayer.borderWidth = 10;
    pulsingLayer.borderColor = QFC_RColor(9,209,90, 0.3).CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animation forKey:@"plulsing"];
    
    return pulsingLayer;
}*/

- (NSArray *)animationArray {
    NSArray *animationArray = nil;
    
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CAKeyframeAnimation *borderColorAnimation = [self borderColorAnimation];
    CAKeyframeAnimation *backgroundColorAnimation = [self backgroundColorAnimation];
    animationArray = @[scaleAnimation, backgroundColorAnimation, borderColorAnimation];
    
    return animationArray;
}

- (CAKeyframeAnimation *)borderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    
    borderColorAnimation.keyPath = @"borderColor";//9, 209, 90  //255, 216, 87 // 255, 231, 152 // 255, 241, 197
    borderColorAnimation.values = @[(__bridge id)QFC_RColor(9, 209, 90, 0.3).CGColor,
                                    (__bridge id)QFC_RColor(9, 209, 90, 0.2).CGColor,
                                    (__bridge id)QFC_RColor(9, 209, 90, 0.1).CGColor,
                                    (__bridge id)QFC_RColor(9, 209, 90, 0).CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}

// 使用关键帧动画，使得颜色动画不要那么的线性变化
- (CAKeyframeAnimation *)backgroundColorAnimation {
    CAKeyframeAnimation *backgroundColorAnimation = [CAKeyframeAnimation animation];
    
    backgroundColorAnimation.keyPath = @"backgroundColor";
    backgroundColorAnimation.values = @[(__bridge id)QFC_RColor(9, 209, 90, 0.3).CGColor,
                                        (__bridge id)QFC_RColor(9, 209, 90, 0.2).CGColor,
                                        (__bridge id)QFC_RColor(9, 209, 90, 0.1).CGColor,
                                        (__bridge id)QFC_RColor(9, 209, 90, 0).CGColor];
    backgroundColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return backgroundColorAnimation;
}

- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 3;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}


- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array index:(int)index {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.beginTime = CACurrentMediaTime() + (double)(index * animationDuration) / (double)pulsingCount;
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    return animationGroup;
}

@end
