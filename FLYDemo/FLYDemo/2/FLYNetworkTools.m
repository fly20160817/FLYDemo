//
//  FLYNetworkTools.m
//  Demo
//
//  Created by RXTMacPro3 on 2024/2/29.
//

#import "FLYNetworkTools.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreLocation/CoreLocation.h>

@interface FLYNetworkTools () < CLLocationManagerDelegate >

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^completionBlock)(NSString *wifiName);

@end

@implementation FLYNetworkTools

static FLYNetworkTools *_instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FLYNetworkTools alloc] init];
    });
    return _instance;
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
        status == kCLAuthorizationStatusAuthorizedAlways)
    {
        // 定位服务被授权，获取WiFi名称
        NSString *wifiName = [self getCurrentWiFiSSID];
        // 调用完成块并传递WiFi名称
        if (self.completionBlock)
        {
            self.completionBlock(wifiName);
        }
    }
    else if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
    {
        // 定位服务被拒绝或受限制，传递空的WiFi名称
        if (self.completionBlock)
        {
            self.completionBlock(nil);
        }
    }
}



#pragma mark - public methods

// 获取已连接的WiFi名称
- (void)getWiFiNameWithCompletion:(void (^)(NSString *wifiName))completion
{
    /*
     在 iOS 中，获取当前连接的 WiFi 信息需要使用 CoreLocation 框架并请求位置权限。
     因为 iOS 将 WiFi 信息视为一种位置信息，并要求应用获取相应的权限。
     所以在调用 CNCopyCurrentNetworkInfo 方法之前，需要确保你的应用已经请求了适当的位置权限。
     
     精确定位的权限一定得给，不然也获取不到。
     */
    
    
    self.completionBlock = completion;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 请求定位授权
    [self.locationManager requestWhenInUseAuthorization];
    
}



#pragma mark - private methods

// 获取已连接的WiFi名称
- (NSString *)getCurrentWiFiSSID
{
    NSString *wifiName = nil;
    
    // 获取当前网络信息
    NSArray *interfaces = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    
    for (NSString *interface in interfaces)
    {
        // 获取当前网络接口的信息
        NSDictionary *networkInfo = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
        
        // 如果SSID存在（即WiFi名称不为空）
        if (networkInfo[@"SSID"])
        {
            // 获取WiFi名称
            wifiName = networkInfo[@"SSID"];
            
            // 找到WiFi名称后退出循环
            break;
        }
    }
    
    return wifiName;
}


@end
