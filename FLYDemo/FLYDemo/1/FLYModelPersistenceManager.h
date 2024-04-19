//
//  FLYModelPersistenceManager.h
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLYModelPersistenceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYModelPersistenceManager : NSObject

// 必须遵守 FLYModelPersistenceProtocol 协议的对象才能调用，协议内有一个id属性，本类内部用来查找model用。


// 添加一个新的模型对象
+ (void)addModel:(id<FLYModelPersistenceProtocol>)model;

// 删除一个模型对象
+ (void)removeModel:(id<FLYModelPersistenceProtocol>)model;

// 修改一个模型对象
+ (void)updateModel:(id<FLYModelPersistenceProtocol>)model;

// 获取指定类的所有模型对象数组
+ (NSMutableArray *)getAllModelsForClass:(Class<FLYModelPersistenceProtocol>)modelClass;

@end

NS_ASSUME_NONNULL_END
