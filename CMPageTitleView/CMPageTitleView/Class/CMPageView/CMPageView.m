//
//  CMPageView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageView.h"
#import "CMPageTitleView.h"
#import "CMPageContentView.h"
#import "UIView+Frame.h"
@interface CMPageView() <CMPageTitleViewDelegate,CMPageContentViewDelegate>

/**标题视图*/
@property (nonatomic,strong) CMPageTitleView *titleView;

/**内容视图*/
@property (nonatomic,strong) CMPageContentView *contentView;


/**标题数组*/
@property (nonatomic,strong) NSArray *titles;
/**子视图控制器*/
@property (nonatomic,strong) NSArray *childControllers;
/**父视图控制器*/
@property (nonatomic,strong) UIViewController *parentController;


@end

@implementation CMPageView


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleView.pageTitleColor = self.pageTitleColor ? self.pageTitleColor : [UIColor whiteColor];
    self.titleView.normalColor = self.normalColor ? self.normalColor : [UIColor blackColor];
    self.titleView.selectedColor = self.selectedColor ? self.selectedColor : [UIColor redColor];
    self.titleView.underLineColor = self.underLineColor ? self.underLineColor : [UIColor redColor];
    self.titleView.titleHeight = self.titleHeight ? self.titleHeight : 44;
    self.titleView.titleFont = [UIFont systemFontOfSize:14];
    
   
}

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ChildControllers:(NSArray *)childControllers ParentController:(UIViewController *)parentController {
    if (self = [super initWithFrame:frame]) {
    
        self.titles = titles;
        self.childControllers = childControllers;
        self.parentController = parentController;
        
        [self initSubViews];
    }
    
    return self;
    
}

- (void)initSubViews {
    
    self.titleView = [[CMPageTitleView alloc]initWithSize:CGSizeMake(self.width, 44) Titles:self.titles];
    self.contentView = [[CMPageContentView alloc]initWithFrame:CGRectMake(0, 44, self.width, self.height) ChildViewControllers:self.childControllers ParentController:_parentController];
   
    self.titleView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.backgroundColor = [UIColor blueColor];
   // self.titleView.isShowTitleScale = YES;
    
   
    
    
    self.titleView.delegate = self;
    self.contentView.delegate = self;
    
    self.titleView.titleColorGradientStyle = CMTitleColorGradientStyleRGB;
   
    self.titleView.isShowUnderLine = YES;
   // titleView.isShowTitleCover = YES;
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    
    
}


#pragma mark --- CMPageTitleViewDelegate


- (void)titleDidClick:(NSUInteger)index {
    
    NSLog(@"当前点击的是第%ld个",index);
    
    [self.contentView setContentOffset:CGPointMake(index * CMSCREEN_W , 0)];
    
}

#pragma mark --- CMPageContentViewDelegate

- (void)contentViewDidEndDecelerating:(NSUInteger)index {
    
    
    [self.titleView selectLabelWithIndex:index];
    
}

-(void)contentViewDidScroll:(UIScrollView *)scrollView {

    //获取偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    
    //获取左边角标
    NSInteger leftIndex = offSetX / CMSCREEN_W;
    
    //左边按钮
    UILabel *leftLabel = self.titleView.titleLabels[leftIndex];
    
    //右边角标
    NSInteger rightIndex = leftIndex + 1;
    //右边角标
    UILabel *rightLabel = nil;
    
    if (rightIndex < self.titleView.titleLabels.count) {
        rightLabel = self.titleView.titleLabels[rightIndex];
    }
    
    
    //字体放大
    [self.titleView setUpTitleScaleWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //设置遮罩偏移
    [self.titleView setUpCoverOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //设置标题渐变
    [self.titleView setUpTitleColorGradientWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
//    if (_isDelayScroll == NO) { // 延迟滚动，不需要移动下标
    
        [self.titleView setUpUnderLineOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
//    }
    //记录上一次的偏移量
//    _lastOffsetX = offSetX;
    
    
    
  //  [self.titleView selectLabelWithIndex:offSetX /CMSCREEN_W ];
    
    self.titleView.lastOffsetX = scrollView.contentOffset.x;
    
}



@end
