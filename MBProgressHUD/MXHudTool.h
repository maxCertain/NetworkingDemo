//
//  MXHudTool.h
//  NetworkingDemo
//
//  Created by liicon on 2017/7/25.
//  Copyright © 2017年 max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MXHudTool : NSObject

@property(nonatomic,assign) NSInteger count;

+ (MXHudTool *)shareTool;

- (void)showHud:(NSString *)msg;

- (void)showHud:(NSString *)msg progress:(float)progress;

- (void)showHudInView:(UIView *)view msg:(NSString *)msg;

- (void)hiddenHud;

@end
