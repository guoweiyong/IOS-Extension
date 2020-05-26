//
//  NSString+GYFilePath.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/26.
//  Copyright © 2020 yunyi. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 字符串和文件路径的组合
 1.每个APP下都有一个沙河路径，就是在本地app的文件目录，隔离于其他的app，系统不允许其他app访问别的app的沙河路径
 2.IOS的沙河下主要包含改下三个文件夹: Documents、Library(内含Caches和Preferences)、temp
 3.Home目录 NSString *homeDirectory = NSHomeDirectory();
 
       Documents: 该目录会被iTues自动备份，建议储存需要持久化的存储的数据，将程序中建立的或者重要的文件数据放在该目录下
       Library: 里面包含两个文件夹Caches 和 Preferences
                Caches: 主要储存缓存数据，缓存数据在设备低存储空间的时候可能会被磁盘删除，iTues或iCloud不会对其进行备份
                Preferences : 保存app的偏好设置和其他设置，iTues会自动备份该目录，NSUserDefaults就是默认存放在此文件夹下面
      temp: 临时文件夹，iTunes不会同步该目录，保存app运行中的临时文件。
            建议用完即删除，iphone重启会自动删除本目录下的文件。
 */

@interface NSString (GYFilePath)

/// 得到一个拼接的文件路径（cachesDirectory）字符串
- (NSString *)cachesDir;

/// 得到一个拼接的Preferences文件路径
- (NSString *)preferencesDir;

///得到一个拼接文件路径（documentDirectory）字符串
- (NSString *)docDir;

/// 得到一个拼接文件路径（temp）字符串
- (NSString *)tempDir;

@end

NS_ASSUME_NONNULL_END
