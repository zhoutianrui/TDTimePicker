//
//  DatePickerView.m
//  SafPay
//
//  Created by ztr on 2019/5/29.
//  Copyright © 2019 ebo. All rights reserved.
//

#import "DatePickerView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSCALE_WIDTH(w)     (kScreenWidth/375.0*w)
#define kSCALE_HEIGHT(h)    (kScreenHeight/667.0*h)
@implementation DatePickerView
{
    UIButton *ensureBtn;
    UIButton *cancelBtn;
    UIView *toolView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        
        toolView=[[UIView alloc]init];
        [toolView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:toolView];
        ensureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [ensureBtn addTarget:self action:@selector(ensureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:ensureBtn];
        
        cancelBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:cancelBtn];
        
        [self addSubview:self.myDatePicker];
       
        
       
        
      
    
    }
    return self;
    
    
}

-(void)layoutSubviews{
    
    
    
}
-(void)ensureBtnClick{
    
    if(self.ensureBlock){
        
        NSString *str=[self getDateYMDWith:self.myDatePicker.date];
        self.ensureBlock(str);
    }
    if(self.ensureTimeIntBlock){
        
        long long time = [self.myDatePicker.date timeIntervalSince1970];
        self.ensureTimeIntBlock([NSString stringWithFormat:@"%lld",time]);
    }
    [self dismiss];
}
-(void)cancelBtnClick{
    
    [self dismiss];
}
-(void)show{
    
    UIWindow *windwo = [[[UIApplication sharedApplication] delegate] window];
    [windwo addSubview:self];
    [self setFrame:CGRectMake(0, windwo.frame.size.height, windwo.frame.size.width, kSCALE_WIDTH(344))];
     [self.myDatePicker setFrame:CGRectMake(0,self.frame.size.height-self.frame.size.height* kSCALE_WIDTH(300)/kSCALE_WIDTH(344), kScreenWidth, self.frame.size.height* kSCALE_WIDTH(300)/kSCALE_WIDTH(344))];
    [toolView setFrame:CGRectMake(0, self.myDatePicker.frame.origin.y-kSCALE_HEIGHT(50), kScreenWidth, self.frame.size.height* kSCALE_WIDTH(44)/kSCALE_WIDTH(344))];
    
    [ensureBtn setFrame:CGRectMake(CGRectGetMaxX(toolView.frame)-kSCALE_WIDTH(50), 0, kSCALE_WIDTH(50), toolView.frame.size.height)];
    [cancelBtn setFrame:CGRectMake(0, 0, kSCALE_WIDTH(50), toolView.frame.size.height)];
    //用动画实现回归原位
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -kSCALE_WIDTH(344));
    }];
    
}
-(void)dismiss{
    
    [self removeFromSuperview];
}
-(UIDatePicker *)myDatePicker{
    
    if(!_myDatePicker){
        
        _myDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, kScreenHeight+kSCALE_WIDTH(44), kScreenWidth, 300)];
        // 设置日期选择控件的地区
        [_myDatePicker setBackgroundColor:[UIColor whiteColor]];
        [_myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        
        
        //默认为当天。
        
        [_myDatePicker setCalendar:[NSCalendar currentCalendar]];
        
        
        
        //    设置DatePicker的日期。
        
        //    默认设置为:
        
        [_myDatePicker setDate:[NSDate date]];
        
        //    minimumDate设置DatePicker的允许的最小日期。
        
        //    maximumDate设置DatePicker的允许的最大日期
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *currentDate = [NSDate date];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        //设置最大时间为：当前时间推后10天
//        [comps setMonth:1];
//        [comps setYear:1];
//
//        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//
////        [comps setMonth:-1];//设置最小时间为：当前时间
//         [comps setYear:-1];
//
//
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//        
//        [_myDatePicker setMaximumDate:maxDate];
//        [_myDatePicker setMinimumDate:minDate];
        //    设置DatePicker的倒计时间.
        
        //    1) 设置日期选择的模
        
        //    [myDatePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        
        //    2) 设置倒计时的时长
        
        //    注意：设置倒计时时长需要在确定模式之后指定
        
        // 倒计时的时长，以秒为单位
        
        //    [myDatePicker setCountDownDuration:10 * 60];
        
        
        
        
        
        //显示小时，分钟和AM/PM
        
        //    [myDatePicker setDatePickerMode:UIDatePickerModeTime];
        
        //显示年月日
        
        [_myDatePicker setDatePickerMode:UIDatePickerModeDate];
        
        //显示小时和分钟
        
        //    [myDatePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        
        
        
        //监听datepicker值的改变
        
        [_myDatePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
        
        
        
    }
    return _myDatePicker;
}

- (void)dateChange:(UIDatePicker *)date

{
    NSLog(@"%@", date.date);

    
}
-(NSString *)getDateYMDWith:(NSDate *)date{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *string = [format stringFromDate:date];
    
    return string;
    
}
@end
