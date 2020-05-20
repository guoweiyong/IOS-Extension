//
//  GYUIImageController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/19.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYUIImageController.h"
#import "UIImage+GYImageExtension.h"

@interface GYUIImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *markLable;

@end

@implementation GYUIImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            //生成村色图片
            self.imageView.image = [UIImage creatImageForColor:self.imageView.frame.size bgColor:UIColor.orangeColor];
        }
            break;
            
        case 2:
        {
            //截图
            self.imageView.image = [UIImage captureImageForView:self.bgView];
            /**
             afterUpdates参数表示是否在所有效果应用在视图上了以后再获取快照。例如，如果该参数为NO，则立马获取该视图现在状态的快照，反之，以下代码只能得到一个空白快照： 由于我们设置afterUpdates参数为YES 则表示x该view上所有的效果都会显示在快照上
             
             该方法返回的是一个view
             */
            //UIView *tempView = [self.bgView snapshotViewAfterScreenUpdates:NO];
            
        }
            
        default:
            break;
    }
}

@end
