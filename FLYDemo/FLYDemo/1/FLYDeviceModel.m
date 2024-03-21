//
//  FLYDeviceModel.m
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import "FLYDeviceModel.h"

@implementation FLYDeviceModel

// 初始化一个从归档数据中解码出来的对象实例
- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        // 从归档数据中解码并初始化实例变量
        _wifiName = [coder decodeObjectForKey:@"wifiName"];
        _wifiPassword = [coder decodeObjectForKey:@"wifiPassword"];
    }
    return self;
}

// 将对象编码为归档数据的方法
- (void)encodeWithCoder:(NSCoder *)coder {
    
    // 将实例变量 wifiName 和 wifiPassword 编码为归档数据
    [coder encodeObject:_wifiName forKey:@"wifiName"];
    [coder encodeObject:_wifiPassword forKey:@"wifiPassword"];
}

// 如果一个类遵循了 NSSecureCoding 协议，那么它必须实现 supportsSecureCoding 方法，并且返回 YES。这样可以确保在进行归档和解档操作时，系统能够按照安全的方式来处理对象，以防止潜在的安全漏洞。
+ (BOOL)supportsSecureCoding {
    return YES;
}



@end
