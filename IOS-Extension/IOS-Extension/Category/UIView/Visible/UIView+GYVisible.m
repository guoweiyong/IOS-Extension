//
//  UIView+GYVisible.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "UIView+GYVisible.h"

IB_DESIGNABLE
@implementation UIView (GYVisible)

- (void)setCornerRadio:(CGFloat)cornerRadio {
    self.layer.cornerRadius = cornerRadio;
    self.layer.masksToBounds = true;
}

- (CGFloat)cornerRadio {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

@end
