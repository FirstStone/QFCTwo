//
//  Mine_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_ViewController.h"
#define CellID_MineCVHeaderViewCRV @"MineCVHeaderViewCRV"
#define CellID_MineCVTopImageDownLabelCell  @"MineCVTopImageDownLabelCell"
#define CellID_MineCVPublicHeaderViewCRV @"MineCVPublicHeaderViewCRV"
#define CellID_MineCVShopStyleCell @"MineCVShopStyleCell"
#define CellID_Mine_FooterView @"UICollectionReusableViewFooter"

@interface Mine_ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MineCVPublicHeaderViewCRVDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *SectionTitle_Array;

@property (nonatomic, strong) NSArray *MyOrderTitle_Array;
@property (nonatomic, strong) NSArray *MyOrderIcon_Array;

@property (nonatomic, strong) NSArray *ShopTitle_Array;
@property (nonatomic, strong) NSArray *ShopIcon_Array;
@property (nonatomic, strong) NSArray *ShopDownTitle_Array;

@property (nonatomic, strong) NSArray *CardTitle_Array;
@property (nonatomic, strong) NSArray *CardIcon_Array;

@property (nonatomic, strong) NSArray *FindTitle_Array;
@property (nonatomic, strong) NSArray *FindIcon_Array;

@property (nonatomic, assign) BOOL ShopHiddle;

@end

@implementation Mine_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ShopHiddle = YES;
    self.SectionTitle_Array = @[@"我的钱柜", @"我的订单  ",@"卡券中心  " ,@"发现更多  "];
    self.MyOrderTitle_Array = @[@"待付款", @"待接单", @"待完成", @"评价", @"退款/售后"];
    self.MyOrderIcon_Array = @[@"icon_WD_daifukuan", @"icon_WD_daijiedan", @"icon_WD_daiwancheng", @"icon_WD_pingjia", @"icon_WD_shouhou"];
    
    
    self.ShopTitle_Array = @[@"我的商品", @"我的活动", @"我的卡券"];
    self.ShopIcon_Array = @[@"icon_WD_shangpin", @"icon_WD_huodong", @"icon_WD_kajuan"];
    self.ShopDownTitle_Array = @[@"  发布商品  ", @"  发布活动  ", @"  发布卡券  "];
    
    
    self.CardTitle_Array = @[@"店铺券", @"商品券", @"代金券"];
    self.CardIcon_Array = @[@"icon_WD_DPQ", @"icon_WD_SPQ", @"icon_WD_DJQ"];
    self.FindTitle_Array = @[@"使用帮助", @"快速入驻", @"在线客服"];
    self.FindIcon_Array = @[@"icon_WD_SYBZ", @"icon_WD_KSRZ", @"icon_WD_ZXKF"];
    [self setUPUI];
    [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self LoadingDataSoure];
    }else {
        self.ShopHiddle = YES;
        self.SectionTitle_Array = @[@"我的钱柜", @"我的订单  ",@"卡券中心  " ,@"发现更多  "];
        self.FindTitle_Array = @[@"使用帮助", @"快速入驻", @"在线客服"];
        self.FindIcon_Array = @[@"icon_WD_SYBZ", @"icon_WD_KSRZ", @"icon_WD_ZXKF"];
        [self.collectionView reloadData];
    }
}

- (void)setUPUI {
    [self.collectionView registerClass:[Mine_CV_TopImageDownLabel_Cell class] forCellWithReuseIdentifier:CellID_MineCVTopImageDownLabelCell];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellID_Mine_FooterView];
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_CV_TopImageDownLabel_Cell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellID_MineCVTopImageDownLabelCell];
      [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_CV_Shop_Style_Cell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellID_MineCVShopStyleCell];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_CV_HeaderViewCRV class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellID_MineCVHeaderViewCRV];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_CV_Public_HeaderViewCRV class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellID_MineCVPublicHeaderViewCRV];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark----UICollectionViewDelegate
//每一组section有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {//我的钱柜
        return 0;
    }else if (section == 1){//我的订单
        return self.MyOrderIcon_Array.count;
    }else {//商家必备//卡券中心//发现更多
        return 3;
    }
}
//返回多少个Sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.ShopHiddle) {
         return 4;
    } else {
         return 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ShopHiddle) {
            Mine_CV_TopImageDownLabel_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID_MineCVTopImageDownLabelCell forIndexPath:indexPath];
            if (indexPath.section == 1) {//我的订单
                cell.Text_Label.text = self.MyOrderTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.MyOrderIcon_Array[indexPath.row]];
            }else if (indexPath.section == 2) {//卡券中心
                cell.Text_Label.text = self.CardTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.CardIcon_Array[indexPath.row]];
            }else {//发现更多
                cell.Text_Label.text = self.FindTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.FindIcon_Array[indexPath.row]];
            }
            return cell;
    } else {
        if (indexPath.section == 2){//商家必备
            Mine_CV_Shop_Style_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID_MineCVShopStyleCell forIndexPath:indexPath];
            cell.Title_Label.text = self.ShopTitle_Array[indexPath.row];
            cell.Icon_imageView.image = [UIImage imageNamed:self.ShopIcon_Array[indexPath.row]];
            [cell.Down_Button setTitle:self.ShopDownTitle_Array[indexPath.row] forState:UIControlStateNormal];
            return cell;
        } else {
            Mine_CV_TopImageDownLabel_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID_MineCVTopImageDownLabelCell forIndexPath:indexPath];
            if (indexPath.section == 1) {//我的订单
                cell.Text_Label.text = self.MyOrderTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.MyOrderIcon_Array[indexPath.row]];
            }else if (indexPath.section == 3) {//卡券中心
                cell.Text_Label.text = self.CardTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.CardIcon_Array[indexPath.row]];
            }else {//发现更多
                cell.Text_Label.text = self.FindTitle_Array[indexPath.row];
                cell.icon_View.image = [UIImage imageNamed:self.FindIcon_Array[indexPath.row]];
            }
            
            return cell;
        }
    }
}

//设置item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return CGSizeMake((SCREEN_WIDTH - 20)/5.0f, (SCREEN_WIDTH - 20)/5.0f);
    }else  {//return CGSizeMake((SCREEN_WIDTH - 20)/5.0f, (SCREEN_WIDTH - 20)/5.0f);
        return CGSizeMake((SCREEN_WIDTH - 20)/3.0f, (SCREEN_WIDTH - 20)/3.0f);
    }
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            Mine_CV_HeaderViewCRV *FirstVC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellID_MineCVHeaderViewCRV forIndexPath:indexPath];
            FirstVC.My_NVC = self.navigationController;
            
            return FirstVC;
        }else {// if (indexPath.section == 1)
            Mine_CV_Public_HeaderViewCRV *SecondVC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellID_MineCVPublicHeaderViewCRV forIndexPath:indexPath];
            SecondVC.Header_Number = indexPath.section;
            SecondVC.delegate = self;
            SecondVC.Title_Lable.text = self.SectionTitle_Array[indexPath.section];
            if (self.ShopHiddle) {//隐藏商家
                if (indexPath.section == 1) {
                    [SecondVC.Right_BT setTitle:@"查看全部订单" forState:UIControlStateNormal];
                }else if (indexPath.section == 3) {
                    SecondVC.Right_BT.hidden = YES;
                } else {
                    SecondVC.Right_BT.hidden = YES;
//                    [SecondVC.Right_BT setTitle:@"查看更多" forState:UIControlStateNormal];
                }
            } else {
                if (indexPath.section == 1) {
                    SecondVC.Right_BT.hidden = NO;
                    [SecondVC.Right_BT setTitle:@"查看全部订单" forState:UIControlStateNormal];
                }else if (indexPath.section == 4) {
                    SecondVC.Right_BT.hidden = YES;
                }else {
                    SecondVC.Right_BT.hidden = YES;
//                    [SecondVC.Right_BT setTitle:@"查看更多" forState:UIControlStateNormal];
                }
            }
            return SecondVC;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *SecondVC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellID_Mine_FooterView forIndexPath:indexPath];
        SecondVC.backgroundColor = QFC_BackColor_Gray;
        return SecondVC;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 300.0f);//200.0f
    }else {
        return CGSizeMake(SCREEN_WIDTH, 40.0f);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 10.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        if (self.ShopHiddle) {//隐藏商家
            switch (indexPath.section) {
                case 1://我的订单
                    {
                        if (indexPath.row == 0) {//家政我的订单跳转
                            if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                                Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                                orderVC.Number = 1;
                                [orderVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:orderVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                                Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                                runErrandsVC.Number = 1;
                                [runErrandsVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:runErrandsVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                                Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                                houseKeepingVC.Number = 1;
                                [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:houseKeepingVC animated:YES];
                                
                            }else {//商家
                                Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                                shopVC.Number = 1;
                                [shopVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:shopVC animated:YES];
                                
                            }
                            
                        }else if (indexPath.row == 1) {//跑腿我的订单跳转
                            if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                                Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                                orderVC.Number = 2;
                                [orderVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:orderVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                                Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                                runErrandsVC.Number = 2;
                                [runErrandsVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:runErrandsVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                                Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                                houseKeepingVC.Number = 2;
                                [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:houseKeepingVC animated:YES];
                                
                            }else {//商家
                                Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                                shopVC.Number = 2;
                                [shopVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:shopVC animated:YES];
                                
                            }
                            
                        }else if (indexPath.row == 2) {//商家我的订单 跳转
                            if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                                Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                                orderVC.Number = 3;
                                [orderVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:orderVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                                Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                                runErrandsVC.Number = 3;
                                [runErrandsVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:runErrandsVC animated:YES];
                                
                            }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                                Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                                houseKeepingVC.Number = 3;
                                [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:houseKeepingVC animated:YES];
                                
                            }else {//商家
                                Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                                shopVC.Number = 3;
                                [shopVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:shopVC animated:YES];
                                
                            }
                            
                        }else if (indexPath.row == 3) {//评论
                                Mine_MyOrder_UserEvaluateViewController *evaluateVC = [[Mine_MyOrder_UserEvaluateViewController alloc] init];
                                [evaluateVC setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:evaluateVC animated:YES];

//                            Mine_MyOrder_Evaluate_ViewController *evaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
//                            [evaluateVC setHidesBottomBarWhenPushed:YES];
//                            [self.navigationController pushViewController:evaluateVC animated:YES];
                            
                        }else if (indexPath.row == 4) {//普通用户跳转
                            Mine_MyOrder_User_Service_ViewController *serviceVC = [[Mine_MyOrder_User_Service_ViewController alloc] init];
                            [serviceVC setHidesBottomBarWhenPushed:YES];
                            [self.navigationController pushViewController:serviceVC animated:YES];
                        }
                    }
                    break;
                case 2://卡券中心
                {
                    if (indexPath.row == 0) {//店铺券
                        Mine_ShopCard_ViewController *ShopCardVC = [[Mine_ShopCard_ViewController alloc] init];
                        [ShopCardVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:ShopCardVC animated:YES];
                        
                    }else if (indexPath.row == 1) {//商品券
                        Mine_GoodsCard_ViewController *GoodsCardVC = [[Mine_GoodsCard_ViewController alloc] init];
                        [GoodsCardVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:GoodsCardVC animated:YES];
                        
                    }else {//代金券
                        Mine_Vouchers_ViewController *VouchersVC = [[Mine_Vouchers_ViewController alloc] init];
                        [VouchersVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:VouchersVC animated:YES];
                    }
                }
                    break;
                case 3://发现更多
                {
                    if (indexPath.row == 0) {//使用帮助
                        Mine_Agreement_VC *VC = [[Mine_Agreement_VC alloc] init];
                        [VC setHidesBottomBarWhenPushed:YES];
                        VC.Type = 5;
                        [self.navigationController pushViewController:VC animated:YES];
//                        [MBProgressHUD py_showError:@"暂未开通" toView:nil];
//                        [MBProgressHUD setAnimationDelay:0.7f];
                    }else if (indexPath.row == 1) {//我的服务 快速入驻
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 0) {//普通用户  入驻跳转
                            Mine_SettledIn_ViewController *settledinVC = [[Mine_SettledIn_ViewController alloc] init];
                            [settledinVC setHidesBottomBarWhenPushed:YES];
                            [self.navigationController pushViewController:settledinVC animated:YES];
                        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 1){//跑腿
                             Mine_RunErrands_ServiceViewController *runVC = [[Mine_RunErrands_ServiceViewController alloc] init];
                             [runVC setHidesBottomBarWhenPushed:YES];
                             [self.navigationController pushViewController:runVC animated:YES];
                        }else {//家政
                            Mine_HouseKeeping_Service_ViewController *houserVC = [[Mine_HouseKeeping_Service_ViewController alloc] init];
                            [houserVC setHidesBottomBarWhenPushed:YES];
                            [self.navigationController pushViewController:houserVC animated:YES];
                        }
                    }else {//在线客服
                        [self callNumber];
//                        [MBProgressHUD py_showError:@"暂未开通" toView:nil];
//                        [MBProgressHUD setAnimationDelay:0.7f];
                    }
                }
                    break;
                default:
                {
                    [MBProgressHUD py_showError:@"暂未开通" toView:nil];
                    [MBProgressHUD setAnimationDelay:0.7f];
                }
                    break;
            }
        } else {//商家
            if (indexPath.section == 1) {//我的订单
                if (indexPath.row == 0) {//家政我的订单跳转
                    if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                        Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                        orderVC.Number = 1;
                        [orderVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:orderVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                        Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                        runErrandsVC.Number = 1;
                        [runErrandsVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:runErrandsVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                        Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                        houseKeepingVC.Number = 1;
                        [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:houseKeepingVC animated:YES];
                        
                    }else {//商家
                        Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                        shopVC.Number = 1;
                        [shopVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:shopVC animated:YES];
                        
                    }
                    
                    
                }else if (indexPath.row == 1) {//跑腿我的订单跳转
                    if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                        Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                        orderVC.Number = 2;
                        [orderVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:orderVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                        Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                        runErrandsVC.Number = 2;
                        [runErrandsVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:runErrandsVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                        Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                        houseKeepingVC.Number = 2;
                        [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:houseKeepingVC animated:YES];
                        
                    }else {//商家
                        Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                        shopVC.Number = 2;
                        [shopVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:shopVC animated:YES];
                        
                    }
                    
                }else if (indexPath.row == 2) {//商家我的订单 跳转
                    if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                        Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                        orderVC.Number = 3;
                        [orderVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:orderVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                        Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                        runErrandsVC.Number = 3;
                        [runErrandsVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:runErrandsVC animated:YES];
                        
                    }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                        Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                        houseKeepingVC.Number = 3;
                        [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:houseKeepingVC animated:YES];
                        
                    }else {//商家
                        Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                        shopVC.Number = 3;
                        [shopVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:shopVC animated:YES];
                        
                    }
                    
                }else if (indexPath.row == 3) {//评论
//                    Mine_MyOrder_Evaluate_ViewController *evaluateVC = [[Mine_MyOrder_Evaluate_ViewController alloc] init];
//                    [evaluateVC setHidesBottomBarWhenPushed:YES];
//                    [self.navigationController pushViewController:evaluateVC animated:YES];
                    Mine_MyOrder_UserEvaluateViewController *evaluateVC = [[Mine_MyOrder_UserEvaluateViewController alloc] init];
                    [evaluateVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:evaluateVC animated:YES];
                    
                    
                }else if (indexPath.row == 4) {//普通用户跳转
                    Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_VC *serviceVC = [[Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllService_VC alloc] init];
                    [serviceVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:serviceVC animated:YES];
                }
            }else if (indexPath.section == 2) {//商家必备
                if (indexPath.row == 0) {//我的商品
                    Mine_Goods_Supervise_ViewController *activityVC = [[Mine_Goods_Supervise_ViewController alloc] init];
                    [activityVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:activityVC animated:YES];
                }else if (indexPath.row == 1){//我的活动
                    Mine_MyActivity_ViewController *MineActivutyVC = [[Mine_MyActivity_ViewController alloc] init];
                    [MineActivutyVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:MineActivutyVC animated:YES];
                }else {//我的卡券
                    Mine_MyCard_ViewController *myCardVC = [[Mine_MyCard_ViewController alloc] init];
                    [myCardVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:myCardVC animated:YES];
                    
                }
                
            }else if (indexPath.section == 3) {//卡券中心
                if (indexPath.row == 0) {//店铺券
                    Mine_ShopCard_ViewController *ShopCardVC = [[Mine_ShopCard_ViewController alloc] init];
                    [ShopCardVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:ShopCardVC animated:YES];
                    
                }else if (indexPath.row == 1) {//商品券
                    Mine_GoodsCard_ViewController *GoodsCardVC = [[Mine_GoodsCard_ViewController alloc] init];
                    [GoodsCardVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:GoodsCardVC animated:YES];
                    
                }else {//代金券
                    Mine_Vouchers_ViewController *VouchersVC = [[Mine_Vouchers_ViewController alloc] init];
                    [VouchersVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:VouchersVC animated:YES];
                }
                
            } else if (indexPath.section == 4) {//发现更多
                if (indexPath.row == 0) {
                    Mine_Agreement_VC *VC = [[Mine_Agreement_VC alloc] init];
                    [VC setHidesBottomBarWhenPushed:YES];
                    VC.Type = 5;
                    [self.navigationController pushViewController:VC animated:YES];
                    //家政
                }else if (indexPath.row == 1) {
                    //我的小店
                    Mine_Shoping_Service_ViewController *shopVC = [[Mine_Shoping_Service_ViewController alloc] init];
                    [shopVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:shopVC animated:YES];
                }else {
                    [self callNumber];
                }
            }
        }
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}


#pragma mark----MineCVPublicHeaderViewCRVDelegate
- (void)MineCVPublicHeaderViewCRVRightButtonChange:(NSInteger)ClickNumber {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        if (ClickNumber == 1) {
            if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通
                Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
                orderVC.Number = 0;
                [orderVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }else if ([[Singleton sharedSingleton].type_id intValue] == 1) {//跑腿
                Mine_MyOrder_RunErrands_ViewController *runErrandsVC = [[Mine_MyOrder_RunErrands_ViewController alloc] init];
                runErrandsVC.Number = 0;
                [runErrandsVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:runErrandsVC animated:YES];
                
            }else if ([[Singleton sharedSingleton].type_id intValue] == 2) {//家政
                Mine_MyOrder_HouseKeeping_ViewController *houseKeepingVC  = [[Mine_MyOrder_HouseKeeping_ViewController alloc] init];
                houseKeepingVC.Number = 0;
                [houseKeepingVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:houseKeepingVC animated:YES];
                
            }else {//商家
                Mine_MyOrder_Shop_ViewController *shopVC = [[Mine_MyOrder_Shop_ViewController alloc] init];
                shopVC.Number = 0;
                [shopVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:shopVC animated:YES];
                
            }
        }else {
            [MBProgressHUD py_showError:@"暂未开通" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
 
    
//    if ([[Singleton sharedSingleton].type_id intValue] == 0) {//普通用户  全部订单
//        Mine_MyOrder_ViewController *orderVC = [[Mine_MyOrder_ViewController alloc] init];
//        orderVC.Number = 0;
//        [orderVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:orderVC animated:YES];
//    }
}
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_centreUser parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *DataSoure = [responseObject objectForKey:@"info"];
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:[DataSoure objectForKey:@"type_id"] forKey:User_Type];
            [Singleton sharedSingleton].nickname = [DataSoure objectForKey:@"nickname"];
            [Singleton sharedSingleton].soleid = [DataSoure objectForKey:@"soleid"];
            [Singleton sharedSingleton].avatar = [DataSoure objectForKey:@"avatar"];
            [Singleton sharedSingleton].type_id = [DataSoure objectForKey:@"type_id"];
            [Singleton sharedSingleton].address = [DataSoure objectForKey:@"address"];
            [Singleton sharedSingleton].audit = [DataSoure objectForKey:@"audit"];
            [Singleton sharedSingleton].Mid = [DataSoure objectForKey:@"id"];
            [Singleton sharedSingleton].sex = [DataSoure objectForKey:@"sex"];
            [Singleton sharedSingleton].qrcode = [DataSoure objectForKey:@"qrcode"];
            [Singleton sharedSingleton].attention_sum = [DataSoure objectForKey:@"attention_sum"];
            [Singleton sharedSingleton].plaza_sum = [DataSoure objectForKey:@"plaza_sum"];
            [Singleton sharedSingleton].collect_sum = [DataSoure objectForKey:@"collect_sum"];
            [Singleton sharedSingleton].balance = [DataSoure objectForKey:@"balance"];
            [Singleton sharedSingleton].phone = [DataSoure objectForKey:@"phone"];
            if ([[defaults objectForKey:User_Type] intValue] == 3) {
                self.ShopHiddle = NO;
                self.SectionTitle_Array = @[@"我的钱柜", @"我的订单  ", @"商家必备  " ,@"卡券中心  " ,@"发现更多  "];
                self.FindTitle_Array = @[@"使用帮助", @"我的小店", @"在线客服"];
                self.FindIcon_Array = @[@"icon_WD_SYBZ", @"icon_WD_WDXD", @"icon_WD_ZXKF"];
            } else {
                if ([[defaults objectForKey:User_Type] intValue] > 0) {
                    self.FindTitle_Array = @[@"使用帮助", @"我的服务", @"在线客服"];
                    self.FindIcon_Array = @[@"icon_WD_SYBZ", @"icon_WD_KSRZ", @"icon_WD_ZXKF"];
                }else {
                    self.FindTitle_Array = @[@"使用帮助", @"快速入驻", @"在线客服"];
                }
                self.ShopHiddle = YES;
                self.SectionTitle_Array = @[@"我的钱柜", @"我的订单  ",@"卡券中心  " ,@"发现更多  "];
            }
            [self.collectionView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)callNumber
{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"021-57626859"];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //记得添加到view上
}

@end
