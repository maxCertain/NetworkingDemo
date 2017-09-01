//
//  MXCTest.h
//  NetworkingDemo
//
//  Created by liicon on 2017/7/28.
//  Copyright © 2017年 max. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SocketServerDelegate <NSObject>

@optional
- (void)serverMessage:(NSString *)message;

@end

@interface MXCTest : NSObject

@property(nonatomic,weak) id<SocketServerDelegate>delegate;

- (void)testC;

- (void)sendString:(NSString *)str;

@end
