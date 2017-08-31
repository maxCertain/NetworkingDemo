//
//  MXPthread.cpp
//  NetworkingDemo
//
//  Created by liicon on 2017/7/28.
//  Copyright © 2017年 max. All rights reserved.
//

#include "MXPthread.hpp"
#include <iostream>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <thread>

using namespace std;

#define num_threads 5 //线程数

void printids(const char *s)
{
    pid_t pid;
    pthread_t tid;
    pid = getpid();
    tid = pthread_self();
}

void* say_hello(void* args){
    for (int  i = 0; i < 1000; i++) {
        if (i == 12) {
            pthread_cancel(pthread_self());
        }
    }
    return ((void*)0);
}


void couter(int a, int b){
    printf("sum  is %d\n",a + b);
}

void testThread(){
    
    std::thread ta(couter, 1, 2);
    ta.join();
    
    pthread_t tids[num_threads];
    
    for (int  i = 0; i < num_threads; i++) {
        int ret  = pthread_create(tids, NULL, say_hello, &i);
        if (ret != 0) {
            printf("creat fail %i",i);
        }
    }
}

void fun(int a, int b){
    if (b == 0) {
        throw invalid_argument("divide Zero");
    }
}

void nyswap(int &a, int &b){
    int temp = a;
    a = b;
    b = temp;
}

void TestC::getName(){
    
    int a = 4; int b = 5;
    int &xa = a;
    int &xb = b;
    nyswap(xa, xb);
    std:: cout << a << "--" << b << std::endl;
    
    try {
        fun(10,0);
    } catch (const invalid_argument &e) {
        std::cout << e.what() << std::endl;
    }
    
    std::string name = "xiaoming";
    if (name == TestC::xiaoming.name) {
        printf("name is equel\n");
    }
}







