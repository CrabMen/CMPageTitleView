//
//  CMViewController.m
//  CMPageTitleView
//
//  Created by CrabMan on 2019/4/10.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMViewController.h"
#import "CMPageTitleView.h"
#import "CMChildController.h"
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

/**default note*/
@property (nonatomic,strong) UIImageView *rightView;


@end

@implementation CMViewController

- (UIImageView *)rightView {
    
    if (!_rightView) {
        _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 66)];
        //        _rightView.alpha = 0.75;
        _rightView.backgroundColor = UIColor.lightGrayColor;
        _rightView.image = [UIImage imageNamed:@"add"];
        _rightView.contentMode = UIViewContentModeScaleAspectFit;
        _rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_rightView addGestureRecognizer:tap];
    }
    return _rightView;
}

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
        CMChildController *vc0 = [CMChildController new];
        CMChildController *vc1 = [CMChildController new];
        CMChildController *vc2 = [CMChildController new];
        CMChildController *vc3 = [CMChildController new];
        CMChildController *vc4 = [CMChildController new];
        CMChildController *vc5 = [CMChildController new];
        CMChildController *vc6 = [CMChildController new];
        CMChildController *vc7 = [CMChildController new];
        CMChildController *vc8 = [CMChildController new];
        CMChildController *vc9 = [CMChildController new];
        CMChildController *vc10 = [CMChildController new];
        
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
    
    [self setReloadBarButtonItem];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setReloadBarButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新数据" style:UIBarButtonItemStyleDone target:self action:@selector(reloadConfig:)];
    
    
    
}

- (void)reloadConfig:(UIBarButtonItem *)sender {
    
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_contentMode = CMPageTitleContentMode_Left;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    config.cm_scale = 1.3;
    config.cm_defaultIndex = 1;
    config.cm_selectedColor = UIColor.blueColor;
    config.cm_underlineColor = UIColor.blueColor;
    self.pageTitleView.cm_config = config;
    
    [self.pageTitleView cm_reloadConfig];
    
    
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    
    //do something ...
    NSLog(@"****右侧视图被点击****");
    
}


- (void)style00_00 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_01 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_02 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_03 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    //默认放大倍数是1.2
    // 可以通过下方代码自定义
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    //或者
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_scale = 1.3;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_04 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_05 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_06 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay ;
    //默认放大倍数是1.2
    // 可以通过下方代码自定义
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    //或者
    //    config.cm_font = [UIFont systemFontOfSize:16]
    //    config.cm_scale = 1.3;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_07 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_08 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_09 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_additionalMode = CMPageTitleAdditionalMode_Seperateline;
    config.cm_seperateLineHeight = 2;
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_10 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_additionalMode = CMPageTitleAdditionalMode_Splitter;
    config.cm_splitterSize = CGSizeMake(1/[UIScreen mainScreen].scale, config.cm_titleHeight * 0.5);
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_11 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_contentMode = CMPageTitleContentMode_Left;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_12 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_contentMode = CMPageTitleContentMode_Right;
    
    self.pageTitleView.cm_config = config;
}

- (void)style00_13 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    
    self.pageTitleView.cm_config = config;
}

- (void)style00_14 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_contentMode = CMPageTitleContentMode_SpaceAround;
    
    self.pageTitleView.cm_config = config;
}

- (void)style00_15 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    //    默认
    //    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Center;
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_16 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Top;
    self.pageTitleView.cm_config = config;
    
}

- (void)style00_17 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    
    self.pageTitleView.cm_config = config;
    
}


- (void)style01_00 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_01 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_02 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_03 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
    
}

- (void)style01_04 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
    
    
}

- (void)style01_05 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_06 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
    
    
}

- (void)style01_07 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_08 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
}

- (void)style01_09 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_10 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_11 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
    
}

- (void)style01_12 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_13 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_14 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
}

- (void)style01_15 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_16 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_17 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_18 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 0.6;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_19 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_20 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_21 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_22 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_23 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_24 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_25 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_26 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_27 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_28 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_29 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidth = 10;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_30 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 1.3;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_31 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 1.3;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_32 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_underlineWidthScale = 1.3;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_33 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_34 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_35 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_36 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
    
}

- (void)style01_37 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
    
    
}

- (void)style01_38 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}


- (void)style01_39 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_40 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_41 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_42 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    
    self.pageTitleView.cm_config = config;
    
    
}

- (void)style01_43 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
    
    
}

- (void)style01_44 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Cover | CMPageTitleSwitchMode_Delay;
    config.cm_coverWidth = 56;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}


- (void)style01_45 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_46 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline | CMPageTitleSwitchMode_Delay;
    config.cm_gradientStyle = CMTitleColorGradientStyle_None;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_47 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_48 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_49 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidthScale = 0.6;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    
    self.pageTitleView.cm_config = config;
    
    
}

- (void)style01_50 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    config.cm_scale = 1.3;
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style01_51 {
    

    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;

    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.lessChildControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale | CMPageTitleSwitchMode_Underline;
    config.cm_underlineStretch = YES;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_contentMode = CMPageTitleContentMode_Left;
    config.cm_scaleGradientContentMode = CMPageTitleScaleGradientContentMode_Bottom;
    config.cm_scale = 1.3;
    
    
    self.pageTitleView.cm_config = config;
    
}

- (void)style02_00 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.pageTitleView.cm_config = config;
}

- (void)style02_01 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image"]];
    
    self.pageTitleView.cm_config = config;
}

- (void)style02_02 {
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    self.pageTitleView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_childControllers = self.childControllers;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_rightView = self.rightView;
    self.pageTitleView.cm_config = config;
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
