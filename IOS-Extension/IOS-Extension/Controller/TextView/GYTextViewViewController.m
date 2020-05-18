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
static const int MAX_NUM_TEXT = 5;

@implementation GYTextViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第二种方法，使用通知来监听textView的文本改变，但是修改一次textView，监听方法会执行两次
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark -- UITextViewDelgate
/**
 第一种方法：使用UITextViewDelgate 来实现对UITextView的字数限制功能，直接在代理方法中 截取 赋值就可以了
 */
- (void)textViewDidChange:(UITextView *)textView {
//    if (textView.text.length > MAX_NUM_TEXT) {
//        textView.text = [textView.text substringWithRange:NSMakeRange(0, MAX_NUM_TEXT)];
//    }
    
}

//第三种方使用delegate中的另一个方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    /**
     @param textView  textView的值储存的是当前textView的值
     @param rang  当前修改的值的范围（location: 当前修textView的值的长度， length: replacementText的值的长度）
     @param text 当前用户输入的值

     textView当前显示的text == textView.text(当前缓存的值 + text（新增加替换的值）)
     */
    NSLog(@"textView.text===========%@  range=====%@   tex==========%@",textView.text,NSStringFromRange(range),text);

    //监听用户点击键盘的删除按键
    if ([text isEqualToString:@""]) {
        return true;
    }

    //监听用户点击键盘右下角的 完成，转行-- 按钮
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//    }

    //使用这个方法也可以实现，UITextView的字数限制功能 ，如果这样判断，如果达到字数限制之后，便不可以删除了  解决办法如上 可以监听用户点击删除按键的时候，开始输入的限制即可
//    if (textView.text.length >= MAX_NUM_TEXT) {
//        textView.text = [textView.text substringToIndex:MAX_NUM_TEXT];
//
//        return  false;
//    }

    //但是上次实现限制字数功能之后，可以正常的打字输入，但是如果是用户 复制 文字到输入框，可能会超出限制字数很长的字数，导致用户体验不是很好，改进方法：
    //1.首先我们可以判断，首先我们可以计算当前字符串的 总长度，然后在截取范围内的字符
    NSString *tempStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
    NSLog(@"tempStr===========%@",tempStr);
    if (tempStr.length >= MAX_NUM_TEXT) {

        textView.text = [tempStr substringToIndex:MAX_NUM_TEXT];
        
        //就是赋值之后，光标的位置没有在最后

        return false;
    }


    return  YES;
}

#pragma mark -- 如何限制TextView设置字数
//1.第二种是通过监听textView文字改变的通知来做出修改
/**
 UndoManager 是一个通用的 undo 栈，用于简化 app 的状态管理。它可以保存你想保存的任何对象或 UI 状态，通过一个闭包、方法或 invocation ，你可以跟踪和回溯这些状态。

 直接截取，然后修改UITextView的文本，如果产生崩溃。
 出现crash是因为，为了实现输入的字数限制效果，会通过delegate监听输入框的UIControlEventEditingChanged事件，截取字符串，手动给输入框的text属性赋值。正常情况下输入框自己默认执行setText：，默认不会注册到自己的undoManager上，并且会清空undoManager的undo、redo栈，这样并没有问题。问题是在于监听UIControlEventEditingChanged事件所执行的方法里是先程序代码对输入框的text做截取然后执行setText：，并没有清空undoManager的undo、redo栈。
 
 //需要加上这句代码
 [tv.undoManager removeAllActions];
 [tv becomeFirstResponder];
 
 如果没有崩溃 则直接正常使用
         
 */
//使用带通知监听的方法  ，点击一次TextView监听方法会执行两次
- (void)textViewTextChange:(NSNotification *)noti {
   
    /**
     使用通知监听UITextView值改变时候， 不可以给TextView赋值，否则发生崩溃
     reason: '-[NSConcreteNotification text]: unrecognized selector sent to instance 0x2825f1f20'
     */
    
    if (self.textView.text.length > MAX_NUM_TEXT) {
        //赋值
        self.textView.text = [self.textView.text substringToIndex:MAX_NUM_TEXT];
    }
}


#pragma mark -- 使用KVC来实现UITextView的placeholder属性
//- (void)setPlaceholder:(NSString *)placeholder forTextView:(UITextView *)textView {
//    //placeholderLable
//    UILabel *placeholderLable = [[UILabel alloc] init];
//    placeholderLable.text = placeholder;
//    placeholderLable.numberOfLines = 0;
//    placeholderLable.textColor = UIColor.orangeColor;
//    [textView addSubview:placeholder];
//}

@end
