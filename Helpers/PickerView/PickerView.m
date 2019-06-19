//
//  PickerView.m
//  Test
//
//  Created by K.O on 2018/7/20.
//  Copyright © 2018年 rela. All rights reserved.
//

#import "PickerView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define WScale ([UIScreen mainScreen].bounds.size.width) / 375

#define HScale ([UIScreen mainScreen].bounds.size.height) / 667


#define KFont [UIFont systemFontOfSize:15]


@interface PickerView ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *completeBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,assign) NSInteger selectIndex;
@property (nonatomic, assign) NSInteger selectOne;
@property (nonatomic, assign) NSInteger selectFirstIndex;
@end



@implementation PickerView

- (UIPickerView *)picker{
    
    if (!_picker) {
        
        _picker = [[UIPickerView alloc]init];
      
        _picker.delegate = self;
        
        _picker.dataSource = self;
    }
    
    return _picker;
}

- (UIDatePicker *)datePicke{
    
    if (!_datePicke) {
        
        _datePicke = [UIDatePicker new];
    }
    
    return _datePicke;
}

- (NSMutableArray *)array{
    if (!_array) {
        
        _array = [NSMutableArray array];
        
    }
    
    return _array;
}
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        [self initUI];
        
    }
    
    return self;
}

- (NSMutableArray *)weight_Array {
    if (!_weight_Array) {
        _weight_Array = [[NSMutableArray alloc] init];
    }
    return _weight_Array;
}


- (void)initUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.frame = [UIScreen mainScreen].bounds;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, KScreenWidth, 280*HScale)];
    [self addSubview:_bgView];
    _bgView.tag = 100;
     _bgView.backgroundColor = [UIColor whiteColor];
     [self showAnimation];
    
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cancelBtn.titleLabel.font = KFont;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
    //完成
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.completeBtn.titleLabel.font = KFont;
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completeBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
    

    
    WS(ws);
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = RGB(51, 51, 51, 1);
    self.titleLab.font = KFont;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.completeBtn.mas_centerY);
    }];


    self.line = [[UIView alloc]init];
 
    [self.bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(0.5);
        
    }];
    self.line.backgroundColor = RGB(224, 224, 224, 1);
    
   

    
}







#pragma mark type
- (void)setType:(PickerViewType)type{
    
    _type = type;
    
    switch (type) {
        case PickerViewTypeSex:{
            
            self.titleLab.text = @"选择性别";
            [self sexData];
            [self isDataPicker:NO];
        }
            break;
        case PickerViewTypeHeigh:{
            self.titleLab.text = @"选择身高";
            [self heightData];
            [self isDataPicker:NO];
             [self.picker selectRow:70 inComponent:0 animated:NO];
        }
            break;
        case PickerViewTypeWeight:
        {
            self.titleLab.text = @"选择体重";
            [self weightData];
            [self isDataPicker:NO];
            [self.picker selectRow:20 inComponent:0 animated:NO];
        }
            break;
        case PickerViewTypeBirthday:
        {
            self.titleLab.text = @"选择出生年月";
            
           [self isDataPicker:YES];
            self.datePicke.datePickerMode = UIDatePickerModeDate;
//            [self.datePicke setMinimumDate:[PickerView distanceYear:-19]];
            [self.datePicke setMaximumDate:[PickerView distanceYear:0]];
            
        }
            break;
        case PickerViewTypeTime:
        {
            self.titleLab.text = @"选择时间";
            [self isDataPicker:YES];
           self.datePicke.datePickerMode = UIDatePickerModeTime;
        }
            break;
        case PickerViewTypeDataAndHour:
        {
            self.titleLab.text = @"选择时间";
            
            [self isDataPicker:YES];
            self.datePicke.datePickerMode = UIDatePickerModeDateAndTime;
            [self.datePicke setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
            //默认为当天。
            [self.datePicke setCalendar:[NSCalendar currentCalendar]];
            //    设置DatePicker的时区。
            //    默认为设置为：[datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
            //    设置DatePicker的日期。
            //    默认设置为:
            [self.datePicke setDate:[NSDate date]];
            //    minimumDate设置DatePicker的允许的最小日期。
            //    maximumDate设置DatePicker的允许的最大日期
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:0];//设置最小时间为：当前时间
            NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [self.datePicke setMinimumDate:minDate];
        }
            break;
        case PickerViewTypeDataAndTime:
        {
            self.titleLab.text = @"选择时间";
            
            [self isDataPicker:YES];
            self.datePicke.datePickerMode = UIDatePickerModeDateAndTime;
            [self.datePicke setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
            //默认为当天。
            [self.datePicke setCalendar:[NSCalendar currentCalendar]];
            //    设置DatePicker的时区。
            //    默认为设置为：[datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
            //    设置DatePicker的日期。
            //    默认设置为:
            [self.datePicke setDate:[NSDate date]];
            //    minimumDate设置DatePicker的允许的最小日期。
            //    maximumDate设置DatePicker的允许的最大日期
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:2];//设置最大时间为：当前时间推后10天
            NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [comps setDay:0];//设置最小时间为：当前时间
            NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [self.datePicke setMaximumDate:maxDate];
            [self.datePicke setMinimumDate:minDate];
        }
            break;
        case PickerViewTypeRange:{
             self.titleLab.text = @"选择区间";
            [self formatterRangeAry];
           [self isDataPicker:NO];
        
        }
            break;
        case PickerViewTypeCity:{
             self.titleLab.text = @"选择城市";
            [self formatterCity];
            [self isDataPicker:NO];
        }
            break;
        case PickerViewTypeGoods:
        {
            self.titleLab.text = @"选择物品重量";
            [self formatterGoodsAry];
            [self isDataPicker:NO];
        }
            break;
        case PickerViewTypeReason:
        {
            self.titleLab.text = @"选择退款原因";
            [self formatterReason];
            [self isDataPicker:NO];
        }
        default:
            break;
    }
    
    
    
    
    
}

- (void)setSelectComponent:(NSInteger)selectComponent{
    _selectComponent = selectComponent;
     [self.picker selectRow:selectComponent inComponent:0 animated:NO];
   
}

- (void)isDataPicker:(BOOL)isData{
    
    WS(ws);
    
    if (isData) {
        
        [_bgView addSubview:self.datePicke];
        
        [self.datePicke mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
       
        
    }else{
        
        [_bgView addSubview:self.picker];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
        
    }
    
    
}




#pragma mark Click
- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

-(void)completeBtnClick{
    
    [self hideAnimation];
     NSString *resultStr = [NSString string];
    
    if (self.type == PickerViewTypeBirthday) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];

    }else if (self.type == PickerViewTypeTime){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];
        
    }else if (self.type==PickerViewTypeRange){
        
        PickerModel *model = self.array[self.selectIndex];
        NSInteger cityIndex = [self.picker selectedRowInComponent:1];
        NSString *cityName = model.cities[cityIndex];
        resultStr = [NSString stringWithFormat:@"%@-%@",model.province,cityName];
        resultStr = [self handleCityWithCity:resultStr];
        
    }else if (self.type==PickerViewTypeCity) {
        //第一列返回数据
        NSDictionary *FirstDic = self.array[self.selectIndex];
        
        //第二列返回数据
        NSInteger SecondIndex = [self.picker selectedRowInComponent:1];
        NSArray *FirstArray = [FirstDic objectForKey:@"n"];
        NSDictionary *Second_Dic = FirstArray[SecondIndex];
        
        //第三列返回数据
        NSInteger ThreeIndex = [self.picker selectedRowInComponent:2];
        NSArray *ThreeArray = [Second_Dic objectForKey:@"n"];
        NSDictionary *Three_Dic = ThreeArray[ThreeIndex];
        
        resultStr = [NSString stringWithFormat:@"%@-%@-%@", [FirstDic objectForKey:@"v"], [Second_Dic objectForKey:@"v"], [Three_Dic objectForKey:@"v"]];
        
        /*if (component == 0) {
            NSDictionary *FirstDic = self.array[row];
            return [FirstDic objectForKey:@"v"];
            
        }else if (component == 1) {
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray *FirstArray = [FirstDic objectForKey:@"n"];
            NSDictionary *First_Dic = FirstArray[row];
            return [First_Dic objectForKey:@"v"];
            
        }else {
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray *FirstArray = [FirstDic objectForKey:@"n"];
            NSDictionary *First_Dic = FirstArray[self.selectFirstIndex];
            NSArray *secondArray = [First_Dic objectForKey:@"n"];
            NSDictionary *secondDic = secondArray[row];
            return [secondDic objectForKey:@"v"];
        }
        
        PickerModel *model = self.array[self.selectIndex];
        NSInteger cityIndex = [self.picker selectedRowInComponent:1];
        NSString *cityName = model.cities[cityIndex];
        resultStr = [NSString stringWithFormat:@"%@-%@",model.province,cityName];
        resultStr = [self handleCityWithCity:resultStr];*/
        
        
    } else if (self.type == PickerViewTypeDataAndTime) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];
    }else if (self.type == PickerViewTypeGoods) {//物品重量
        PickerModel *model = self.array[self.selectIndex];
        NSInteger cityIndex = [self.picker selectedRowInComponent:1];
        NSString *cityName = model.cities[cityIndex];
        resultStr = [NSString stringWithFormat:@"%@-%@",model.province,cityName];
        resultStr = [self handleCityWithCity:resultStr];
    }else if (self.type == PickerViewTypeDataAndHour) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];
    }
    
    else{
        
        for (int i = 0; i < self.array.count; i++) {
            
            NSArray *arr = [self.array objectAtIndex:i];
            NSString *str = [arr objectAtIndex:[self.picker selectedRowInComponent:i]];
            
            resultStr = [resultStr stringByAppendingString:str];
        }
        
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:result:)]) {
        [_delegate pickerView:self result:resultStr];
    }
    
    
}

#pragma mark 模拟数据
- (void)sexData{
    
    [self.array addObject:@[@"男",@"女"]];
   
}

- (void)heightData{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 100; i <= 250; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
    
}

- (void)weightData{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 30; i <= 150; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}




#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    if (touch.view.tag !=100) {
        
        [self hideAnimation];
    }
    
    
    
}

- (void)showAnimation{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height-260*HScale;
        self.bgView.frame = frame;
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height;
        self.bgView.frame = frame;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    
    if (self.type == PickerViewTypeRange || self.type == PickerViewTypeGoods) {
        
        return 2;
    }else if (self.type==PickerViewTypeCity) {
        return 3;
    }
    
    return self.array.count;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.type==PickerViewTypeRange || self.type == PickerViewTypeGoods) {
        
        if (component==0) {
            return self.array.count;
        }else{
            NSLog(@"%ld", self.selectIndex);
            PickerModel *model = self.array[self.selectIndex];
            return model.cities.count;
            
        }
        
    }else if (self.type==PickerViewTypeCity) {
        if (component == 0) {
            return self.array.count;
        }else if (component == 1) {
            NSLog(@"%ld", self.selectIndex);
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray * FirstArray = [FirstDic objectForKey:@"n"];
            return FirstArray.count;
            
        }else {
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray * FirstArray = [FirstDic objectForKey:@"n"];
            NSDictionary *SecondDic = FirstArray[self.selectFirstIndex];
            NSArray * SecondArray = [SecondDic objectForKey:@"n"];
            return SecondArray.count;
            
        }
    }
    
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    return arr.count;
}

/*
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    return label;
    
}
 */
//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.type == PickerViewTypeRange || self.type == PickerViewTypeGoods) {
        
        if (component==0) {
            PickerModel *model = self.array[row];
            
            return model.province;
            
        }else{
             PickerModel *model = self.array[self.selectIndex];
            return model.cities[row];
            
        }
        
    }else if (self.type==PickerViewTypeCity) {
        if (component == 0) {
            NSDictionary *FirstDic = self.array[row];
            return [FirstDic objectForKey:@"v"];
        }else if (component == 1) {
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray *FirstArray = [FirstDic objectForKey:@"n"];
            NSDictionary *First_Dic = FirstArray[row];
            return [First_Dic objectForKey:@"v"];
            
        }else {
            NSDictionary *FirstDic = self.array[self.selectIndex];
            NSArray *FirstArray = [FirstDic objectForKey:@"n"];
            NSDictionary *First_Dic = FirstArray[self.selectFirstIndex];
            NSArray *secondArray = [First_Dic objectForKey:@"n"];
            NSDictionary *secondDic = secondArray[row];
            return [secondDic objectForKey:@"v"];
            
        }
    }
    
    
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        if (self.type == PickerViewTypeRange || self.type == PickerViewTypeGoods) {
            self.selectIndex = [pickerView selectedRowInComponent:0];
            
            [pickerView reloadComponent:1];
        }else if (self.type==PickerViewTypeCity) {
            self.selectIndex = [pickerView selectedRowInComponent:0];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }
    }if (component == 1){
        if (self.type==PickerViewTypeCity) {
            self.selectFirstIndex = [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:2];
        }
    }
    
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.type == PickerViewTypeCity || self.type == PickerViewTypeGoods) {
        return 110;
    }else {
     return SCREEN_WIDTH;//110;
    }
}

//防止崩溃
- (NSUInteger)indexOfNSArray:(NSArray *)arr WithStr:(NSString *)str{
    
    NSUInteger chosenDxInt = 0;
    if (str && ![str isEqualToString:@""]) {
        chosenDxInt = [arr indexOfObject:str];
        if (chosenDxInt == NSNotFound)
            chosenDxInt = 0;
    }
    return chosenDxInt;
}


#pragma mark tool
+ (NSDate *)distanceYear:(int)year{
    
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    
    [adcomps setYear:year];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    
    return newdate;
}


- (void)formatterCity{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"City.plist" ofType:nil];
    NSArray *plistAray = [NSArray arrayWithContentsOfFile:path];
    
    for (int i=0; i<plistAray.count; i++) {
        NSDictionary *model = plistAray[i];
        [self.array addObject:model];
        
    }
    
}
//物品重量
- (void)formatterGoodsAry{
    
    NSMutableArray *rang = [self.array mutableCopy];
    
    [self.array removeAllObjects];
    for (int i = 0; i < rang.count; i ++) {
        PickerModel *model = [[PickerModel alloc] init];
        model.province = rang[i];
        model.cities = @[@"小于5kg", @"5kg", @"6kg", @"7kg", @"8kg", @"9kg"];
        [self.array addObject:model];
    }
}

//退款原因
- (void)formatterReason {
    /*NSMutableArray *rang = [self.array mutableCopy];
    
    [self.array removeAllObjects];
    for (int i = 0; i < rang.count; i ++) {
        PickerModel *model = [[PickerModel alloc] init];
        model.province = rang[i];
        model.cities = @[@"小于5kg", @"5kg", @"6kg", @"7kg", @"8kg", @"9kg"];
        [self.array addObject:model];
    }*/
    [self.array addObject:@[@"退运费",@"质量问题", @"少件/漏发", @"包装/商品破损", @"服务问题", @"拍错了"]];
}



- (void)formatterRangeAry{
    
    NSMutableArray *rang = [self.array mutableCopy];
    
    [self.array removeAllObjects];
    
    for (int i=0; i<rang.count-1; i++) {
        
        PickerModel *model = [[PickerModel alloc] init];
        
        model.province = rang[i];
        
        NSMutableArray *cityAry = [NSMutableArray array];
        
        for (int m=i+1; m<rang.count; m++) {
            [cityAry addObject:rang[m]];
        }
        
        model.cities  = cityAry;
        
        [self.array addObject:model];
        
    }
    
    
    
}
//处理省份和城市名相同
- (NSString *)handleCityWithCity:(NSString *)result{
    
  NSArray *cityAry = [result componentsSeparatedByString:@"-"];
    
    if ([cityAry[0] isEqualToString:cityAry[1]]) {
        return cityAry[0];
    }else{
        
        return result;
    }
    
    
}

@end
