//
//  MXPthread.hpp
//  NetworkingDemo
//
//  Created by liicon on 2017/7/28.
//  Copyright © 2017年 max. All rights reserved.
//

#ifndef MXPthread_hpp
#define MXPthread_hpp

#include <stdio.h>
#include <string>
//测试线程
void testThread();

struct Person{
    std::string name;
    int age;
    float height;
};

class TestC {

public:
    struct Person xiaoming;
    void getName();
    
private:

};


#endif /* MXPthread_hpp */
