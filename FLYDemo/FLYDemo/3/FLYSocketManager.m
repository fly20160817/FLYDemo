//
//  FLYSocketManager.m
//  Demo
//
//  Created by RXTMacPro3 on 2024/2/29.
//

#import "FLYSocketManager.h"
#import "GCDAsyncSocket.h"

@interface FLYSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
// 连接成功回调
@property (nonatomic, copy) void (^connectSuccessBlock)(void);
// 连接失败回调
@property (nonatomic, copy) void (^connectFailureBlock)(NSError *error);
// 存储回调块和标签值的可变字典
@property (nonatomic, strong) NSMutableDictionary<NSString *, void (^)(long tag, NSData *receivedData, NSError *error)> *completionBlocks;

@end

@implementation FLYSocketManager

static FLYSocketManager * _manager;

+ (instancetype)socketManager
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        self.completionBlocks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)connectToServerWithIP:(NSString *)ip port:(uint16_t)port timeout:(NSTimeInterval)timeout success:(void (^)(void))success failure:(void (^)(NSError *error))failure 
{
    // 连接到服务器
    self.connectSuccessBlock = success;
    self.connectFailureBlock = failure;
    
    NSError *error = nil;
    if (![self.socket connectToHost:ip onPort:port withTimeout:timeout error:&error])
    {
        NSLog(@"连接失败: %@", error);
        // 调用连接失败回调
        !self.connectFailureBlock ?: self.connectFailureBlock(error);
    }
}

- (void)disconnect
{
    // 断开socket连接
    [self.socket disconnect];
}

- (NSString *)generateIdentifier 
{
    
    /*
     [[NSUUID UUID] UUIDString] 是 Objective-C 中用来生成唯一标识符的方法。它会生成一个 Universally Unique Identifier（UUID），即通用唯一标识符。每次调用这个方法都会生成一个新的 UUID，因此返回的标识符是唯一的。
     */
    // 生成唯一标识符
    return [[NSUUID UUID] UUIDString];
}

- (void)sendData:(NSData *)data withTag:(long)tag completion:(void (^)(long tag, NSData *receivedData, NSError *error))completion 
{
    self.completionBlocks[[self generateIdentifier]] = completion;
    
    // 发送数据并指定tag值
    [self.socket writeData:data withTimeout:-1 tag:tag];
}



#pragma mark - GCDAsyncSocketDelegate

// 连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功: %@ %hu", host, port);
    
    /*
        连接成功或者收到消息，必须开始read，否则将无法收到消息.
        不read的话，缓存区将会被关闭.
     */
    
    // 开始接收数据
    [self.socket readDataWithTimeout:-1 tag:10086];
    
    !self.connectSuccessBlock ?: self.connectSuccessBlock();
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if ( err )
    {
        NSLog(@"连接意外断开：%@", sock.localHost);
        NSLog(@"意外断开原因：%@", err);
        !self.connectFailureBlock ?: self.connectFailureBlock(err);
    }
    else
    {
        NSLog(@"断开连接成功");
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag 
{
    
//    // 进行下一次数据读取
//    [sock readDataWithTimeout:-1 tag:tag];
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"didReadData:%@", jsonString);
    
    
    for (NSString *identifier in self.completionBlocks.allKeys)
    {
        void (^completion)(long, NSData *, NSError *) = self.completionBlocks[identifier];
        if (completion)
        {
            completion(tag, data, nil);
            [self.completionBlocks removeObjectForKey:identifier]; // 移除完成块
        }
    }

}

//消息发送成功 代理函数 向服务器 发送消息
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"数据发送成功, tag = %ld",tag);
    
    // 发送成功之后，主动去读取结果
    [sock readDataWithTimeout:-1 tag:tag];
}

@end
