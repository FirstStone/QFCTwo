//
//  NotDataSoureVC.m
//  QFC
//
//  Created by tiaoxin on 2019/7/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NotDataSoureVC.h"

@interface NotDataSoureVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) XKEmptyPlaceView *emptyView;

@end

@implementation NotDataSoureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    _emptyView = [XKEmptyPlaceView configScrollView:self.tableView config:nil];
    [_emptyView showWithImgName:@"加载失败" title:@"无法获取网络" des:@"点击屏幕重试" tapClick:^{
        //        [weakSelf.emptyView hide];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}


@end
