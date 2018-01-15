//
//  PLVNetworkDiagnosisTool.m
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVNetworkDiagnosisTool.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>

@interface PLVNetworkDiagnosisTool ()
{
	NSString *_appCode;  //客户端标记
	NSString *_appName;
	NSString *_appVersion;
	NSString *_UID;       //用户ID
	NSString *_deviceID;  //客户端机器ID，如果不传入会默认取API提供的机器ID
	NSString *_carrierName;
	NSString *_ISOCountryCode;
	NSString *_MobileCountryCode;
	NSString *_MobileNetCode;
	
//	NETWORK_TYPE _curNetType;
	NSString *_localIp;
	NSString *_gatewayIp;
	NSArray *_dnsServers;
	NSArray *_hostAddress;
	
	NSMutableString *_logInfo;  //记录网络诊断log日志
	BOOL _isRunning;
	BOOL _connectSuccess;  //记录连接是否成功
}

@property (nonatomic, strong) PLVTcpConnectionService *connectionManager;

@property (nonatomic, assign) PLVNetworkType networkType;

@end

@implementation PLVNetworkDiagnosisTool

#pragma mark - dealloc

- (instancetype)init {
	if (self = [super init]) {
		_logInfo = [NSMutableString string];
	}
	return self;
}

#pragma mark - property

- (PLVNetworkType)networkType {
	return [PLVDeviceNetworkUtil networkTypeFromStatusBar];
}

- (void)requestAppInfo {
	//输出应用版本信息和用户ID
	NSDictionary *dicBundle = [[NSBundle mainBundle] infoDictionary];
	
	// 应用名称
	NSString *appName = dicBundle[@"CFBundleDisplayName"];
	
	// 应用版本
	if (!_appVersion || [_appVersion isEqualToString:@""]) {
		_appVersion = [dicBundle objectForKey:@"CFBundleShortVersionString"];
	}
	
	//输出机器信息
	UIDevice *device = [UIDevice currentDevice];
	// 系统版本
	NSString *systemName = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
	// UUID∫
	NSString *uuid = @"";
	CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
	uuid = [NSString stringWithString:(__bridge NSString *)uuidString];
	CFRelease(uuidString);
	CFRelease(uuidRef);
	
	
	//运营商信息
	CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier = [netInfo subscriberCellularProvider];
	// 运营商
	NSString *carrierName = carrier.carrierName;
	// ISO 3166-1 country code
	NSString *isoCountryCode = carrier.isoCountryCode;
	// mobile country code (MCC)
	NSString *mobileCountryCode = carrier.mobileCountryCode;
	// mobile network code (MNC)
	NSString *mobileNetworkCode = carrier.mobileNetworkCode;
}

- (void)requestNetworkEnvironment {
	// 诊断域名
	//判断是否联网以及获取网络类型
//	NSArray *typeArr = [NSArray arrayWithObjects:@"2G", @"3G", @"4G", @"5G", @"wifi", nil];
//	_curNetType = [LDNetGetAddress getNetworkTypeFromStatusBar];
//	if (_curNetType == 0) {
//		[self recordStepInfo:[NSString stringWithFormat:@"当前是否联网: 未联网"]];
//	} else {
//		[self recordStepInfo:[NSString stringWithFormat:@"当前是否联网: 已联网"]];
//		if (_curNetType > 0 && _curNetType < 6) {
//			[self
//			 recordStepInfo:[NSString stringWithFormat:@"当前联网类型: %@",
//							 [typeArr objectAtIndex:_curNetType - 1]]];
//		}
//	}
//	
//	//本地ip信息
//	_localIp = [LDNetGetAddress deviceIPAdress];
//	[self recordStepInfo:[NSString stringWithFormat:@"当前本机IP: %@", _localIp]];
//	
//	if (_curNetType == NETWORK_TYPE_WIFI) {
//		_gatewayIp = [LDNetGetAddress getGatewayIPAddress];
//		[self recordStepInfo:[NSString stringWithFormat:@"本地网关: %@", _gatewayIp]];
//	} else {
//		_gatewayIp = @"";
//	}
//	
//	
//	_dnsServers = [NSArray arrayWithArray:[LDNetGetAddress outPutDNSServers]];
//	[self recordStepInfo:[NSString stringWithFormat:@"本地DNS: %@",
//						  [_dnsServers componentsJoinedByString:@", "]]];
//	
//	[self recordStepInfo:[NSString stringWithFormat:@"远端域名: %@", _dormain]];
//	
//	// host地址IP列表
//	long time_start = [LDNetTimer getMicroSeconds];
//	_hostAddress = [NSArray arrayWithArray:[LDNetGetAddress getDNSsWithDormain:_dormain]];
//	long time_duration = [LDNetTimer computeDurationSince:time_start] / 1000;
//	if ([_hostAddress count] == 0) {
//		[self recordStepInfo:[NSString stringWithFormat:@"DNS解析结果: 解析失败"]];
//	} else {
//		[self
//		 recordStepInfo:[NSString stringWithFormat:@"DNS解析结果: %@ (%ldms)",
//						 [_hostAddress componentsJoinedByString:@", "],
//						 time_duration]];
//	}
}

- (void)startNetworkDiagnosis {
	[self recordStepInfo:@"开始诊断..."];
	
	/// 获取 app 信息[self recordCurrentAppVersion];
	
	/// 记录本地网络信息[self recordLocalNetEnvironment];
	
	//未联网不进行任何检测
//	if (_curNetType == 0) {
//		_isRunning = NO;
//		[self recordStepInfo:@"\n当前主机未联网，请检查网络！"];
//		[self recordStepInfo:@"\n网络诊断结束\n"];
//		if (self.delegate && [self.delegate respondsToSelector:@selector(netDiagnosisDidEnd:)]) {
//			[self.delegate netDiagnosisDidEnd:_logInfo];
//		}
//		return;
//	}
	
//	if (_isRunning) {
//		//        [self recordOutIPInfo];
//	}
	
	// connect诊断，同步过程, 如果TCP无法连接，检查本地网络环境
//	_connectSuccess = NO;
//	[self recordStepInfo:@"\n开始TCP连接测试..."];
//	if ([_hostAddress count] > 0) {
//		self.connectionManager = [[PLVTcpConnectionService alloc] init];
//		for (int i = 0; i < [_hostAddress count]; i++) {
//			[_netConnect runWithHostAddress:[_hostAddress objectAtIndex:i] port:80];
//		}
//	} else {
//		[self recordStepInfo:@"DNS解析失败，主机地址不可达"];
//	}
//	if (_isRunning) {
//		[self pingDialogsis:!_connectSuccess];
//	}
//
//
//	if (_isRunning) {
//		//开始诊断traceRoute
//		[self recordStepInfo:@"\n开始traceroute..."];
//		_traceRouter = [[LDNetTraceRoute alloc] initWithMaxTTL:TRACEROUTE_MAX_TTL
//													   timeout:TRACEROUTE_TIMEOUT
//												   self.maxAttempts:TRACEROUTE_ATTEMPTS
//														  port:TRACEROUTE_PORT];
//		_traceRouter.delegate = self;
//		if (_traceRouter) {
//			[NSThread detachNewThreadSelector:@selector(doTraceRoute:)
//									 toTarget:_traceRouter
//								   withObject:_dormain];
//		}
//	}
}

#pragma mark - common method
/**
 * 如果调用者实现了stepInfo接口，输出信息
 */
- (void)recordStepInfo:(NSString *)stepInfo {
	if (stepInfo == nil) stepInfo = @"";
	[_logInfo appendString:stepInfo];
	[_logInfo appendString:@"\n"];
	
//	if (self.delegate && [self.delegate respondsToSelector:@selector(netDiagnosisStepInfo:)]) {
//		[self.delegate netDiagnosisStepInfo:[NSString stringWithFormat:@"%@\n", stepInfo]];
//	}
}

@end
