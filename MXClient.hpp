//
//  MXClient.hpp
//  NetworkingDemo
//
//  Created by liicon on 2017/8/31.
//  Copyright © 2017年 max. All rights reserved.
//

#ifndef MXClient_hpp
#define MXClient_hpp
#include <stdio.h>

typedef void(^sServerAccepcCallBack)(char msg[]);

int client();

int serverLisen(sServerAccepcCallBack callBack);

void sendMessage(char s[]);

#endif /* MXClient_hpp */
