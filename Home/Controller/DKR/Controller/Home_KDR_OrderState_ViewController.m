//
//  Home_KDR_OrderState_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_OrderState_ViewController.h"

@interface Home_KDR_OrderState_ViewController ()

@property (strong, nonatomic) IBOutlet UIView *contView;

@property (nonatomic, strong) UIView *icon_View;

@property (nonatomic, strong) Home_KDRState_View *BackView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *Tip_Label;

@property (nonatomic, strong) UIButton *Sure_BT;

@end

@implementation Home_KDR_OrderState_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contView addSubview:self.BackView];
    //第一步，通过UIBezierPath设置圆形的矢量路径
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contView.centerX - 75.0f, self.contView.centerY-350, 150, 150)];
    
    //第二步，用CAShapeLayer沿着第一步的路径画一个完整的环（颜色灰色，起始点0，终结点1）
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = CGRectMake(0, 0, 150, 150);//设置Frame
//    bgLayer.position = self.contView.center;//居中显示
    bgLayer.fillColor = [UIColor whiteColor].CGColor;//填充颜色=透明色
    bgLayer.lineWidth = 10.f;//线条大小
    bgLayer.strokeColor = QFC_Color_09D15A.CGColor;//线条颜色
    bgLayer.strokeStart = 0.f;//路径开始位置
    bgLayer.strokeEnd = 1.f;//路径结束位置
    bgLayer.path = circle.CGPath;//设置bgLayer的绘制路径为circle的路径
    [self.contView.layer addSublayer:bgLayer];//添加到屏幕上
    [self.contView addSubview:self.icon_View];
    [self.icon_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(20.0f, 20.0f));
    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //设置动画属性，因为是沿着贝塞尔曲线动，所以要设置为position
    animation.keyPath = @"position";
    //设置动画时间
    animation.duration = 3;
    // 告诉在动画结束的时候不要移除
    animation.removedOnCompletion = NO;
    // 始终保持最新的效果
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationPaced;
    animation.repeatCount = HUGE;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    // 设置贝塞尔曲线路径
    animation.path = circle.CGPath;
//    animation.
    // 将动画对象添加到视图的layer上
    [self.icon_View.layer addAnimation:animation forKey:nil];
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_offset(self.contView.centerX - 75.0f);
//        make.centerY.mas_offset(self.contView.centerY-350);
        make.left.offset(self.contView.centerX - 75.0f);
        make.top.offset(self.contView.centerY-350);
        make.size.mas_offset(CGSizeMake(150.0f, 150.0f));
    }];
    [self.contView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.BackView);
        make.centerY.equalTo(self.BackView);
        make.size.mas_offset(CGSizeMake(60.0f, 60.0f));
    }];
    [self.contView addSubview:self.Tip_Label];
    [self.Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left).offset(20.0f);
        make.right.equalTo(self.contView.mas_right).offset(-20.0f);
        make.top.mas_offset(self.contView.centerY - 60.0f);
    }];
    [self.contView addSubview:self.Sure_BT];
    [self.Sure_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30.0f);
        make.left.equalTo(self.contView.mas_left).offset(20.0f);
        make.right.equalTo(self.contView.mas_right).offset(-20.0f);
        make.top.equalTo(self.Tip_Label.mas_bottom).offset(30.0f);
    }];
    [self setDataDoureToself:self.State];
}

- (void)setDataDoureToself:(NSInteger)state {
    switch (state) {
        case 0:
        {
            self.Tip_Label.text = @"等待服务人员接单中...";
            self.imageView.image = [UIImage imageNamed:@"icon_KDR_Daijiedan"];
            [self.Sure_BT setTitle:@"返回首页" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.Tip_Label.text = @"服务人员已接单，正在赶来的路上,请 耐心等待哦~";
            self.imageView.image = [UIImage imageNamed:@"icon_KDR_daifuwu"];
            [self.Sure_BT setTitle:@"前往订单" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.Tip_Label.text = @"订单已完成，请尽快确认完成哦~";
            self.imageView.image = [UIImage imageNamed:@"icon_KDR_wancheng"];
            [self.Sure_BT setTitle:@"确认完成" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}


- (IBAction)LiftButtonPOP:(id)sender {
    NSArray *viewcongtrollers = self.navigationController.viewControllers;
    if (self.Number == 1) {
        [self.navigationController popToViewController:viewcongtrollers[1]  animated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UILabel *)Tip_Label {
    if (!_Tip_Label){
        _Tip_Label = [[UILabel alloc] init];
        _Tip_Label.textColor = QFC_Color_333333;
        _Tip_Label.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightBold];
        _Tip_Label.textAlignment = NSTextAlignmentCenter;
    }
    return _Tip_Label;
}

- (UIButton *)Sure_BT {
    if (!_Sure_BT) {
        _Sure_BT = [[UIButton alloc] init];
//        [_Sure_BT setTitle:@"返回首页" forState:UIControlStateNormal];
        _Sure_BT.backgroundColor = QFC_Color_09D15A;
        [_Sure_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Sure_BT.layer.cornerRadius = 15.0f;
        [_Sure_BT addTarget:self action:@selector(surebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Sure_BT;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.image = [UIImage imageNamed:@"icon_KDR_daifuwu"];
    }
    return _imageView;
}

- (UIView *)icon_View {
    if (!_icon_View) {
        _icon_View = [[UIView alloc] init];
        _icon_View.backgroundColor = [UIColor whiteColor];
        _icon_View.layer.borderWidth = 1.0f;
        _icon_View.layer.borderColor = QFC_Color_09D15A.CGColor;
        _icon_View.layer.cornerRadius = 10.0f;
    }
    return _icon_View;
}

- (Home_KDRState_View *)BackView {
    if (!_BackView) {
        _BackView = [[Home_KDRState_View alloc] init];
//        _BackView.backgroundColor = [UIColor orangeColor];
    }
    return _BackView;
}

- (void)surebuttonClick {
    switch (self.State) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            Home_KDR_Order_ViewController *KDRVC = [[Home_KDR_Order_ViewController alloc] init];
            [KDRVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:KDRVC animated:YES];
        }
            break;
        case 2:
        {
            [self POSTWasteOrderOrderAffirm];
        }
            break;
        default:
            break;
    }
}

- (void)POSTWasteOrderOrderAffirm {
    /**
     waste/order/orderAffirm
     uid
     orderid
     确认完成 用户
     */
    self.Sure_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteOrderOrderAffirm parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        self.Sure_BT.userInteractionEnabled = YES;
        NSLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
//        }else {
//            [MBProgressHUD py_showError:@"操作失败" toView:nil];
//            [MBProgressHUD setAnimationDelay:0.7f];
//        }
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
