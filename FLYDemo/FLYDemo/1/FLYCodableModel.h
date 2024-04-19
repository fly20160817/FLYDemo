//
//  FLYCodableModel.h
//  FLYKiy
//
//  Created by fly on 2024/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYCodableModel : NSObject <NSCoding, NSSecureCoding>

// identity，给 FLYModelPersistenceManager 类用来查找model的 (只读属性，内部都会给它赋值)
@property (nonatomic, readonly) NSString * identity;

@end

NS_ASSUME_NONNULL_END
