//
//  FLYModelPersistenceManager.m
//  FXActionCamer
//
//  Created by RXTMacPro3 on 2024/3/20.
//  Copyright © 2024 RIXTON. All rights reserved.
//

#import "FLYModelPersistenceManager.h"

@implementation FLYModelPersistenceManager



#pragma mark - public methods

// 添加一个新的模型对象
+ (void)addModel:(id<FLYModelPersistenceProtocol>)model
{
    // 获取指定类的所有模型对象数组
    NSMutableArray *models = [self getAllModelsForClass:[model class]];
    
    // 将新的模型对象添加到数组中
    [models addObject:model];
    
    // 保存更新后的模型对象数组到文件
    [self saveModels:models forClass:[model class]];
}

// 删除一个模型对象
+ (void)removeModel:(id<FLYModelPersistenceProtocol>)model
{
    // 获取指定类的所有模型对象数组
    NSMutableArray *models = [self getAllModelsForClass:[model class]];
    
    // 从数组中移除指定的模型对象
    [models enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<FLYModelPersistenceProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [obj.identity isEqualToString:model.identity] )
        {
            [models removeObjectAtIndex:idx];
            
            // 不能使用removeObject方法，它是根据对象的内存地址来判断是否移除的，我们传进来的对象和数组里的对象可能内容是一样的，但内存地址不一样
            //[models removeObject:model];
        }
    }];
    
    // 保存更新后的模型对象数组到文件
    [self saveModels:models forClass:[model class]];
}

// 修改一个模型对象
+ (void)updateModel:(id<FLYModelPersistenceProtocol>)model
{
    // 获取指定类的所有模型对象数组
    NSMutableArray *models = [self getAllModelsForClass:[model class]];
    
    
    [models enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<FLYModelPersistenceProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [obj.identity isEqualToString:model.identity] )
        {
            // 用新的模型对象替换数组中相应位置的旧模型对象
            [models replaceObjectAtIndex:idx withObject:model];
            
            // 保存更新后的模型对象数组到文件
            [self saveModels:models forClass:[model class]];
        }
    }];
}


// 获取指定类的所有模型对象数组
+ (NSMutableArray *)getAllModelsForClass:(Class<FLYModelPersistenceProtocol>)modelClass
{
    // 从文件中读取保存的模型对象数组的二进制数据
    NSData *data = [NSData dataWithContentsOfFile:[self filePathForModelsForClass:modelClass]];
    
    // 如果数据存在
    if (data)
    {
        // 尝试解档数据为模型对象数组
        NSError *error = nil;
        
        NSMutableSet * set = [NSMutableSet setWithArray:@[NSArray.class,NSDictionary.class, NSString.class, UIFont.class, NSMutableArray.class, NSMutableDictionary.class, NSMutableString.class, UIColor.class, NSMutableData.class, NSData.class, NSNull.class, NSValue.class,NSDate.class]];
        
        // 一定要把模型的class包含进集合，不然解档不出来
        [set addObject:modelClass.class];
        
        NSArray *modelArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:&error];
        
        // 如果解档出错
        if (error) 
        {
            // 输出错误信息
            NSLog(@"Unarchive error: %@", error);
            // 返回一个空的模型对象数组
            return [NSMutableArray array];
        }
        
        // 否则返回解档得到的模型对象数组
        return [NSMutableArray arrayWithArray:modelArray];
    }
    
    // 如果数据不存在，则返回一个空的模型对象数组
    return [NSMutableArray array];
}



#pragma mark - private methods

// 保存模型对象数组到文件
+ (void)saveModels:(NSMutableArray *)models forClass:(Class)modelClass
{
    // 将模型对象数组转换为二进制数据
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:models requiringSecureCoding:YES error:&error];
    
    // 如果转换出错
    if (error) 
    {
        // 输出错误信息
        NSLog(@"Archive error: %@", error);
        // 返回
        return;
    }
    
    // 将二进制数据写入文件
    [data writeToFile:[self filePathForModelsForClass:modelClass] atomically:YES];
}

// 获取保存模型对象的文件路径
+ (NSString *)filePathForModelsForClass:(Class)modelClass
{
    
    // 保存模型数据的文件夹路径
    NSString * directoryPath = [[FLYFileManager documentsPath] stringByAppendingPathComponent:@"ModelData"];
    
    // 如果文件夹不存在
    if ( [FLYFileManager fileExistsWithPath:directoryPath] == NO )
    {
        // 创建一个用于保存模型数据的子文件夹名称
        [FLYFileManager createDirectory:@"ModelData" path:[FLYFileManager documentsPath]];
    }
    
    // 使用模型类的类名作为文件名
    NSString *fileName = NSStringFromClass(modelClass);
    NSString * modelPath = [directoryPath stringByAppendingPathComponent:fileName];
    
    // 返回模型文件路径
    return modelPath;
}



@end
