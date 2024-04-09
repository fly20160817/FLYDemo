//
//  FLYReadDocumentData.m
//  FLYKit
//
//  Created by fly on 2024/4/2.
//  Copyright © 2024 fly. All rights reserved.
//

#import "FLYReadDocumentData.h"
#import <Photos/Photos.h>


@interface FLYReadDocumentData () < UIDocumentPickerDelegate >

@end

@implementation FLYReadDocumentData

+ (void)readDocumentData
{
    // 解决导航栏挡住内容的问题
    UINavigationBar.appearance.translucent = NO;
    
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image", @"public.movie"] inMode:UIDocumentPickerModeOpen];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[FLYTools currentViewController] presentViewController:documentPicker animated:YES completion:nil];
}


+ (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{
   
    // 处理用户选择的文件
    NSLog(@"urls = %@", urls);
    
    NSURL * fileURL = urls.firstObject;
    
    
    
    /*
     [fileURL startAccessingSecurityScopedResource] 是一个方法调用，用于请求访问一个安全范围内的文件或文件夹。在iOS中，访问受保护的文件系统资源（例如用户的照片库或iCloud驱动器）需要获取权限，以便应用程序可以读取或写入相关文件。当你使用此方法时，系统会尝试授予你对文件的安全访问权限。如果成功，你就可以在随后的代码中访问该文件的内容。需要注意的是，在访问完成后，你需要调用stopAccessingSecurityScopedResource来释放访问权限。
     */
    //http://www.manongjc.com/detail/23-tzpztfodaltuvxb.html
    // 获取授权
    BOOL fileUrlAuthozied = [fileURL startAccessingSecurityScopedResource];
    
    NSLog(@"授权结果: %d", fileUrlAuthozied);
    
    
    
    
    if ( [fileURL.absoluteString containsString:@".mp4"] || [fileURL.absoluteString containsString:@".MP4"] || [fileURL.absoluteString containsString:@".mov"] || [fileURL.absoluteString containsString:@".MOV"] )
    {
        
        [SVProgressHUD showWithStatus:@"视频读取中"];
        
        
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
        
        // 创建导出会话
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetPassthrough];
        
        // 设置导出文件路径
        NSString *outputPath = [NSString stringWithFormat:@"%@/%@.%@", [FLYFileManager cachePath], [NSDate currentTimeStamp], [fileURL.absoluteString pathExtension]];
        NSURL *outputURL = [NSURL fileURLWithPath:outputPath];
        exportSession.outputURL = outputURL;
        
        // 设置导出文件类型
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        // 导出视频
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                
                [SVProgressHUD dismiss];
                
                // 视频导出成功，可以在此处保存导出的视频文件
                NSLog(@"视频导出成功，路径：%@", outputPath);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 要做什么操作，记得回到主线程
                });

                
            } else {
                // 视频导出失败，处理错误情况
                NSError *error = exportSession.error;
                NSLog(@"视频导出失败，错误：%@", error.localizedDescription);
                
                [SVProgressHUD showImage:nil status:@"视频导出失败"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 要做什么操作，记得回到主线程
                });
            }
        }];
        
    }
    else if ( [fileURL.absoluteString containsString:@".png"] || [fileURL.absoluteString containsString:@".PNG"] || [fileURL.absoluteString containsString:@".jpg"] || [fileURL.absoluteString containsString:@".JPG"] )
    {
        
        UIImage * image = [UIImage imageWithContentsOfFile:fileURL.path];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 要做什么操作，记得回到主线程
        });

    }
    else
    {
        [SVProgressHUD showImage:nil status:@"文件格式无效"];
        
        [fileURL stopAccessingSecurityScopedResource];
    }
    
    
}



@end
