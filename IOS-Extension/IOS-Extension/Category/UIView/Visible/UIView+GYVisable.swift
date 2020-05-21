//
//  UIView+GYVisable.swift
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//

import UIKit
/**
 使用swift中设置可视化属性
 
 如果想添加其他属性，可以使用Runtime来动态添加属性，使用runtime来实现set()和get（）方法
 */
@IBDesignable
extension UIView {
    // 不能够有初始化值
    @IBInspectable var vsiable_Radius: CGFloat {
        get {
            return self.layer.cornerRadius;
        }
        set (newValue) {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true;
        }
    }
}
