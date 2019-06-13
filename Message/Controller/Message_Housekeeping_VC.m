//
//  Message_Housekeeping_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_Housekeeping_VC.h"

@interface Message_Housekeeping_VC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation Message_Housekeeping_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemArray =@[@"待接单", @"待完成"];
    [self.view addSubview:self.segmentedControl];
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.itemArray.count; i++) {
        Message_Housekeeping_Tableview *LiftTableview = [[Message_Housekeeping_Tableview alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) style:UITableViewStyleGrouped];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        [LiftTableview beginFresh];
        [self.scrollView addSubview:LiftTableview];
    }
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


@end
