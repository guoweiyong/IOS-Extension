//
//  UIImage+GYImageExtension.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/19.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//使用layer的Mask属性进行遮罩  也可以达到设置圆角图片的效果

/**
 1.开启图形上下文
 2.绘制图片
 - 使用drowInRect或者drawAtPoint绘制图片(区别在哪儿？你可以先想一想)
  drawInRect是以rect作为图片绘制的区域，图片是以填充的方式被绘制在当前区域图片的大小，rect的宽高比和原图片的宽高比不同时会造成图片的变形
  drowAtPoint是以point作为图片绘制的起点，绘制的图片的大小依然是原图片的大小，不会使图片变形
 - 将layer渲染在当前上下文
 3.从当前上下文获取新的图片
 4.关闭上下文
 */

@interface UIImage (GYClipImage)
//根据 尺寸生成一张规定尺寸的纯色图片
+ (UIImage *)creatImageForColor:(CGSize)size bgColor:(UIColor *)color;

/// 根据View来截取一张图片
/// @param captureView 需要截取的view
+ (UIImage *)captureImageForView:(UIView *)captureView;

/// 裁剪一张圆形图片出来
/// @param originalImage 需要裁剪的图片
+ (UIImage *)clipImageToRound:(UIImage *)originalImage;

/// 裁剪任意角度的图片
/// @param radius <#radius description#>
/// @param size <#size description#>
+ (UIImage *)clipRoundedCornerImageWithRadius:(float)radius rectSize:(CGSize)size originalImage:(UIImage *)originalImage;

/// 绘制文字水印在图片上
/// @param originalImage 需要添加水印的图片
/// @param text 文字
/// @param point 开始绘制
/// @param attrs 属性
+ (UIImage *)waterAtImage:(UIImage *)originalImage waterText:(NSString *)text startPoint:(CGPoint)point attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs;

/// 绘制图片水印在图片上
/// @param originalImage <#originalImage description#>
/// @param waterimage <#waterimage description#>
/// @param rect <#rect description#>
+ (UIImage *)waterAtImage:(UIImage *)originalImage waterImage:(UIImage *)waterimage rect:(CGRect)rect;

/// 擦除图片 1.设置两张图片，上方为我们要擦除的图片，后方为需要展示的图片 2.设置擦除的区域的大小和位置
/// @param view <#view description#>
/// @param point <#point description#>
/// @param size <#size description#>
+ (UIImage *)wipeView:(UIView *)view point:(CGPoint)point size:(CGSize)size;


/// 根据宽度来等比例缩放一张图片
/// @param width 宽度
- (UIImage *)imageWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
