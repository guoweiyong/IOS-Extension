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
/// @param captureView 需要截取的view
+ (UIImage *)captureImageForView:(UIView *)captureView;

/// 裁剪一张圆形图片出来
/// @param originalImage 需要裁剪的图片
+ (UIImage *)clipImageToRound:(UIImage *)originalImage;

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

/// 根据宽度来等比例缩放一张图片
/// @param width 宽度
- (UIImage *)imageWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
