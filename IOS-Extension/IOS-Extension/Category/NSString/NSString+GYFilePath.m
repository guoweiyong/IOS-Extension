//
//  NSString+GYFilePath.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/26.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "NSString+GYFilePath.h"


@implementation NSString (GYFilePath)

- (NSString *)cachesDir {
    //1.得到caches文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    return [cachesPath stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)preferencesDir {
    NSString *preferencePath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"Preferences"];
    
    return [preferencePath stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)docDir {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return [documentPath stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)tempDir {
    NSString *tempPath  = NSTemporaryDirectory();
    
    return [tempPath stringByAppendingPathComponent:[self lastPathComponent]];
}

@end
