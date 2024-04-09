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

@end

NS_ASSUME_NONNULL_END
