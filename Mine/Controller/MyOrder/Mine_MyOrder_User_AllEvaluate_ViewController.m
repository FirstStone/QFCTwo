//
//  Mine_MyOrder_User_AllEvaluate_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/25.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_User_AllEvaluate_ViewController.h"
#define CellID_MineMyorderShopingAllEvaluateCell @"MineMyorderShopingAllEvaluateCell"
#define CellID_MineMyorderRunErrandsAllEvaluateCell @"MineMyorderRunErrandsAllEvaluateCell"
#define CellID_MineMyOrderHouseKeepingAllEvaluateCell @"MineMyOrderHouseKeepingAllEvaluateCell"
@interface Mine_MyOrder_User_AllEvaluate_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Mine_MyOrder_User_AllEvaluate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Myorder_RunErrands_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Myorder_Shoping_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;//self.dataArray.count;
  
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//跑腿
        Mine_Myorder_RunErrands_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
//         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
//        cell.scrollerView.originalUrls = []
        return cell;
    }else if(indexPath.row == 1){//跑腿
        Mine_Myorder_RunErrands_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else if (indexPath.row == 2 || indexPath.row == 3) {//商家
        Mine_Myorder_Shoping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else if (indexPath.row == 4){//商家
        Mine_Myorder_Shoping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
        cell.scrollerView.hidden = NO;
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
        //         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        //        cell.scrollerView.originalUrls = []
        return cell;
    }else if (indexPath.row == 5) {//家政
        Mine_MyOrder_HouseKeeping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else {//家政
        Mine_MyOrder_HouseKeeping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
        cell.scrollerView.hidden = NO;
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
        //         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        //        cell.scrollerView.originalUrls = []
        return cell;
    }
}



@end
