//
//  MXCTest.m
//  NetworkingDemo
//
//  Created by liicon on 2017/7/28.
//  Copyright © 2017年 max. All rights reserved.
//

#import "MXCTest.h"
#include "MXPthread.hpp"
#include "MXClient.hpp"
#include <string.h>

@implementation MXCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)sendString:(NSString *)str{
    static BOOL isConnect = false;
    if (!isConnect) {
        isConnect = YES;
        client();
    }
    
    std::string s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    char a[s.length()];
    strncpy(a,s.c_str(),s.length());
    a[s.length()] = '\0';
    sendMessage(a);
}

- (void)testC{
    testThread();
    
    client();
}


@end
