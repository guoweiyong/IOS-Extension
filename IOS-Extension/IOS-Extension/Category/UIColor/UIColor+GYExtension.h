//
//  UIColor+GYExtension.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/27.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GYExtension)

/// 随机产生一个颜色
+ (UIColor *)randomColor;
+ (UIColor *)rgbColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end

NS_ASSUME_NONNULL_END
