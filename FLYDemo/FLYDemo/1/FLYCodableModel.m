//
//  FLYCodableModel.m
//  FLYKiy
//
//  Created by fly on 2024/4/19.
//

#import "FLYCodableModel.h"
#import <objc/runtime.h>

@interface FLYCodableModel ()

@property (nonatomic, strong) NSString * identity;

@end

@implementation FLYCodableModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*
         [[NSUUID UUID] UUIDString] 是 Objective-C 中用来生成唯一标识符的方法。它会生成一个 Universally Unique Identifier（UUID），即通用唯一标识符。每次调用这个方法都会生成一个新的 UUID，因此返回的标识符是唯一的。
         */
        // 生成唯一标识符
        self.identity = [[NSUUID UUID] UUIDString];
    }
    return self;
}

// 初始化一个从归档数据中解码出来的对象实例
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        // 遍历属性列表并解码
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(properties);
        
        
        
        /** 上面方法遍历处理了，就不用每个类都一个一个属性的处理了 */
        
        //        // 从归档数据中解码并初始化实例变量
        //        _identity = [coder decodeObjectForKey:@"identity"];
        //        _wifiName = [coder decodeObjectForKey:@"wifiName"];
        //        _wifiPassword = [coder decodeObjectForKey:@"wifiPassword"];
        
    }
    return self;
}

// 将对象编码为归档数据的方法
- (void)encodeWithCoder:(NSCoder *)coder {
    // 遍历属性列表并编码
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
    free(properties);
    
    
    
    /** 上面方法遍历处理了，就不用每个类都一个一个属性的处理了 */
    
    // 将实例变量 wifiName 和 wifiPassword 编码为归档数据
    //    [coder encodeObject:_identity forKey:@"identity"];
    //    [coder encodeObject:_wifiName forKey:@"wifiName"];
    //    [coder encodeObject:_wifiPassword forKey:@"wifiPassword"];
    
}


// 如果一个类遵循了 NSSecureCoding 协议，那么它必须实现 supportsSecureCoding 方法，并且返回 YES。这样可以确保在进行归档和解档操作时，系统能够按照安全的方式来处理对象，以防止潜在的安全漏洞。
+ (BOOL)supportsSecureCoding {
    return YES;
}


@end
