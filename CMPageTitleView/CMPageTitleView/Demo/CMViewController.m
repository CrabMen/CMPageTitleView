//
//  CMViewController.m
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/4/10.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMViewController.h"
#import "CMPageTitleView.h"
@interface CMViewController ()<CMPageTitleViewDelegate>

/**视图控制器数组*/
@property (nonatomic,copy) NSArray *childControllers;


@end

@implementation CMViewController

- (NSArray *)childControllers {
    
    if (!_childControllers) {
        UIViewController *vc0 = [UIViewController new];
        UIViewController *vc1 = [UIViewController new];
        UIViewController *vc2 = [UIViewController new];
        UIViewController *vc3 = [UIViewController new];
        UIViewController *vc4 = [UIViewController new];
        UIViewController *vc5 = [UIViewController new];
        UIViewController *vc6 = [UIViewController new];
        UIViewController *vc7 = [UIViewController new];
        
        vc0.title = @"0000";
        vc1.title = @"测标题01";
        vc2.title = @"测试标题02";
        vc3.title = @"测试03";
        vc4.title = @"标题04";
        vc5.title = @"05";
        vc6.title = @"标题06";
        vc7.title = @"测试标题07";
        
        
        vc0.view.backgroundColor = [UIColor purpleColor];
        vc1.view.backgroundColor = [UIColor cyanColor];
        vc2.view.backgroundColor = [UIColor purpleColor];
        vc3.view.backgroundColor = [UIColor cyanColor];
        vc4.view.backgroundColor = [UIColor purpleColor];
        vc5.view.backgroundColor = [UIColor cyanColor];
        vc6.view.backgroundColor = [UIColor purpleColor];
        vc7.view.backgroundColor = [UIColor cyanColor];
        

        _childControllers =@[vc0,vc1,vc2,vc3,vc4,vc5,vc6,vc7];
        
    }
    
    return _childControllers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)style0 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, CM_NAVI_BAR_H, CMSCREEN_W, CMSCREEN_H - CM_NAVI_BAR_H)];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_showScale = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    pageView.cm_config = config;
    
    [self.view addSubview:pageView];
    
    
}



- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat {
    
NSLog(@"第%ld个标题被点击；且%@是重复点击",index,repeat?@"":@"不");
    
}

@end
