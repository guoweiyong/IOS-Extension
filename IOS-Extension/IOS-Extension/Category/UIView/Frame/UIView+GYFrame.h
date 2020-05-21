//
//  UIView+GYFrame.h
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GYFrame)
//x位置
@property (nonatomic, assign) CGFloat x;
/// y位置
@property (nonatomic, assign) CGFloat y;
/// width
@property (nonatomic, assign) CGFloat width;
/// height
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
/// <#descrption#>
@property (nonatomic, assign) CGFloat centerX;
/// <#descrption#>
@property (nonatomic, assign) CGFloat centerY;
/// <#descrption#>
@property (nonatomic, assign) CGPoint origin;
///
@property (nonatomic, assign) CGSize size;
@end

NS_ASSUME_NONNULL_END
