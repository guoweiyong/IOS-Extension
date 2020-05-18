//
//  ViewController.m
//  IOS-Extension
//
//  Created by yunyi on 2020/5/15.
//  Copyright © 2020 yunyi. All rights reserved.
//

#import "ViewController.h"
#import "GYTextViewViewController.h"
#import <IOS_Extension-Swift.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 数据源
@property (nonatomic, strong) NSArray *listArray;
@end

static NSString *cellIdentifier = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}




#pragma mark -- 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = self.listArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //如果要创建对象。必须加上{} 不然报错
            GYTextViewViewController *textViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GYTextView"];
            [self.navigationController pushViewController:textViewVC animated:YES];
//            GYTextViewVC *vc = [[GYTextViewVC alloc]initWithNibName:@"GYTextViewVC" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark --  懒加载

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"UITextView"];
    }
    
    return _listArray;
}
@end
