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


@property (nonatomic,weak) UIImageView *imageView;

/**default notes*/
@property (nonatomic,weak) CMPageTitleView *pageTitleView;



@end

@implementation CMViewController

- (CMPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        CMPageTitleView *pageTitleView = [[CMPageTitleView alloc] init];
        
        _pageTitleView = pageTitleView;
        [self.view addSubview:_pageTitleView];
        
    }
    
    return _pageTitleView;
    
    
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_image"]];
        
        _imageView = imageView;
        
        [self.view addSubview:_imageView];
    }
    
    return _imageView;
}

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

- (void)setReloadBarButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新数据" style:UIBarButtonItemStyleDone target:self action:@selector(reloadConfig:)];
    
    
    
}

- (void)reloadConfig:(UIBarButtonItem *)sender {
    
    
    
    
}


- (void)style00_00 {
    
//    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
//    [self.view addSubview:pageView];
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_01 {
    
    
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
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style00_02 {
    
    
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
    
    pageView.cm_config = config;
    
}

- (void)style00_03 {
    
    
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
    //默认放大倍数是1.2
    // 可以通过下方代码自定义
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    //或者
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_scale = 1.3;
    
    pageView.cm_config = config;
    
}

- (void)style00_04 {
    
    
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
    
    pageView.cm_config = config;
    
}

- (void)style00_05 {
    
    
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
    
    pageView.cm_config = config;
    
}

- (void)style00_06 {
    
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay ;
    //默认放大倍数是1.2
    // 可以通过下方代码自定义
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    //或者
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_scale = 1.3;
    
    pageView.cm_config = config;
    
}

- (void)style00_07 {
    
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    
    pageView.cm_config = config;
    
}

- (void)style00_08 {
    
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    
    pageView.cm_config = config;
    
}

- (void)style00_09 {
    
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
    config.cm_additionalMode = CMPageTitleAdditionalMode_Seperateline;
    config.cm_seperateLineHeight = 2;
    pageView.cm_config = config;
    
}

- (void)style00_10 {
    
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
    config.cm_additionalMode = CMPageTitleAdditionalMode_Splitter;
    config.cm_splitterSize = CGSizeMake(1/[UIScreen mainScreen].scale, config.cm_titleHeight * 0.5);
    
    pageView.cm_config = config;
    
}

- (void)style00_11 {
    
    
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
    config.cm_contentMode = CMPageTitleContentMode_Left;
    
    pageView.cm_config = config;
    
}

- (void)style00_12 {
    
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
    config.cm_contentMode = CMPageTitleContentMode_Right;
    
    pageView.cm_config = config;
}

- (void)style00_13 {
    
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
    
    pageView.cm_config = config;
}

- (void)style00_14 {
    
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
    config.cm_contentMode = CMPageTitleContentMode_SpaceAround;
    
    pageView.cm_config = config;
}

- (void)style00_15 {
    
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
    //    默认
    //    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Center;
    pageView.cm_config = config;
    
}

- (void)style00_16 {
    
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
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Top;
    pageView.cm_config = config;
    
}

- (void)style00_17 {
    
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
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    
    pageView.cm_config = config;
    
}


- (void)style01_00 {
    
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
    
    pageView.cm_config = config;
    
}

- (void)style01_01 {
    
    
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
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_02 {
    
    
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
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_03 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;

    
}

- (void)style01_04 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;

    
    
}

- (void)style01_05 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_06 {
    
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

- (void)style01_07 {
    
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

- (void)style01_08 {
    
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
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
}

- (void)style01_09 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_10 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_11 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
    
}

- (void)style01_12 {
    
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
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_13 {
    
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
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_14 {
    
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
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
}

- (void)style01_15 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_16 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_17 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_18 {
    
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
    config.cm_underlineWidthScale = 0.6;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_19 {
    
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
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_20 {
    
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
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_21 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_22 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_23 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_24 {
    
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
    config.cm_underlineStretch = YES;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_25 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_26 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_27 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_28 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_29 {
    
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
    config.cm_underlineWidth = 10;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_30 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 1.3;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
}

- (void)style01_31 {
    
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
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 1.3;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_32 {
    
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
    config.cm_underlineWidthScale = 1.3;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_33 {
    
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

- (void)style01_34 {
    
    
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

- (void)style01_35 {
    
    
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
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_36 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
    
}

- (void)style01_37 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
    
    
}

- (void)style01_38 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}


- (void)style01_39 {
    
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
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    pageView.cm_config = config;
    
}

- (void)style01_40 {
    
    
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
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_41 {
    
    
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
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_42 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    pageView.cm_config = config;
    
    
}

- (void)style01_43 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
    
    
}

- (void)style01_44 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}


- (void)style01_45 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
}

- (void)style01_46 {
    
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    pageView.cm_config = config;
    
}

- (void)style01_47 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    
    pageView.cm_config = config;
    
}

- (void)style01_48 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;

    pageView.cm_config = config;
    
}

- (void)style01_49 {
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    pageView.cm_config = config;
    
    
}

- (void)style01_50 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    config.cm_scale = 1.3;
    
    pageView.cm_config = config;
    
}

- (void)style01_51 {
    
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
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_contentMode = CMPageTitleContentMode_Left;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    config.cm_scale = 1.3;

    
    pageView.cm_config = config;

}


- (void)cm_pageTitleViewSelectedWithIndex:(NSInteger)index Repeat:(BOOL)repeat {

    NSLog(@"第%ld个标题被选中；且%@是重复选中",index,repeat?@"":@"不");

}

- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat {


    NSLog(@"第%ld个标题被点击；且%@是重复点击",index,repeat?@"":@"不");

}


- (void)cm_pageTitleViewScrollToIndex:(NSInteger)index {


    NSLog(@"当前滚动到第%ld个标题",index);

}


@end
