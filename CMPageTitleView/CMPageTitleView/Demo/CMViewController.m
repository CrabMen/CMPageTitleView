//
//  CMViewController.m
//  CMPageTitleView
//
//  Created by CrabMan on 2019/4/10.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMViewController.h"
#import "CMPageTitleView.h"
#import "Masonry.h"
//屏幕尺寸
#define CM_SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define CM_SCREEN_H  [UIScreen mainScreen].bounds.size.height


//是否是刘海屏
#define CM_NOTCH_SCREEN \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//导航栏高度
#define CM_NAVI_BAR_H (CM_NOTCH_SCREEN ? 88 : 64)

//电池条高度
#define CM_STATUE_BAR_H (CM_NOTCH_SCREEN ? 44 : 20)

//tabbar高度
#define CM_TAB_BAR_H (CM_NOTCH_SCREEN ? 83.0f: 49.0)


//随机色
#define CM_RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]



@interface CMViewController ()<CMPageTitleViewDelegate>

/**视图控制器数组*/
@property (nonatomic,copy) NSArray *childControllers;

/**个数较少的视图控制器数组*/
@property (nonatomic,strong) NSArray *lessChildControllers;


@end

@implementation CMViewController

- (NSArray *)lessChildControllers {
    
    return [self.childControllers subarrayWithRange:NSMakeRange(0, 3)];
    
    
}

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
        UIViewController *vc8 = [UIViewController new];
        UIViewController *vc9 = [UIViewController new];
        UIViewController *vc10 = [UIViewController new];
        
        vc0.title = @"推荐";
        vc1.title = @"小视频";
        vc2.title = @"视频";
        vc3.title = @"懂车帝";
        vc4.title = @"北京";
        vc5.title = @"娱乐";
        vc6.title = @"图片";
        vc7.title = @"热点";
        vc8.title = @"体育";
        vc9.title = @"财经";
        vc10.title = @"国际";

        
        vc0.view.backgroundColor = CM_RANDOM_COLOR;
        vc1.view.backgroundColor = CM_RANDOM_COLOR;
        vc2.view.backgroundColor = CM_RANDOM_COLOR;
        vc3.view.backgroundColor = CM_RANDOM_COLOR;
        vc4.view.backgroundColor = CM_RANDOM_COLOR;
        vc5.view.backgroundColor = CM_RANDOM_COLOR;
        vc6.view.backgroundColor = CM_RANDOM_COLOR;
        vc7.view.backgroundColor = CM_RANDOM_COLOR;
        vc8.view.backgroundColor = CM_RANDOM_COLOR;
        vc9.view.backgroundColor = CM_RANDOM_COLOR;
        vc10.view.backgroundColor = CM_RANDOM_COLOR;
        

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
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];

    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    config.cm_contentMode = CMPageTitleContentMode_Center;
    config.cm_splitterColor = [UIColor blackColor];
    config.cm_splitterSize =CGSizeMake(2, config.cm_titleHeight);
    pageView.cm_config = config;
    
}

- (void)style1 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_scale = 1.2;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style2 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
    
}


- (void)style3 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
    
}


- (void)style4 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_underlineWidth = 10;
    pageView.cm_config = config;
    
    
}


- (void)style5 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineWidth = 10;

    pageView.cm_config = config;
    
    
}







- (void)style6 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_underlineStretch = YES;
    pageView.cm_config = config;
    
}


- (void)style7 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    pageView.cm_config = config;
    
}




- (void)style8 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    pageView.cm_config = config;
    
    
}


- (void)style9 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    pageView.cm_config = config;
    
}


- (void)style10 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    pageView.cm_config = config;
    
    
}


- (void)style11 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    pageView.cm_config = config;
    
    
}

- (void)style12 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_coverWidth = 56;
    pageView.cm_config = config;
    
}


- (void)style13 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_coverWidth = 56;
    pageView.cm_config = config;
    
}


- (void)style14 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    pageView.cm_config = config;
 
}


- (void)style15 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;

    pageView.cm_config = config;
 
}

- (void)style16 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 0.8;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
//    config.cm_underlineStretch = YES;
    pageView.cm_config = config;
 
}


- (void)style17 {
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 1.2;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    pageView.cm_config = config;
 
}

- (void)style18 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_SeperateLine;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    
    pageView.cm_config = config;
    
}

- (void)style19 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];

    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_SeperateLine;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    config.cm_contentMode = CMPageTitleContentMode_Left;
    
    pageView.cm_config = config;
    
}

- (void)style20 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_SeperateLine;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    config.cm_contentMode = CMPageTitleContentMode_Right;

    pageView.cm_config = config;
    
}

- (void)style21 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_contentMode = CMPageTitleContentMode_Center;
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_SeperateLine;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];

    pageView.cm_config = config;
    
}

- (void)style22 {
    
    
    
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_contentMode = CMPageTitleContentMode_SpaceAround;
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_SeperateLine;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    config.cm_slideGestureEnable = NO;
    pageView.cm_config = config;
    
}





- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat {
    
NSLog(@"第%ld个标题被点击；且%@是重复点击",index,repeat?@"":@"不");
    
}

@end
