//
//  MyDatePickerView.h
//  iApp
//
//  Created by liicon on 16/6/13.
//  Copyright © 2016年 liicon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDatePickerView : UIView
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString  *weekDay;
@property(nonatomic, strong) void(^sureDateBlock)(NSString *date);
- (void)show;
- (void)hiden;
@end
