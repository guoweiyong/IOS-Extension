//
//  GYVisableViewController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYVisableViewController.h"
#import "UIView+GYVisible.h"
#import "UIView+GYTools.h"
#import "UIView+GYFrame.h"
#import "UIColor+GYExtension.h"

@interface GYVisableViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

/// 测试末班view
@property (nonatomic, strong) UIView *bgView;
@end

@implementation GYVisableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"cornerRadio======%f",self.testView.cornerRadio);
    //例子: 裁剪view的左上角 圆角为30
    [self.testView clipRoundWithRectCorner:UIRectCornerTopLeft withSize:CGSizeMake(30, 30)];
    
    //例子，我们需要增加一个镂空效果
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(self.testView.width/2-15, self.testView.height/2-15, 30, 30)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [self.bgView addHollowingEffectWith:@[path]];
    
    //1.改变testView的颜色
    self.testView.backgroundColor = [UIColor colorWithHexString:@"#FF7C7C"];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    }
    
    return _bgView;
}
@end
