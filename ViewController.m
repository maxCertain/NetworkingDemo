//
//  ViewController.m
//  NetworkingDemo
//
//  Created by liicon on 2017/7/25.
//  Copyright © 2017年 max. All rights reserved.
//

#import "ViewController.h"
#import "MXNetworkingTool.h"
#import "MXHudTool.h"
#import <ImageIO/ImageIO.h>
#import <MessageUI/MessageUI.h>
#import <CommonCrypto/CommonCrypto.h>
#import "MXCTest.h"
#import "MyDatePickerView.h"



@interface ViewController ()<UIWebViewDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,SocketServerDelegate>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) MXCTest *cTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
//    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (screen_height - screen_width)/2, screen_width, screen_width * 0.8)];
//    [self.view addSubview:self.imageView];
//    
//    
//    [[MXHudTool shareTool] showHudInView:self.view msg:@"13"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[MXHudTool shareTool] hiddenHud];
//    });
    
    self.cTest = [[MXCTest alloc] init];
    self.cTest.delegate = self;
    
//    @try {
//        [self func];
//    } @catch (NSException *exception) {
//        NSLog(@"%@",exception.reason);
//    } @finally {
//        NSLog(@"14");
//    }
    
}

- (void)serverMessage:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.testView.text = message;
    });
}

extern NSString* CTSettingCopyMyPhoneNumber();

-(NSString *) phoneNumber {
    NSString *phone = CTSettingCopyMyPhoneNumber();
    return phone;
}

- (NSString *)md5String:(NSString *)str{
    const char *cStr = str.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)str.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

- (void)btnEvents:(UIButton *)btn{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
        msgVc.messageComposeDelegate = self;
        msgVc.body = @"123";
        msgVc.recipients = @[@"13713455210",@"13174235547"];
        
        [self presentViewController:msgVc animated:YES completion:^{
            
        }];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controller dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
    
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *url = @"http://n.sinaimg.cn/astro/52_ori/upload/4aa9f7c4/20170613/4wIj-fyfzhac1934181.gif";
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    
//    [self.webView loadRequest:request];
    
    [[MXNetworkingTool new] download:url parameters:nil progress:^(NSProgress *downloadProgress) {
        [[MXHudTool shareTool] showHud:@"正在下载" progress:downloadProgress.fractionCompleted];
    } destination:^NSURL *(NSURLResponse *response) {
        NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [@"file://" stringByAppendingString:cache];
        NSURL *url = [[NSURL URLWithString:path] URLByAppendingPathComponent:@"gif.gif"];
        return url;
    } completionBlock:^(NSURL *filePath) {
        [self playwithUrl:filePath];
    }];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)playwithUrl:(NSURL *)url{
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    if (gifSource == nil) return;
    
    size_t count = CGImageSourceGetCount(gifSource);
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
        
        [images addObject:image];//将图片加入数组中
        
        CGImageRelease(imageRef);
    }

    self.imageView.image = [images objectAtIndex:0];
    self.imageView.animationImages = images;
    self.imageView.animationDuration = 6;
    [self.imageView startAnimating];

}

- (void)func{
    NSException *ex = [NSException exceptionWithName:@"q" reason:@"exception" userInfo:nil];
    @throw ex;
}
- (IBAction)endBtnEvents:(id)sender {
}
- (IBAction)sendBtnEvents:(id)sender {
    
    NSString *sendStr = self.textField.text;
    self.textField.text = nil;
    if (sendStr != nil) {
        [self.cTest sendString:sendStr];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
