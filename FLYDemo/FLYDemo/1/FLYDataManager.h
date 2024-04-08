//
//  FLYDataManager.h
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLYDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYDataManager : NSObject

// 必须遵守 FLYDataProtocol 协议的对象才能调用，协议内定一个id属性，内部用来查找用。


// 添加一个新的模型对象
+ (void)addModel:(id<FLYDataProtocol>)model;

// 删除一个模型对象   (未实现)
+ (void)removeModel:(id<FLYDataProtocol>)model;

// 修改一个模型对象   (未实现)
+ (void)updateModel:(id<FLYDataProtocol>)model;

// 获取指定类的所有模型对象数组
+ (NSMutableArray *)getAllModelsForClass:(Class<FLYDataProtocol>)modelClass;

@end

NS_ASSUME_NONNULL_END
