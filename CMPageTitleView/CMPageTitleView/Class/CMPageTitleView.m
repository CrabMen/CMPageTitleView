//
//  CMPageTitleView.m
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageTitleView.h"
#import "CMPageTitleContentView.h"
#import "CMPageContentView.h"
#import "CMPageTitleViewMacro.h"
#import <objc/runtime.h>

@interface CMPageTitleView() <CMPageTitleContentViewDelegate,CMPageContentViewDelegate>

/**标题视图*/
@property (nonatomic,strong) CMPageTitleContentView *titleView;

/**内容视图*/
@property (nonatomic,strong) CMPageContentView *contentView;

/**标题视图和内容视图间的分割线*/
@property (nonatomic,strong) UIView *seperateLine;

@property (nonatomic,strong) UIViewController *parentController;

@property (nonatomic,assign) BOOL fromControllerWillDisappear;
@property (nonatomic,assign) BOOL targetControllerWillAppear;
@property (nonatomic,assign) CGFloat lastOffsetX;


@end

@implementation CMPageTitleView

void endAppearance(id self, SEL _cmd){
    
    [self endApprarance];
    
}

- (UIView *)seperateLine {
    
    if (!_seperateLine) {
        _seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.cm_bottom, self.cm_width, self.cm_config.cm_seperateLineHeight)];
        
        _seperateLine.backgroundColor = self.cm_config.cm_seperaterLineColor;
    }
    
    return _seperateLine;
}

- (CMPageTitleContentView *)titleView {
    
    if (!_titleView) {
        _titleView = [[CMPageTitleContentView alloc] initWithConfig:self.cm_config];
        _titleView.cm_delegate = self;
        _titleView.frame = CGRectMake(0, 0, self.cm_width, self.cm_config.cm_titleHeight);
        
    }
    return _titleView;
}


- (CMPageContentView *)contentView {
    if (!_contentView) {
        CMFlowLayout *layout = [CMFlowLayout new];
        CGRect rect = CGRectMake(0, self.titleView.cm_height +
                                 _seperateLine.cm_height, self.cm_width, self.cm_height - self.titleView.cm_height - _seperateLine.cm_height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentView = [[CMPageContentView alloc] initWithFrame:rect collectionViewLayout:layout Config:self.cm_config];
        _contentView.cm_delegate = self;
        
    }
    return _contentView;
}

- (UIViewController *)parentController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initSubViews];
    
    
}


- (void)cm_reloadConfig {
    
    [self.seperateLine removeFromSuperview];
    [self.titleView removeFromSuperview];
    [self.contentView removeFromSuperview];
    
    
    self.seperateLine = nil;
    self.titleView = nil;
    self.contentView = nil;
    
    [self layoutSubviews];
    
    
}


- (void)initSubViews {
    
    CMPageErrorAssert(self.cm_config != nil, @"cm_config属性不能为空");
    
    self.backgroundColor = self.cm_config.cm_backgroundColor;
    
    [self.cm_config setValue:@(self.cm_width) forKey:@"cm_pageTitleViewWidth"];
    [self.cm_config setValue:self.parentController forKey:@"cm_parentController"];
    [self addMethodForParentController];
    [self addSubview:self.titleView];
    
    if (self.cm_config.cm_additionalMode & CMPageTitleAdditionalMode_Seperateline) {
        [self addSubview:self.seperateLine];
        
    }
    
    [self addSubview:self.contentView];
    
    
    
}


- (void)endApprarance {

    [self endAppraranceFromIndex:self.titleView.cm_selectedIndex TargetIndex:self.titleView.cm_selectedIndex];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    
    return NO;
}

- (void)endAppraranceFromIndex:(NSInteger)fromIndex TargetIndex:(NSInteger)targetIndex {

    NSInteger maxIndex = self.cm_config.cm_childControllers.count - 1;

    if ((fromIndex == maxIndex && targetIndex > maxIndex)|| (fromIndex == 0 && targetIndex<0)) return;

    UIViewController *fromController = self.cm_config.cm_childControllers[fromIndex];
    UIViewController *targetController = self.cm_config.cm_childControllers[targetIndex];

    if (fromIndex != targetIndex)  [fromController endAppearanceTransition];
    [targetController endAppearanceTransition];
    
}

- (void)beginAppearanceFromIndex:(NSInteger)fromIndex TargetIndex:(NSInteger)targetIndex {

    NSInteger maxIndex = self.cm_config.cm_childControllers.count - 1;
    if ((fromIndex == maxIndex && targetIndex > maxIndex)|| (fromIndex == 0 && targetIndex<0)) return;

    UIViewController *fromController = self.cm_config.cm_childControllers[fromIndex];
    UIViewController *targetController = self.cm_config.cm_childControllers[targetIndex];

    if (fromIndex != targetIndex) [fromController beginAppearanceTransition:NO animated:NO];
    [targetController beginAppearanceTransition:YES animated:NO];
    
}

- (void)transtitonFromIndex:(NSInteger)fromIndex TargetIndex:(NSInteger)targetIndex {
    [self beginAppearanceFromIndex:fromIndex TargetIndex:targetIndex];
    [self endAppraranceFromIndex:fromIndex TargetIndex:targetIndex];
}
- (void)addMethodForParentController {
    class_addMethod(self.cm_config.cm_parentController.class,NSSelectorFromString(@"shouldAutomaticallyForwardAppearanceMethods") , method_getImplementation(class_getInstanceMethod(self.class,NSSelectorFromString(@"shouldAutomaticallyForwardAppearanceMethods"))), "v@:");

    class_addMethod(self.cm_config.cm_parentController.class,NSSelectorFromString(@"shouldAutomaticallyForwardAppearanceMethods") , method_getImplementation(class_getInstanceMethod(self.class,NSSelectorFromString(@"shouldAutomaticallyForwardAppearanceMethods"))), "v@:");

    
}

#pragma mark --- CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentViewClickWithLastIndex:(NSUInteger)LastIndex Index:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewSelectedWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewSelectedWithIndex:index Repeat:repeat];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewClickWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewClickWithIndex:index Repeat:repeat];
    
    //获取子视图控制器 切换
    if (!repeat)  [self.contentView setContentOffset:CGPointMake(index * self.cm_width, 0)];
    if (!repeat) [self transtitonFromIndex:LastIndex TargetIndex:index];
    
}


#pragma mark --- CMPageContentViewDelegate

- (void)cm_pageContentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.titleView cm_pageTitleContentViewAdjustPosition:scrollView];
}

- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index {
    if (self.titleView.cm_selectedIndex == index) return;
    [self transtitonFromIndex:self.titleView.cm_selectedIndex TargetIndex:index];
    self.titleView.cm_selectedIndex = index;

    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewSelectedWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewSelectedWithIndex:index Repeat:NO];
    
    if (self.delegate &&  [self.delegate respondsToSelector:@selector(cm_pageTitleViewScrollToIndex:)])
        [self.delegate cm_pageTitleViewScrollToIndex:index];
    
}


- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    [self.titleView cm_pageTitleViewDidScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
}

@end
