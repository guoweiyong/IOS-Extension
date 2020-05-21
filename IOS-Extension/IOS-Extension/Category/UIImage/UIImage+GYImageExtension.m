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
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    //得到上下文
    CGContextRef contexRef = UIGraphicsGetCurrentContext();
    //设置填充颜色
    CGContextSetFillColorWithColor(contexRef, color.CGColor);
    //填充一个矩形
    CGContextFillRect(contexRef, CGRectMake(0, 0, size.width, size.height));
    //还可以使用UIBezierPath来填充路径
    
    
    //得到当前画布上的图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束画布
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)captureImageForView:(UIView *)captureView {
    UIGraphicsBeginImageContextWithOptions(captureView.frame.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();//得到当前上下文
    //CGContextAddRect(contextRef, frame);//画一个矩形
    
    /**
    This method renders directly from the layer tree, ignoring any animations added to the render tree. Renders in the coordinate space of the layer.
    Listing 1 shows how you can use render(in:) to create a UIImage from a CAShapeLayer with a path that describes a circle. After creating the layer, the code creates a CGContext into which the circle is rendered. After rendering, UIGraphicsGetImageFromCurrentImageContext() generates the image.
    
    大概意思是：
    此方法直接从层树渲染，忽略添加到渲染树的任何动画。在层的坐标空间中渲染。
    呈现后，UIGraphicsGetImageFromCurrentImageContext（）生成图像。
    
    */
    [captureView.layer renderInContext:contextRef];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;

}

- (UIImage *)imageWithWidth:(CGFloat)width {
    CGFloat height = width * self.size.height / self.size.width;
    CGSize currentSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContextWithOptions(currentSize, false, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, currentSize.width, currentSize.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return resultImage;
}
@end