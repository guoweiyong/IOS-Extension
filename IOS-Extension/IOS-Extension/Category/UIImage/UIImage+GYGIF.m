//
//  UIImage+GYGIF.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/27.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "UIImage+GYGIF.h"



@implementation UIImage (GYGIF)

+ (UIImage *)animationGIFImageWithData:(NSData *)imageData {
    if (imageData == nil) {
        return nil;
    }
    //首先从data中读取数据，将data转成CGImageSource对象 __bridge把OC对象转换成CF对象，但是不转换对象所有权，还是需要我们手动释放对象
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    //获取gif图片的个数(size_t是一些C/C++标准在stddef.h中定义的。这个类型足以用来表示对象的大小。无符号类型)
    size_t imageCount = CGImageSourceGetCount(imageSourceRef);
    UIImage *animationImage;
    if (imageCount <= 1) {
        animationImage = [[UIImage alloc] initWithData:imageData];
    } else {
        //储存图片的数组
        NSMutableArray *images = [NSMutableArray array];
        //总时间
        NSTimeInterval totalDuration = 0.0f;
        for (size_t i = 0; i < imageCount; i++) {
            //取出图片
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSourceRef, i, NULL);
            if (!cgImage) {
                continue;
            }
            UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
            [images addObject:image];
            
            CFRelease(cgImage);
            
            //取出持续的时间
            totalDuration += [self frameDurationAtIndex:i source:imageSourceRef];
        }
        //如果时间
        if (!totalDuration) {
            
            totalDuration = (1.0f / 10.0f)*imageCount;
        }
        //生成一张动态图
        animationImage = [UIImage animatedImageWithImages:images duration:totalDuration];
    }
    
    CFRelease(imageSourceRef);
    
    return animationImage;
}

+ (UIImage *)animationGIFImageWithName:(NSString *)name {
    NSData *imageData = [self getDataWith:name];
    if (imageData) {
        return [UIImage animationGIFImageWithData:imageData];
    }
    
    return [UIImage imageNamed:name];
}

+ (void)loadGIFImageWithData:(NSData *)imageData complete:(GIFImageCompleteBlock)complete {
    if (imageData == nil) {
        complete(nil, nil, 0.0f);
    }
    //首先从data中读取数据，将data转成CGImageSource对象 __bridge把OC对象转换成CF对象，但是不转换对象所有权，还是需要我们手动释放对象
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    //获取gif图片的个数(size_t是一些C/C++标准在stddef.h中定义的。这个类型足以用来表示对象的大小。无符号类型)
    size_t imageCount = CGImageSourceGetCount(imageSourceRef);
    
    UIImage *animationImage;
    //储存图片的数组
    NSMutableArray *images = [NSMutableArray array];
    //总时间
    NSTimeInterval totalDuration = 0.0f;
    
    if (imageCount <= 1) {
        animationImage = [[UIImage alloc] initWithData:imageData];
    } else {
        for (size_t i = 0; i < imageCount; i++) {
            //取出图片
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSourceRef, i, NULL);
            if (!cgImage) {
                continue;
            }
            UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
            [images addObject:image];
            
            CFRelease(cgImage);
            
            //取出持续的时间
            totalDuration += [self frameDurationAtIndex:i source:imageSourceRef];
        }
        //如果时间
        if (!totalDuration) {
            
            totalDuration = (1.0f / 10.0f)*imageCount;
        }
        //生成一张动态图
        animationImage = [UIImage animatedImageWithImages:images duration:totalDuration];
    }
    
    CFRelease(imageSourceRef);
    
    complete(animationImage, images, totalDuration);
}

+ (void)loadGIFImageWithName:(NSString *)name complete:(GIFImageCompleteBlock)complete {
    NSData *data = [self getDataWith:name];
    [UIImage loadGIFImageWithData:data complete:^(UIImage * _Nullable image, NSArray * _Nullable gifImages, float totalDuration) {
        complete(image, gifImages, totalDuration);
    }];
}

/// 获取一个GIF图的总时间
/// @param index <#index description#>
/// @param imageSourceRef <#imageSourceRef description#>
+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)imageSourceRef {
    
    /**
     最近要做 GIF 的显示, 在解析 GIF 源文件的时候发现 GIF 的图片时间控制有两个 DelayTime&UnclampedDelayTime 延时, 所以想要了解下这两个的用处和区别.
     
     很多 GIF 图片为了得到最快的显示速度会把 duration 设置为 0, 浏览器在显示他们的时候为了性能考虑就会给他们减速(clamp), 因为很多 GIF 都是无限循环播放的.
     
     在看很多获取 duration 的源码, 逻辑都是先获取 UnclampedDelayTime, 如果没有就取 delayTime, 如果这个值太小就设置为 0.1. 据说 RFC 规定的是不能少于 40ms.
     
     kCGImagePropertyGIFDelayTime 是以秒为单位的时间度量, 表示在图片序列中等待下一帧图片显示的时间. 如果时间少于 50ms, 那么实际上存储的时间实际上是 100ms.
     
     kCGImagePropertyGIFUnclampedDelayTime 时间度量, 单位为秒, 表示在动画序列中等待下一帧图片显示的等待时间. 该值可能是 0ms 或者稍高. 和 DelayTime 的区别就是这个值不会在数据下限(比如 50 ms 以下), 减速显示.
     
     实际上这两个值怎么取舍还是存疑, depends on the cat.
     抛砖引玉, 请教了.
     
     合成gif时每帧之间间隔的属性。
     kCGImagePropertyGIFDelayTime限定了最小的事件间隔范围，如果小于50ms，则是100ms。

     kCGImagePropertyGIFUnclampedDelayTime没有这个限制，可以从0ms开始起。
     */
    float totalDuration = 0.1f;

    CFDictionaryRef dictionaryRef = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, index, NULL);
    
    NSDictionary *frameProrerties = (__bridge NSDictionary *)dictionaryRef;
    //取得GIF字典
    NSDictionary *gifProperties = frameProrerties[(__bridge NSString *)kCGImagePropertyGIFDictionary];
    
    //kCGImagePropertyGIFUnclampedDelayTime没有这个限制，可以从0ms开始起
    NSNumber *delayTimeUnclampedProp = gifProperties[(__bridge NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    
    if (delayTimeUnclampedProp) {
        totalDuration = [delayTimeUnclampedProp floatValue];
    } else {
        //kCGImagePropertyGIFDelayTime限定了最小的事件间隔范围，如果小于50ms，则是100ms。
        NSNumber *delayTimePro = gifProperties[(__bridge NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimePro) {
            totalDuration = [delayTimePro floatValue];
        }
    }
    
    if (totalDuration < 0.011f) {
        totalDuration = 0.100f;
    }
    
    CFRelease(dictionaryRef);
    
    return totalDuration;
    
}

/// 根据文件名称来获取Data文件
/// @param name <#name description#>
+ (NSData *)getDataWith:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSData *data;
    if (scale > 1.0f) {
        //判断如果屏幕当前的缩放率大于1.0 我们需要寻找2备图，如果没有则在加载1倍图
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return data;
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return data;
        }
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return data;
        }
    }
    
    return data;
}
@end
