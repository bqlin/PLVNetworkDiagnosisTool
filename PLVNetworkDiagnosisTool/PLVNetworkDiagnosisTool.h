//
//  PLVNetworkDiagnosisTool.h
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLVDeviceNetworkUtil.h"
#import "PLVTcpConnectionService.h"

/// 获取当前时间
NSInteger PLVCurrentMicroseconds(void);
/// 计算时间间隔
NSInteger PLVTimeIntervalSinceMicroseconds(NSInteger microseconds);

@interface PLVNetworkDiagnosisTool : NSObject

- (void)startNetworkDiagnosis;

@end
