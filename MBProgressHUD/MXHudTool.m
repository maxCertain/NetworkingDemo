//
//  MXHudTool.m
//  NetworkingDemo
//
//  Created by liicon on 2017/7/25.
//  Copyright © 2017年 max. All rights reserved.
//

#import "MXHudTool.h"
#import "MBProgressHUD.h"

static MXHudTool *shareObj = nil;

@interface MXHudTool ()

@property(nonatomic,strong) MBProgressHUD *progressHud;
@property(nonatomic,strong) MBProgressHUD *textHud;
@property(nonatomic,strong) MBProgressHUD *waitHud;

@end

@implementation MXHudTool

+ (MXHudTool *)shareTool{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareObj == nil) {
            shareObj = [super allocWithZone:zone];
            shareObj.count = 0;
        }
    });
    return shareObj;
}

- (id)copy{
    return shareObj;
}

- (id)mutableCopy{
    return shareObj;
}

- (void)showHud:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    [hud hide:YES afterDelay:1.5];
}

- (void)showHudInView:(UIView *)view msg:(NSString *)msg{
    if (!self.waitHud) {
        self.waitHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}

- (void)showHud:(NSString *)msg progress:(float)progress{
    static BOOL isShow = false;
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    if (!self.progressHud) {
        self.progressHud = [[MBProgressHUD alloc] initWithView:window];
        [window addSubview:self.progressHud];
        self.progressHud.mode = MBProgressHUDModeDeterminate;
    }
    self.progressHud.labelText = msg;
    self.progressHud.progress = progress;
    if (progress == 1) {
        [self.progressHud hide:YES];
        isShow = false;
    }else{
        isShow = true;
        [self.progressHud show:YES];
    }
}

- (void)hiddenHud{
    [self.waitHud hide:YES];
}

@end
