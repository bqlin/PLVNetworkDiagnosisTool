//
//  PLVDeviceNetworkUtil.h
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PLVNetworkType) {
	PLVNetworkTypeNone = 0,
	PLVNetworkType2G,
	PLVNetworkType3G,
	PLVNetworkType4G,
	PLVNetworkType5G,
	PLVNetworkTypeWiFi
};

/// 获取当前时间
NSInteger PLVCurrentMicroseconds(void);
/// 计算时间间隔
NSInteger PLVTimeIntervalSinceMicroseconds(NSInteger microseconds);

// 优先返回 ipv6 地址
@interface PLVDeviceNetworkUtil : NSObject

+ (NSString *)deviceIp;

+ (NSString *)gatewayIp;
+ (NSString *)ipv4Gateway;
+ (NSString *)ipv6Gateway;

// 在主线程执行会有警告
+ (NSArray *)DNSsWithDomain:(NSString *)domain;
+ (NSArray *)ipv4DNSsWithDomain:(NSString *)domain;
+ (NSArray *)ipv6DNSsWithDomain:(NSString *)domain;

+ (NSArray *)outputDNSServers;

+ (PLVNetworkType)networkTypeFromStatusBar;

@end
