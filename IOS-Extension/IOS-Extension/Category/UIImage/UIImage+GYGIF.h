//
//  UIImage+GYGIF.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/27.
//  Copyright © 2020 yunyi. All rights reserved.
//


#import <UIKit/UIKit.h>

// 加载GIF图文件完成block 动态图片  GIF图片数组  GIF动画总时间
typedef void(^GIFImageCompleteBlock)(UIImage * _Nullable image, NSArray * _Nullable gifImages, float totalDuration);

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GYGIF)


/// 加载本地的GIF图
/// @param imageData <#imageData description#>
+ (UIImage *)animationGIFImageWithData:(NSData *)imageData;

/// 根据名字来加载本地GIF图
+ (UIImage *)animationGIFImageWithName:(NSString *)name;

/// 加载背地GIF文件
/// @param complete <#complete description#>
+ (void)loadGIFImageWithData:(NSData *)imageData complete:(GIFImageCompleteBlock)complete;

/// 根据文件名称加载本地GIF图
/// @param name <#name description#>
/// @param complete <#complete description#>
+ (void)loadGIFImageWithName:(NSString *)name complete:(GIFImageCompleteBlock)complete;
@end

NS_ASSUME_NONNULL_END
