//
//  FLYDeviceModel.h
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//



/***************************************************
 
需要解归档的类，必须遵循 NSSecureCoding 协议，.m文件里还要实现三个方法
 
***************************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYDeviceModel : NSObject <NSSecureCoding>

@property (nonatomic,strong) NSString * wifiName;
@property (nonatomic,strong) NSString * wifiPassword;

@end

NS_ASSUME_NONNULL_END
