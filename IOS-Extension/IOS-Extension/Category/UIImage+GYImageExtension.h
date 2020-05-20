//
//  UIImage+GYImageExtension.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/19.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GYImageExtension)
//根据 尺寸生成一张规定尺寸的纯色图片
+ (UIImage *)creatImageForColor:(CGSize)size bgColor:(UIColor *)color;

/// 根据View来截取一张图片
/// @param captureView <#captureView description#>
+ (UIImage *)captureImageForView:(UIView *)captureView;

/// 根据宽度来等比例缩放一张图片
/// @param width <#width description#>
- (UIImage *)imageWithWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
