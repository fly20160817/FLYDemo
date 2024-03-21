//
//  FLYDataManager.h
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYDataManager : NSObject

// 添加一个新的模型对象
+ (void)addModel:(id)model;

// 删除一个模型对象   (未实现)
+ (void)removeModel:(id)model;

// 修改一个模型对象   (未实现)
+ (void)updateModel:(id)model;

// 获取指定类的所有模型对象数组
+ (NSMutableArray *)getAllModelsForClass:(Class)modelClass;

@end

NS_ASSUME_NONNULL_END
