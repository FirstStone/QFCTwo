//
//  Message_KDRViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_KDRViewController.h"

@interface Message_KDRViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIButton *WD_BT;

@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation Message_KDRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view insertSubview:self.WD_BT aboveSubview:self.scrollView];
    self.itemArray =@[@"待接单", @"待完成"];
    [self.view addSubview:self.segmentedControl];
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.itemArray.count; i++) {
        Message_KDR_TableView *LiftTableview = [[Message_KDR_TableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) style:UITableViewStylePlain];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        [LiftTableview beginFresh];
        [self.scrollView addSubview:LiftTableview];
    }
    [self.view bringSubviewToFront:self.WD_BT];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f))];
        _scrollView.backgroundColor = QFC_BackColor_Gray;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f));
        _scrollView.delegate = self;
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:NO];
        /*_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83- 40.0f) : (SCREEN_HEIGHT - 64.0f - 49.0f - 40.0f))];
         _scrollView.backgroundColor = QFC_BackColor_Gray;
         _scrollView.pagingEnabled = YES;
         _scrollView.showsHorizontalScrollIndicator = NO;
         _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83- 40.0f) : (SCREEN_HEIGHT - 64.0f - 49.0f - 40.0f));
         _scrollView.delegate = self;
         [_scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83- 40.0f) : (SCREEN_HEIGHT - 64.0f - 49.0f - 40.0f)) animated:NO];*/
    }
    return _scrollView;
}
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f : 64.0f, SCREEN_WIDTH, 40.0f)];
        _segmentedControl.sectionTitles = self.itemArray;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = QFC_Color_30AC65;
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor] ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f weight:100.0f]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName :[UIFont systemFontOfSize:16.0f weight:200.0f]};
        _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        
    }
    return _segmentedControl;
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;

    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

- (IBAction)WDbuttonClick:(id)sender {
    Home_KDR_Personal_ViewController *KDRVC = [[Home_KDR_Personal_ViewController alloc] init];
    [KDRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:KDRVC animated:YES];
    
}




@end
