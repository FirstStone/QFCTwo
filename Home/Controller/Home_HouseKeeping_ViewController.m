



//
//  Home_HouseKeeping_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_HouseKeeping_ViewController.h"

@interface Home_HouseKeeping_ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *itemArray;
@end

@implementation Home_HouseKeeping_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemArray =@[@"日常清洁", @"深层清洁"];
    [self.view addSubview:self.segmentedControl];
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.itemArray.count; i++) {
        Home_HouseKeeping_TableView *LiftTableview = [[Home_HouseKeeping_TableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f))];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        [self.scrollView addSubview:LiftTableview];
    }
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f))];
        _scrollView.backgroundColor = QFC_BackColor_Gray;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f));
        _scrollView.delegate = self;
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:NO];
    }
    return _scrollView;
}
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f : 64.0f, SCREEN_WIDTH, 40.0f)];
        _segmentedControl.sectionTitles = self.itemArray;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor] ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : QFC_Color_30AC65, NSFontAttributeName :[UIFont systemFontOfSize:14.0f weight:200.0f]};
        _segmentedControl.selectionIndicatorColor = QFC_Color_30AC65;
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

@end
