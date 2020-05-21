//
//  GYVisableViewController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/21.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYVisableViewController.h"
#import "UIView+GYVisible.h"

@interface GYVisableViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation GYVisableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"cornerRadio======%f",self.testView.cornerRadio);
}


@end
