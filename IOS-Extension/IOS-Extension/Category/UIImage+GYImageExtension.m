//
//  UIImage+GYImageExtension.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/19.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "UIImage+GYImageExtension.h"

@implementation UIImage (GYImageExtension)

+ (UIImage *)creatImageForColor:(CGSize)size bgColor:(UIColor *)color {
    //1.首先开启画布
    //UIGraphicsBeginImageContext(<#CGSize size#>) 如果是绘制图片--》 可能会硬气图片失帧
    //如果需要保证图片不失帧，则调用 UIGraphicsBeginImageContextWithOptions(_ size: CGSize, _ opaque: Bool, _ scale: CGFloat) 方法，
    /**
     size —- 图形上下文的大小
     opaque —- 透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
     scale —– 缩放因子,可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了。在Retina屏幕上最好不要自己手动设置他的缩放比例，直接设置0，系统就会自动进行最佳的缩放
     */
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    
    //得到上下文
    CGContextRef contexRef = UIGraphicsGetCurrentContext();
    //设置填充颜色
    CGContextSetFillColorWithColor(contexRef, color.CGColor);
    //填充一个矩形
    CGContextFillRect(contexRef, CGRectMake(0, 0, size.width, size.height));
    
    //得到当前画布上的图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    return resultImage;
}

@end
