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
            
        default:
            break;
    }
}

@end
