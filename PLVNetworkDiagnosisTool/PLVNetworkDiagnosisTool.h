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
#import "PLVPingService.h"
#import "PLVTraceRouteService.h"

@interface PLVNetworkDiagnosisTool : NSObject

- (void)startNetworkDiagnosis;

@end
