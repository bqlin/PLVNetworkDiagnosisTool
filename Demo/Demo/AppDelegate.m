//
//  AppDelegate.m
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "AppDelegate.h"
#import "PLVNetworkDiagnosisTool.h"
//#import "LDNetConnect.h"

@interface AppDelegate ()

@property (nonatomic, strong) PLVTcpConnectionService *connectionManager;
@property (nonatomic, strong) PLVNetworkDiagnosisTool *diagnosisTool;
//@property (nonatomic, strong) LDNetConnect *connect;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
//	NSString *deviceIp = [PLVDeviceNetworkUtil deviceIp];
//	NSLog(@"deviceIp: %@", deviceIp);
	
//	NSString *gatewayIp = [PLVDeviceNetworkUtil gatewayIp];
//	NSLog(@"gatewayIp: %@", gatewayIp);
//	NSString *ipv4Gateway = [PLVDeviceNetworkUtil ipv4Gateway];
//	NSLog(@"ipv4Gateway: %@", ipv4Gateway);
//	NSString *ipv6Gateway = [PLVDeviceNetworkUtil ipv6Gateway];
//	NSLog(@"ipv6Gateway: %@", ipv6Gateway);
//
//	NSString *domain = @"polyv.net";
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		NSArray *DNSs = [PLVDeviceNetworkUtil DNSsWithDomain:domain];
//		NSLog(@"DNSs: %@", DNSs);
//		NSArray *ipv4DNSs = [PLVDeviceNetworkUtil ipv4DNSsWithDomain:domain];
//		NSLog(@"ipv4DNSs: %@", ipv4DNSs);
//		NSArray *ipv6DNSs = [PLVDeviceNetworkUtil ipv6DNSsWithDomain:domain];
//		NSLog(@"ipv6DNSs: %@", ipv6DNSs);
//	});
//
//	NSArray *outputDNSServers = [PLVDeviceNetworkUtil outputDNSServers];
//	NSLog(@"outputDNSServers: %@", outputDNSServers);
//
//	PLVNetworkType networkType = [PLVDeviceNetworkUtil networkTypeFromStatusBar];
//	networkType = 0;
	
//	__weak typeof(self) weakSelf = self;
//	self.connectionService = [PLVTcpConnectionService new];
//	self.connectionService.connectCompletion = ^(BOOL success) {
//		NSString *result = weakSelf.connectionService.result;
//		NSLog(@"result: %@", result);
//	};
//	[self.connectionService connectWithHost:domain];
	
	
	
//	self.diagnosisTool = [PLVNetworkDiagnosisTool new];
//	[self.diagnosisTool startNetworkDiagnosis];
	
//	self.connect = [[LDNetConnect alloc] init];
//	self.connect.delegate = self;
//	[self.connect runWithHostAddress:domain port:80];
	
	return YES;
}

- (void)appendSocketLog:(NSString *)socketLog {
	NSLog(@"socket: %@", socketLog);
}
- (void)connectDidEnd:(BOOL)success {
	NSLog(@"%s - %@ %s", __FUNCTION__, [NSThread currentThread], success?"YES":"NO");
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
