//
//  UIView+GYVisible.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 为view拓展一下可视化的属性
 IBInspectable 修饰属性
 然后再.m文件里面，@implementation前面用IB_DESIGNABLE修饰
 
 在分类里使用@property声明属性，只是将该属性添加到该类的属性列表，并声明了setter和getter方法，但是没有生成相应的成员变量，也没有实现setter和getter方法。需要实现它的get和set方法,这样在类的外部就能用点语法获取并设置属性,这样可以认为给类添加了属性.

 */

@interface UIView (GYVisible)
/// view的圆角属性
@property (nonatomic, assign) IBInspectable CGFloat cornerRadio;
/// view的边框宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/// view的边框颜色
@property (nonatomic, assign) IBInspectable UIColor *borderColor;


@end

NS_ASSUME_NONNULL_END
