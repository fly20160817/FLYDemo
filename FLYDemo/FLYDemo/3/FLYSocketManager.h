//
//  FLYSocketManager.h
//  Demo
//
//  Created by RXTMacPro3 on 2024/2/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYSocketManager : NSObject

+ (instancetype)socketManager;


/// 连接socket
/// - Parameters:
///   - ip: ip地址
///   - port: 端口
///   - timeout: 超时 (传 -1 永不超时)
///   - success: 连接成功回调
///   - failure: 连接失败回调
- (void)connectToServerWithIP:(NSString *)ip port:(uint16_t)port timeout:(NSTimeInterval)timeout success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/// 断开socket连接
- (void)disconnect;

/// 发送数据
/// - Parameters:
///   - data: 数据
///   - tag: tag
///   - completion: 收到数据的回调
- (void)sendData:(NSData *)data withTag:(long)tag completion:(void (^)(long tag, NSData *receivedData, NSError *error))completion;


@end

NS_ASSUME_NONNULL_END
