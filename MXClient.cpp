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


int client_skfd;
size_t len;

struct sockaddr_in remot_addr;//服务器网络地址
char buffer[BUFSIZ];   //数据传送的缓冲区

int client(){
    
    memset(&remot_addr,0,sizeof(remot_addr));
    remot_addr.sin_family = AF_INET;
    remot_addr.sin_addr.s_addr = inet_addr("127.0.0.1");//服务器地址
    remot_addr.sin_port = htons(8080);
    
    if ((client_skfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
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
    
    
//    char s[] = {'I',' ','a','m',' ','h','a','p','p','y','\0'};
//    len=send(client_skfd,s,strlen(buffer),0);
//    len=recv(client_skfd,buffer,BUFSIZ,0);
//    buffer[len]='\0';
//    printf("received:%s\n",buffer);
    
//    while (1) {
//        
//        char s[] = {'I',' ','a','m',' ','h','a','p','p','y','\0'};
//        len=send(client_skfd,s,strlen(buffer),0);
//        len=recv(client_skfd,buffer,BUFSIZ,0);
//        buffer[len]='\0';
//        printf("received:%s\n",buffer);
//    }
    
    
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
