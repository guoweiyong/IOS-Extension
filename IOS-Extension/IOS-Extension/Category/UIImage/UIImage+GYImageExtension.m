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

+ (UIImage *)clipImageToRound:(UIImage *)originalImage {
    CGSize size = originalImage.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //1.使用Quartz2D来进行裁剪
    //获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //.增加一个圆
    CGContextAddEllipseInRect(contextRef, rect);
    //3裁剪
    CGContextClip(contextRef);

    //但是裁剪之后我们需要把 这个裁剪之后的路径绘制到图片上
    [originalImage drawInRect:rect];
    
//    //使用UIBezierPath
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
//    //在路径上增加一个裁剪内容
//    [bezierPath addClip];
//    [[UIColor orangeColor] setFill];
//
//    //根据添加的裁剪内容，裁剪这个rect
//    UIRectClip(rect);
//
//    //需要把裁剪的图片会知道上下文中
//    [originalImage drawInRect:rect];
    
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)waterAtImage:(UIImage *)originalImage waterText:(NSString *)text startPoint:(CGPoint)point attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    CGSize imageSize = originalImage.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    //首先需要绘制图片
    [originalImage drawInRect: rect];
    
    //开始绘制文字
    [text drawAtPoint:point withAttributes:attrs];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下问
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)waterAtImage:(UIImage *)originalImage waterImage:(UIImage *)waterimage rect:(CGRect)rect {
    CGSize imageSize = originalImage.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    
    CGRect originalRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [originalImage drawInRect:originalRect];
    
    //绘制水印图片
    [waterimage drawInRect:rect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
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
