//
//  GYTextViewViewController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/15.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "GYTextViewViewController.h"

@interface GYTextViewViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
// 最大输入字数限制
static const int MAX_NUM_TEXT = 40;

@implementation GYTextViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark -- UITextViewDelgate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > MAX_NUM_TEXT) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, MAX_NUM_TEXT)];
        //[textView.undoManager removeAllActions];
        //[textView becomeFirstResponder];
    }
}
#pragma mark -- 如何限制TextView设置字数
//1.第一种是通过监听textView文字改变的通知来做出修改
/**
 UndoManager 是一个通用的 undo 栈，用于简化 app 的状态管理。它可以保存你想保存的任何对象或 UI 状态，通过一个闭包、方法或 invocation ，你可以跟踪和回溯这些状态。
 */
//- (void)textViewTextChange:(UITextView *)tv {
//
//    if (tv.text.length > MAX_NUM_TEXT) {
//        //如果输入字数 超过值需要最大字数
//        NSString *tempStr = [tv.text substringToIndex:MAX_NUM_TEXT];
//        /**
//         这样直接截取，然后修改UITextView的文本，会产生崩溃。
//         出现crash是因为，为了实现输入的字数限制效果，会通过delegate监听输入框的UIControlEventEditingChanged事件，截取字符串，手动给输入框的text属性赋值。正常情况下输入框自己默认执行setText：，默认不会注册到自己的undoManager上，并且会清空undoManager的undo、redo栈，这样并没有问题。问题是在于监听UIControlEventEditingChanged事件所执行的方法里是先程序代码对输入框的text做截取然后执行setText：，并没有清空undoManager的undo、redo栈。
//         */
//        //赋值
//        tv.text = tempStr;
//
//        //需要加上这句代码
//        [tv.undoManager removeAllActions];
//        [tv becomeFirstResponder];
//    }
//}


@end
