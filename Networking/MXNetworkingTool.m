//
//  MXNetworkingTool.m
//  NetworkingDemo
//
//  Created by liicon on 2017/7/25.
//  Copyright © 2017年 max. All rights reserved.
//

#import "MXNetworkingTool.h"
#import "AFNetworking.h"
#import "MXHudTool.h"

@implementation MXNetworkingTool

- (NSURLSessionTask *)networkingWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completionBlock:(void(^)(NSDictionary *response))finishBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSURLSessionTask *task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (dict && finishBlock) {
            finishBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    return task;
}

- (void)download:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *downloadProgress))showProgress destination:(NSURL*(^)(NSURLResponse * _Nonnull response))getPathBlock completionBlock:(void(^)( NSURL * filePath))finishBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (showProgress) {
                showProgress(downloadProgress);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *url = getPathBlock(response);
        NSString *path = [url.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (isExist) {
            [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
        }
        return url;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            finishBlock(filePath);
        }
    }];
    [task resume];
}

@end
