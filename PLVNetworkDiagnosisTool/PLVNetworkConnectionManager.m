//
//  PLVNetworkConnectionManager.m
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVNetworkConnectionManager.h"
#import "PLVNetworkDiagnosisTool.h"

@interface PLVNetworkConnectionManager ()

@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger port;
@property (nonatomic, assign) BOOL isIpv6;

@property (nonatomic, assign) CFSocketRef socket;

@property (nonatomic, copy) NSString *resultLog;

//监测是否有connect成功
@property (nonatomic, assign) BOOL isExistSuccess;

//当前执行次数
@property (nonatomic, assign) int connectCount;

@property (nonatomic, assign) NSInteger sumTime;

@end

@implementation PLVNetworkConnectionManager

- (instancetype)init {
	if (self = [super init]) {
		_resultLog = @"";
		_maxConnectCount = 3;
	}
	return self;
}

- (void)connectWithHost:(NSString *)host {
	[self connectWithHost:host port:80];
}
- (void)connectWithHost:(NSString *)host port:(NSInteger)port {
	self.host = host;
	self.port = port;
	BOOL isIpv6 = [host rangeOfString:@":"].location != NSNotFound;
	self.isIpv6 = isIpv6;
	self.startTime = PLVCurrentMicroseconds();
	
	// 开始连接
	[self connect];
	
	do {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	} while (self.connectCount < self.maxConnectCount);
}

- (void)connect {
	NSData *addrData = nil;
	
	//设置地址
	if (self.isIpv6) {
		struct sockaddr_in6 nativeAddr6;
		memset(&nativeAddr6, 0, sizeof(nativeAddr6));
		nativeAddr6.sin6_len = sizeof(nativeAddr6);
		nativeAddr6.sin6_family = AF_INET6;
		nativeAddr6.sin6_port = htons(self.port);
		inet_pton(AF_INET6, self.host.UTF8String, &nativeAddr6.sin6_addr);
		addrData = [NSData dataWithBytes:&nativeAddr6 length:sizeof(nativeAddr6)];
	} else {
		struct sockaddr_in nativeAddr4;
		memset(&nativeAddr4, 0, sizeof(nativeAddr4));
		nativeAddr4.sin_len = sizeof(nativeAddr4);
		nativeAddr4.sin_family = AF_INET;
		nativeAddr4.sin_port = htons(self.port);
		inet_pton(AF_INET, self.host.UTF8String, &nativeAddr4.sin_addr.s_addr);
		addrData = [NSData dataWithBytes:&nativeAddr4 length:sizeof(nativeAddr4)];
	}
	
	if (addrData != nil) {
		[self connectWithAddress:addrData];
	}
}

- (void)connectWithAddress:(NSData *)addr {
	struct sockaddr *pSockAddr = (struct sockaddr *)[addr bytes];
	int addressFamily = pSockAddr->sa_family;
	
	//创建套接字
	CFSocketContext CTX = {0, (__bridge_retained void *)(self), NULL, NULL, NULL};
	self.socket = CFSocketCreate(kCFAllocatorDefault, addressFamily, SOCK_STREAM, IPPROTO_TCP,
							 kCFSocketConnectCallBack, TCPServerConnectCallBack, &CTX);
	
	//执行连接
	CFSocketConnectToAddress(self.socket, (__bridge CFDataRef)addr, 3);
	CFRunLoopRef cfrl = CFRunLoopGetCurrent();  // 获取当前运行循环
	CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self.socket, self.connectCount);  //定义循环对象
	CFRunLoopAddSource(cfrl, source, kCFRunLoopDefaultMode);  //将循环对象加入当前循环中
	CFRelease(source);
}


/// 连接回调函数
static void TCPServerConnectCallBack(CFSocketRef socket, CFSocketCallBackType type,
									 CFDataRef address, const void *data, void *info) {
	if (data != NULL) {
		printf("connect");
		PLVNetworkConnectionManager *manager = (__bridge_transfer PLVNetworkConnectionManager *)info;
		[manager readStream:FALSE];
	} else {
		PLVNetworkConnectionManager *manager = (__bridge_transfer PLVNetworkConnectionManager *)info;
		[manager readStream:TRUE];
	}
}

- (void)readStream:(BOOL)success {
	//    NSString *errorLog = @"";
	if (success) {
		self.isExistSuccess = YES;
		NSInteger interval = PLVTimeIntervalSinceMicroseconds(self.startTime) / 1000;
		self.sumTime += interval;
		NSLog(@"connect success %ld", (long)interval);
		self.resultLog = [self.resultLog stringByAppendingString:[NSString stringWithFormat:@"%d's time=%ldms, ", self.connectCount + 1, (long)interval]];
	} else {
		self.sumTime = 99999;
		self.resultLog = [self.resultLog stringByAppendingString:[NSString stringWithFormat:@"%d's time=TimeOut, ", self.connectCount + 1]];
	}
	if (self.connectCount == self.maxConnectCount - 1) {
		if (self.sumTime >= 99999) {
			self.resultLog = [self.resultLog substringToIndex:[self.resultLog length] - 1];
		} else {
			self.resultLog = [self.resultLog stringByAppendingString:[NSString stringWithFormat:@"average=%ldms", (long)(self.sumTime / 4)]];
		}
//		if (self.delegate && [self.delegate respondsToSelector:@selector(appendSocketLog:)]) {
//			[self.delegate appendSocketLog:self.resultLog];
//		}
	}
	
	CFRelease(self.socket);
	self.connectCount++;
	if (self.connectCount < self.maxConnectCount) {
		self.startTime = PLVCurrentMicroseconds();
		[self connect];
	} else {
		if (self.connectCompletion) self.connectCompletion(self.isExistSuccess);
	}
}

@end
