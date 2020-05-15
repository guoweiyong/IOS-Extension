//
//  GYTextViewViewController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/15.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYTextViewViewController.h"

@interface GYTextViewViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
// 最大输入字数限制
static const int MAX_NUM_TEXT = 40;

@implementation GYTextViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange:) name:UITextViewTextDidChangeNotification object:nil];
}
#pragma mark -- 如何限制TextView设置字数
//1.第一种是通过监听textView文字改变的通知来做出修改
- (void)textViewTextChange:(UITextView *)tv {
    if (tv.text.length > MAX_NUM_TEXT) {
        //如果输入字数 超过值需要最大字数
        NSString *tempStr = [tv.text substringToIndex:MAX_NUM_TEXT];
        
        //赋值
        tv.text = tempStr;
    }
}


@end
