//
//  PLVTcpConnectionService.h
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLVTcpConnectionService : NSObject

@property (nonatomic, assign) int maxConnectCount;

@property (nonatomic, copy, readonly) NSString *resultLog;

@property (nonatomic, copy) void (^connectCompletion)(PLVTcpConnectionService *tcpConnect, BOOL success);

- (void)connectWithHost:(NSString *)host;
- (void)connectWithHost:(NSString *)host port:(NSInteger)port;

@end
