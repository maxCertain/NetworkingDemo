//
//  MyDatePickerView.m
//  iApp
//
//  Created by liicon on 16/6/13.
//  Copyright © 2016年 liicon. All rights reserved.
//

#import "MyDatePickerView.h"

@implementation MyDatePickerView
{
    UILabel *_titleLable;
    UIView *_bgView;
    NSDateFormatter *_dateFormat;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setView];
    }return self;
}

- (void)setView
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat h = w + 40;
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
    _titleLable.text = @"请选择开始时间";
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor colorWithRed:46.0/225.0 green:47.0/225.0 blue:117/225.0 alpha:1];
    [self addSubview:_titleLable];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLable.frame), w, 1)];
    topLine.backgroundColor = [UIColor colorWithRed:46.0/225.0 green:47.0/225.0 blue:117/225.0 alpha:1];
    [self addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, h - 40, w, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    
    UIView *sepraterLine = [[UIView alloc] initWithFrame:CGRectMake(w/2 - 1, CGRectGetMinY(bottomLine.frame) + 1, 1, h - CGRectGetMinY(bottomLine.frame))];
    sepraterLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:sepraterLine];
    
    
    UIButton *cancleBtn = [self creatBtnWititlTitle:@"取消" andFrame:CGRectMake(0, CGRectGetMaxY(bottomLine.frame), w/2 - 1, CGRectGetHeight(sepraterLine.frame))];
    [cancleBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *setBtn = [self creatBtnWititlTitle:@"设定" andFrame:CGRectMake(CGRectGetMaxX(sepraterLine.frame), CGRectGetMaxY(bottomLine.frame), CGRectGetWidth(cancleBtn.frame), CGRectGetHeight(cancleBtn.frame))];
    [setBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    
    self.backgroundColor = [UIColor whiteColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat originX = window.center.x - w/2;
    CGFloat originY = window.center.y - h/2;
    self.frame = CGRectMake(originX, originY, w, h);
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame), w, h - CGRectGetMaxY(topLine.frame) - CGRectGetHeight(sepraterLine.frame) - 1)];
    
//    _datePicker.frame = CGRectMake(0, CGRectGetMaxY(topLine.frame), w, h - CGRectGetMaxY(topLine.frame) - CGRectGetHeight(sepraterLine.frame) - 1);
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [self addSubview:_datePicker];
    
    [_datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    
    _datePicker.backgroundColor = [UIColor whiteColor];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _bgView.backgroundColor = [UIColor colorWithRed:0/225.0 green:0/225.0 blue:0/225.0 alpha:0.3];
    
    [_bgView addSubview:self];
    _dateFormat = [[NSDateFormatter alloc] init];
    [_dateFormat setDateFormat:@"yyyy-MM-dd"];
    
}

- (void)setTitle:(NSString *)title
{
    if (title) {
        _title = title;
        _titleLable.text = title;
    }
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    _weekDay = [self weekdayStringFromDate:_datePicker.date];
    NSString *dateString = [_dateFormat stringFromDate:_datePicker.date];
    dateString = [NSString stringWithFormat:@"%@ %@",dateString,_weekDay];
    _titleLable.text = dateString;
}

- (void)cancelBtnClick:(UIButton *)btn
{
    [self hiden];
}

- (void)sureBtnClick:(UIButton *)btn
{
    NSString *dateString = [_dateFormat stringFromDate:_datePicker.date];
    
    if (_sureDateBlock) {
        _sureDateBlock(dateString);
    }
}

- (UIButton *)creatBtnWititlTitle:(NSString *)title andFrame:(CGRect)frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self addSubview:btn];
    
    return btn;
}

- (void)show
{
    _bgView.hidden = NO;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![window.subviews containsObject:_bgView]) {
        [window addSubview:_bgView];
    }
    self.weekDay = [self weekdayStringFromDate:_datePicker.date];
}

- (void)hiden
{
    [_bgView removeFromSuperview];
    _bgView.hidden = YES;
}

- (void)dealloc
{
    [_bgView removeFromSuperview];
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

@end
