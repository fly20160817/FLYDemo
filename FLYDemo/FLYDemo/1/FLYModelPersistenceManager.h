//
//  FLYModelPersistenceManager.h
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLYCodableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYModelPersistenceManager : NSObject

/** 必须是 FLYCodableModel 的子类才能使用本类。FLYCodableModel类内部有归档、解档，还有供本类查询用的id */


// 添加一个新的模型对象
+ (void)addModel:(FLYCodableModel *)model;

// 删除一个模型对象
+ (void)removeModel:(FLYCodableModel *)model;

// 修改一个模型对象
+ (void)updateModel:(FLYCodableModel *)model;

// 获取指定类的所有模型对象数组
+ (NSMutableArray *)getAllModelsForClass:(Class)modelClass;

@end

NS_ASSUME_NONNULL_END
