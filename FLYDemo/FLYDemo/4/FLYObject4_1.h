//
//  FLYReadDocumentData.h
//  FLYKit
//
//  Created by fly on 2024/4/9.
//  Copyright © 2024 fly. All rights reserved.
//


/*
 
 从系统的"文件"app中获取数据，包括插在充电口的sd卡里也能获取
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYReadDocumentData : NSObject

+ (void)readDocumentData;

// 待开发
// 1.readDocumentData最好是在block返回选择的路径
// 2.FLYPhotoManager方法增加保存视频的功能

@end

NS_ASSUME_NONNULL_END
