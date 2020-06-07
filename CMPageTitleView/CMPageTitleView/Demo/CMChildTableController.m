//
//  CMChildController.m
//  CMPageTitleView
//
//  Created by 郭强 on 2019/12/14.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMChildTableController.h"
#import <Masonry.h>
@interface CMChildTableController ()

@property(nonatomic,weak) UIButton *button;


@end

@implementation CMChildTableController

- (void)setTopInset:(CGFloat)topInset {
    
    _topInset = topInset;
    
    if (topInset) {
        self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    } else {
        self.tableView.contentInset = UIEdgeInsetsZero;
    }
}


- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton new];
        [button setTitle:@"跳转到详情" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(buttonnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
        [self.view addSubview:_button];
    }
    return _button;
    
}

- (void)buttonnClickAction:(UIButton *)sender {
    
    UIViewController *detailVC = [UIViewController new];
    detailVC.title = @"详情页";
    detailVC.view.backgroundColor = UIColor.redColor;
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad --- %@",self.title);
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear --- %@",self.title);
  
    
      if (self.topInset) {
             self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
             if (@available(iOS 11.0, *)) {
                 self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
             } else {
                 self.automaticallyAdjustsScrollViewInsets = NO;
             }
         } else {
             self.tableView.contentInset = UIEdgeInsetsZero;
         }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear --- %@",self.title);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewDidAppear --- %@",self.title);
  
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewDidDisappear --- %@",self.title);
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    cell.textLabel.text = [NSString stringWithFormat:@"-------> %@ -- 第%ld行 <------- ",self.title,indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = UIColor.blackColor;
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *detailVC = [UIViewController new];
    detailVC.title = @"详情页";
    detailVC.view.backgroundColor = UIColor.redColor;
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
