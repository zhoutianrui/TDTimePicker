//
//  DatePickerView.h
//  SafPay
//
//  Created by ztr on 2019/5/29.
//  Copyright © 2019 ebo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
-(void)show;
-(void)dismiss;
@property (nonatomic,strong)void(^ensureBlock)(NSString *dateStr);
@property (nonatomic,strong)void(^ensureTimeIntBlock)(NSString *dateInt);
@property(nonatomic,strong)UIDatePicker *myDatePicker;
@end

NS_ASSUME_NONNULL_END
