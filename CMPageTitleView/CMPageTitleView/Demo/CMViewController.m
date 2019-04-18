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
        
        vc0.title = @"推荐";
        vc1.title = @"小视频";
        vc2.title = @"视频";
        vc3.title = @"热点";
        vc4.title = @"北京";
        vc5.title = @"娱乐";
        vc6.title = @"图片";
        vc7.title = @"懂车帝";
        
        
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_normalColor = CM_HEXCOLOR(@"222222");
   
    pageView.cm_config = config;
    [self.view addSubview:pageView];
    
}

- (void)style1 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, CM_NAVI_BAR_H, CMSCREEN_W, CMSCREEN_H - CM_NAVI_BAR_H)];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
    [self.view addSubview:pageView];
    
}

- (void)style2 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, CM_NAVI_BAR_H, CMSCREEN_W, CMSCREEN_H - CM_NAVI_BAR_H)];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_underLineW = 6;
    pageView.cm_config = config;
    
    [self.view addSubview:pageView];
    
}


- (void)style3 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, CM_NAVI_BAR_H, CMSCREEN_W, CMSCREEN_H - CM_NAVI_BAR_H)];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
    [self.view addSubview:pageView];
    
}



- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat {
    
NSLog(@"第%ld个标题被点击；且%@是重复点击",index,repeat?@"":@"不");
    
}

@end
