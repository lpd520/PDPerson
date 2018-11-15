//
//  PDCashes.m
//  AnYue
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PDCachesManager.h"


#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]


@implementation PDCachesManager


// 缓存大小
+(NSString *)getCachesSize{
    // 调试
#ifdef DEBUG
    // 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
    // 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
    BOOL isDirectory = NO;
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
        
        [exception raise];
    }
    
    //发布
#else
#endif
    
    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString *filePath = nil;
    long long totalSize = 0;
    
    for (NSString *subpath in subpathArray) {
        
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
        
    }
    
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    
    if (totalSize > 1000 * 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
        
    } else if (totalSize > 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
        
    } else {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
        
    }
    
    return totalSizeString;
    
}

// 清除缓存
+ (void)removeCache{
    
    // 1.拿到cachePath路径的下一级目录的子文件夹
    // contentsOfDirectoryAtPath:error:递归
    // subpathsAtPath:不递归
    
    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    
    // 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subpathArray.count == 0) {
        [SVProgressHUD showNOmessage:@"缓存已清理"];
        return ;
    }

    NSError *error = nil;
    NSString *filePath = nil;
    BOOL flag = NO;
    
    NSString *size = [self getCachesSize];
    
    for (NSString *subpath in subpathArray) {
        
        filePath = [cachePath stringByAppendingPathComponent:subpath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            // 删除子文件夹
            BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            
            if (isRemoveSuccessed) { // 删除成功
                
                flag = YES;
            }
        }
        
    }
    
    if (NO == flag)
        [SVProgressHUD showNOmessage:@"缓存已清理"];
    else
        [SVProgressHUD showYESmessage:[NSString stringWithFormat:@"为您腾出%@空间",size]];
    
    return ;
    
}


@end
