//
//  MXNetworkingTool.h
//  NetworkingDemo
//
//  Created by liicon on 2017/7/25.
//  Copyright © 2017年 max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXNetworkingTool : NSObject

- (NSURLSessionTask *)networkingWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completionBlock:(void(^)(NSDictionary *response))finishBlock;

- (void)download:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *downloadProgress))showProgress destination:(NSURL*(^)(NSURLResponse * response))getPathBlock completionBlock:(void(^)( NSURL * filePath))finishBlock;

@end
