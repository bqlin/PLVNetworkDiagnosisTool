//
//  ViewController.m
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "ViewController.h"
#import "PLVNetworkDiagnosisTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) PLVTcpConnectionService *connectionManager;
@property (nonatomic, strong) PLVPingService *pingService;
@property (nonatomic, copy) NSString *domain;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.domain = @"www.baidu.com";
	self.domain = @"polyv.net";
	self.pingService = [[PLVPingService alloc] init];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)check:(UIBarButtonItem *)sender {
	[self.pingService pingWithHost:self.domain];
	__weak typeof(self) weakSelf = self;
	self.pingService.pingCompletion = ^(PLVPingService *pingService, NSString *result) {
		dispatch_async(dispatch_get_main_queue(), ^{
			weakSelf.textView.text = result;
		});
	};
}

- (void)checkTCPConnect {
	__weak typeof(self) weakSelf = self;
	self.connectionManager = [PLVTcpConnectionService new];
	self.connectionManager.connectCompletion = ^(PLVTcpConnectionService *tcpConnect, BOOL success) {
		NSString *result = weakSelf.connectionManager.resultLog;
		dispatch_async(dispatch_get_main_queue(), ^{
			weakSelf.textView.text = result;
		});
	};
	[self.connectionManager connectWithHost:self.domain];
}

@end
