//
//  main.m
//  SocketOCDemo
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
        int tcpSocket = socket(AF_INET, SOCK_STREAM, 0);
        
        NSCAssert(tcpSocket > 0, @"failuer to creat socket");
        struct sockaddr_in serverAddress,clientAddress;
        memset(&serverAddress, 0, sizeof(serverAddress));
        
        /** 配置服务器参数 */
        serverAddress.sin_family = AF_INET;   // ipv4
        serverAddress.sin_port = htons(4567); // port number
        serverAddress.sin_addr.s_addr = INADDR_ANY;  // 本地地址
        
        /** 绑定服务器socket */
        int bindResault = bind(tcpSocket, (const struct sockaddr *)&serverAddress , sizeof(serverAddress));
        NSCAssert(bindResault >= 0, @"bind socket failuer");
        
        /** 设置socket为监听状态:(并未处理请求) , 第二个参数为请求队列(缓存),表示可以并发的连接的客户端数*/
        listen(tcpSocket, 5);
        
        unsigned int client = sizeof(clientAddress);
        /** 阻塞等待客户端连接 */
        int newClientSocket = accept(tcpSocket, (struct sockaddr *)&clientAddress, &client);
        NSCAssert(newClientSocket > 0, @"accept failuer");
        unsigned int len = sizeof(clientAddress);
        char serverBuffer[256];
        memset(serverBuffer, 0, 256);
        while (true) {
            NSLog(@"waiting for client:");
            long readResult = recvfrom(newClientSocket, serverBuffer, 255, 0, (struct sockaddr *)&clientAddress, &len);
            //        long readResult = read(newClientSocket, serverBuffer, 256);
            NSCAssert(readResult >= 0, @"read failuer");
            NSLog(@"receive client message : %s",serverBuffer);
            
            NSString *readText = [NSString stringWithUTF8String:serverBuffer];
            if ([readText isEqualToString:@"quit"]) {break;}
            memset(serverBuffer, 0, 256);
        }
        
        
       
        close(newClientSocket);
        close(tcpSocket);
        
    }
    return 0;
}
