//
//  UIView+GYTools.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/27.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "UIView+GYTools.h"

@implementation UIView (GYTools)

- (void)clipRoundWithRectCorner:(UIRectCorner)rectCorner withSize:(CGSize)radiusSize {
    //创建一页遮罩CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:radiusSize].CGPath;
    
    self.layer.mask = shapeLayer;
}

- (void)addHollowingEffectWith:(NSArray *)pathArray {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //设置layer的显示方式 奇偶显示规则--> 从路径覆盖范围内的任意一点做一条射线(确保这条射线的长度要比路径覆盖范围要大) , 如果与该射线相交的边的数量为奇数, 则该点是路径的内部点（填充）, 反之该点则是路径的外部点(不填充)
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:self.frame];
    //bezierPath.usesEvenOddFillRule = YES;
    if (pathArray.count == 0) {
        return;
    }
    
    for (UIBezierPath *path in pathArray) {
        [bezierPath appendPath:path];
    }
    
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
}
@end
