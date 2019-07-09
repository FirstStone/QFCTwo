//
//  Home_KDR_Personal_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Personal_ViewController.h"

@interface Home_KDR_Personal_ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UIImageView *icon_View;

@property (strong, nonatomic) IBOutlet UIView *Tap_View;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Home_KDR_Personal_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 添加四边阴影效果
        // 阴影颜色
    self.Tap_View.layer.shadowColor = QFC_Color_Six.CGColor;
    // 阴影偏移，默认(0, -3)
    self.Tap_View.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    self.Tap_View.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    self.Tap_View.layer.shadowRadius = 5;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
}

- (IBAction)LiftBtuuonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
