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
#import "FLYDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYDeviceModel : NSObject <NSSecureCoding, FLYDataProtocol>

// 遵守 FLYDataProtocol 协议，必须实现 identity 属性 (用来查找用的) (不用外界赋值，每次创建本类的时候，内部都会给它赋值)
@property (nonatomic,readonly) NSString * identity;

@property (nonatomic,strong) NSString * wifiName;
@property (nonatomic,strong) NSString * wifiPassword;
//型号
@property (nonatomic,strong) NSString * modelNumber;


@end

NS_ASSUME_NONNULL_END
