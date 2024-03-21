//
//  FLYNetworkTools.h
//  Demo
//
//  Created by RXTMacPro3 on 2024/2/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYNetworkTools : NSObject

+ (instancetype)sharedInstance;

// 获取已连接的WiFi名称
- (void)getWiFiNameWithCompletion:(void (^)(NSString *wifiName))completion;

@end

NS_ASSUME_NONNULL_END
