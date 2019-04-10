//
//  ViewController.m
//  CMPageTitleView
//
//  Created by 智借iOS on 2018/8/13.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "CMPageTitleView.h"
@interface ViewController () <CMPageTitleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    
}


- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat {
    
    NSLog(@"第%ld个标题被点击；且%@重复点击",index,repeat?@"是":@"没有被");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
