//
//  GYUIImageController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/19.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYUIImageController.h"
#import "UIImage+GYClipImage.h"
#import "UIImage+GYGIF.h"

@interface GYUIImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *markLable;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

/// GIF图
@property (nonatomic, strong) UIImageView *gifImageView;

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
            //self.imageView.image = [UIImage captureImageForView:self.bgView];
            /**
             afterUpdates参数表示是否在所有效果应用在视图上了以后再获取快照。例如，如果该参数为NO，则立马获取该视图现在状态的快照，反之，以下代码只能得到一个空白快照： 由于我们设置afterUpdates参数为YES 则表示x该view上所有的效果都会显示在快照上
             
             该方法返回的是一个view
             //UIView *tempView = [self.bgView snapshotViewAfterScreenUpdates:NO];
             */
            
            //裁剪图片圆角
            UIImage *image = [UIImage imageNamed:@"sishen"];
            //self.imageView.image = [UIImage clipImageToRound:image];
            
            //给图片添加文字水印
            //self.imageView.image = [UIImage waterAtImage:image waterText:@"文字水印" startPoint:CGPointMake(10, 10) attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]}];
            
            //该图片添加水印图片
//            UIImage *waterImage = [UIImage creatImageForColor:self.imageView.frame.size bgColor:UIColor.orangeColor];
//            self.imageView.image = [UIImage waterAtImage:image waterImage:waterImage rect:CGRectMake(10, 10, 30, 30)];
            
            //裁剪任何角度方法
            self.imageView.image = [UIImage clipRoundedCornerImageWithRadius:20 rectSize:CGSizeMake(100, 100) originalImage:image];
        }
            
        case 3:
        {
            //加载GIF图
            [self.view addSubview:self.gifImageView];
//            NSString *retinaPath = [[NSBundle mainBundle] pathForResource:@"wishPool" ofType:@"gif"];
//
//            NSData *data = [NSData dataWithContentsOfFile:retinaPath];
            //self.gifImageView.image = [UIImage animationGIFImageWithName:@"wishPool"];
            __weak typeof(self) weakSelf = self;
            [UIImage loadGIFImageWithName:@"wishPool" complete:^(UIImage * _Nullable image, NSArray * _Nullable gifImages, float totalDuration) {
                //weakSelf.gifImageView.image = image;
                weakSelf.gifImageView.animationImages = gifImages;
                weakSelf.gifImageView.animationDuration = totalDuration;
                [weakSelf.gifImageView startAnimating];
                NSLog(@"gifImage.count==========%ld",gifImages.count);
                NSLog(@"totalDuration=======%f",totalDuration);
            }];
        }
            break;
            
        default:
            break;
    }
}


- (UIImageView *)gifImageView {
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 180, [UIScreen mainScreen].bounds.size.height/2 - 360, 360, 720)];
    }
    
    return _gifImageView;
}
@end
