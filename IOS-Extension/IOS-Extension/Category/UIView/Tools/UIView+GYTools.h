//
//  UIView+GYTools.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/27.
//  Copyright © 2020 yunyi. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GYTools)

/// 设置view的任一一个或多个脚是圆角
/// @param rectCorner 那个脚
/// @param radiusSize 圆角角度
- (void)clipRoundWithRectCorner:(UIRectCorner)rectCorner withSize:(CGSize)radiusSize;

/// 当前view增加一个镂空效果
/// @param pathArray 路径数组  
- (void)addHollowingEffectWith:(NSArray *)pathArray;

@end

NS_ASSUME_NONNULL_END
