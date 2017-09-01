//
//  MXClient.cpp
//  NetworkingDemo
//
//  Created by liicon on 2017/8/31.
//  Copyright © 2017年 max. All rights reserved.
//

#include "MXClient.hpp"
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>


int sclient;
int server_skfd;
size_t len;
struct sockaddr_in sremot_addr;//服务器网络地址
struct sockaddr_in addrServ;
char buffer[BUFSIZ];   //数据传送的缓冲区

int serverLisen(sServerAccepcCallBack callBack){
    
    //创建套接字
    if ((server_skfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
        printf("creat server fail");
        return -1;
    }
    
    //绑定地址
    memset(&addrServ,0,sizeof(addrServ)); //数据初始化--清零
    addrServ.sin_family = AF_INET;
    addrServ.sin_addr.s_addr = INADDR_ANY;
    addrServ.sin_port = htons(8088);
    if (bind(server_skfd, (struct sockaddr *)&addrServ, sizeof(struct sockaddr)) < 0) {
        printf("server bind error");
        return -1;
    }
    
    //开始监听请求
    if (listen(server_skfd, 5) < 0) {
        printf("listen error");
        return -1;
    }
    socklen_t sin_size = sizeof(struct sockaddr_in);
    /*等待客户端连接请求到达*/
    if((sclient=accept(server_skfd,(struct sockaddr *)&sremot_addr,&sin_size))<0)
    {
        perror("accept error");
        return 1;
    }
    send(sclient,"Welcome to my server\n",21,0);
    
    
    while (recv(sclient, buffer, BUFSIZ, 0) > 0) {
        callBack(buffer);
        if(send(sclient,buffer,len,0)<0)
        {
            perror("write error");
            return 1;
        }
        if (!strcmp(buffer, "quit")) {
            /*关闭套接字*/
            close(sclient);
            break;
        }
    }
    return 0;
}


int client_skfd;
struct sockaddr_in remot_addr;

int client(){
    
    memset(&remot_addr,0,sizeof(remot_addr));
    remot_addr.sin_family = AF_INET;
    remot_addr.sin_addr.s_addr = inet_addr("192.168.1.22");//服务器地址
    remot_addr.sin_port = htons(8088);
    
    
    if ((client_skfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
        printf("socket error\n");
        return 1;
    }
    
    if (connect(client_skfd, (struct sockaddr*)&remot_addr, sizeof(sockaddr)) < 0) {
        printf("connect error\n");
        return 1;
    }
    
    printf("conected\n");
    len = recv(client_skfd, buffer, BUFSIZ, 0);
    buffer[len] = '\0';
    printf("%s",buffer);
  
    return 0;
}

void sendMessage(char s[]){
    len=send(client_skfd,s,strlen(s),0);
    len=recv(client_skfd,buffer,BUFSIZ,0);
    buffer[len]='\0';
    printf("received:%s\n",buffer);
    /*关闭套接字*/
    if (!strcmp(buffer, "quit")) {
        /*关闭套接字*/
        close(client_skfd);
    }
}
