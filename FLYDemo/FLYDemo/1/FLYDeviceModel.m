//
//  FLYDeviceModel.m
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import "FLYDeviceModel.h"

@interface FLYDeviceModel ()

// 遵守 FLYDataProtocol 协议，必须实现 identity 属性 (用来查找用的) (不用外界赋值，每次创建本类的时候，内部都会给它赋值)
@property (nonatomic, strong) NSString * identity;

@end

@implementation FLYDeviceModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*
         [[NSUUID UUID] UUIDString] 是 Objective-C 中用来生成唯一标识符的方法。它会生成一个 Universally Unique Identifier（UUID），即通用唯一标识符。每次调用这个方法都会生成一个新的 UUID，因此返回的标识符是唯一的。
         */
        // 生成唯一标识符
        self.identity = [[NSUUID UUID] UUIDString];
    }
    return self;
}

// 初始化一个从归档数据中解码出来的对象实例
- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        // 从归档数据中解码并初始化实例变量
        _identity = [coder decodeObjectForKey:@"identity"];
        _wifiName = [coder decodeObjectForKey:@"wifiName"];
        _wifiPassword = [coder decodeObjectForKey:@"wifiPassword"];
        _modelNumber = [coder decodeObjectForKey:@"modelNumber"];
    }
    return self;
}

// 将对象编码为归档数据的方法
- (void)encodeWithCoder:(NSCoder *)coder {
    
    // 将实例变量 wifiName 和 wifiPassword 编码为归档数据
    [coder encodeObject:_identity forKey:@"identity"];
    [coder encodeObject:_wifiName forKey:@"wifiName"];
    [coder encodeObject:_wifiPassword forKey:@"wifiPassword"];
    [coder encodeObject:_modelNumber forKey:@"modelNumber"];
}

// 如果一个类遵循了 NSSecureCoding 协议，那么它必须实现 supportsSecureCoding 方法，并且返回 YES。这样可以确保在进行归档和解档操作时，系统能够按照安全的方式来处理对象，以防止潜在的安全漏洞。
+ (BOOL)supportsSecureCoding {
    return YES;
}


@end
