//
//  main.m
//  SocketClientDemo
//
//  Created by alexiuce  on 2017/8/11.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <sys/types.h>
#import <sys/errno.h>
#import <netinet/in.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /** 创建socket */
        int socketFb = socket(AF_INET, SOCK_STREAM, 0);
        NSCAssert(socketFb > 0, @"socket create failuer");
        
        char clientBuffer[256] = {0};
        struct sockaddr_in serverAddress;
        
        /** 设置连接目标服务器参数*/
        memset(&serverAddress, 0, sizeof(serverAddress));
        serverAddress.sin_family = AF_INET;
        serverAddress.sin_port = htons(4567);
        serverAddress.sin_addr.s_addr = INADDR_ANY;//(本机地址) //inet_addr("");
        
        /** 连接socket */
        int connectResult = connect(socketFb, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
        NSCAssert(connectResult >= 0, @"connect failuer");
        while (true) {            
            NSLog(@"please input your message:");
            fgets(clientBuffer, 255, stdin);
            
            NSString *inputText = [NSString stringWithUTF8String:clientBuffer];
            if ([inputText isEqualToString:@"quit"]) {
                break;
            }
            
            long wResult = write(socketFb, clientBuffer,strlen(clientBuffer));
            NSCAssert(wResult >= 0, @"write falier");
            
            memset(clientBuffer, 0, 256);
//            long rResult = read(socketFb, clientBuffer, 255);
//            NSCAssert(rResult >= 0, @"read falier");
//            NSLog(@"client receive message : %s",clientBuffer);
//            memset(clientBuffer, 0, 256);
        }
        close(socketFb);
    }
    return 0;
}
