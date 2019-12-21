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

@property (nonatomic,weak) CMPageTitleContentView *titleView;

@property (nonatomic,weak) CMPageContentView *contentView;

@property (nonatomic,weak) UIView *seperateline;

@property (nonatomic,strong) UIViewController *parentController;

@end

@implementation CMPageTitleView

- (UIView *)seperateline {
    
    if (!_seperateline) {
        
        UIView *seperateline = [[UIView alloc] init];
        seperateline.backgroundColor = self.cm_config.cm_seperaterLineColor;
        _seperateline = seperateline;
        [self addSubview:_seperateline];
    }
    
    return _seperateline;
}

- (CMPageTitleContentView *)titleView {
    
    if (!_titleView) {
        CMPageTitleContentView *titleView = [[CMPageTitleContentView alloc] initWithConfig:self.cm_config];
        titleView.cm_delegate = self;
        _titleView = titleView;
        
        [self addSubview:_titleView];
    }
    return _titleView;
}


- (CMPageContentView *)contentView {
    if (!_contentView) {
        
        CMFlowLayout *layout = [CMFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CMPageContentView *contentView = [[CMPageContentView alloc] initWithFrame:CGRectZero collectionViewLayout:layout Config:self.cm_config];
        contentView.cm_delegate = self;
        _contentView = contentView;
        [self addSubview:_contentView];
        
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
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.seperateline = nil;
    self.titleView = nil;
    self.contentView = nil;
    
    [self layoutSubviews];
    
    
}


- (void)initSubViews {
    
    CMPageErrorAssert(self.cm_config != nil, @"cm_config属性不能为空");
    self.userInteractionEnabled = YES;
    [self reviseConfig];
    [self initVFLContraints];
    
}

- (void)reviseConfig{
    
    CMPageErrorAssert((self.cm_config.cm_childControllers != nil || self.cm_config.cm_childControllers.count == 0 ), @"cm_childControllers数组需赋值，且数组个数不为空");
    CMPageErrorAssert((self.cm_config.cm_titles != nil || self.cm_config.cm_titles.count == 0 ), @"cm_titles数组需赋值，且数组个数不为空");
    [self.cm_config setValue:@(self.cm_width) forKey:@"cm_pageTitleViewWidth"];
    [self.cm_config setValue:self.parentController forKey:@"cm_parentController"];
    [self addMethodForParentController];
    self.cm_config.cm_font = self.cm_config.cm_font;
    self.cm_config.cm_titles = self.cm_config.cm_titles;
    self.cm_config.cm_titleMargin = self.cm_config.cm_titleMargin;
    self.cm_config.cm_contentMode = self.cm_config.cm_contentMode;
    
}

- (void)initVFLContraints {
    
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.seperateline.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seperateline]|" options:0 metrics:@{}views:@{@"seperateline":self.seperateline}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:@{}views:@{@"content":self.contentView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title(==titleH)][seperateline(==seperateH)][content]|" options:0 metrics:@{@"titleH":@(self.cm_config.cm_titleHeight),@"seperateH":@((self.cm_config.cm_additionalMode&CMPageTitleAdditionalMode_Seperateline) ? self.cm_config.cm_seperateLineHeight : 0)}views:@{@"title":self.titleView,@"seperateline":self.seperateline,@"content":self.contentView}]];
    
    
    if (self.cm_config.cm_rightView && self.cm_config.cm_contentMode != CMPageTitleContentMode_Right) {
        
        [self addSubview:self.cm_config.cm_rightView];
        self.cm_config.cm_rightView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightView(==width)]|" options:NSLayoutFormatAlignAllRight metrics:@{@"width":@(self.cm_config.cm_rightView.cm_width)}views:@{@"rightView":self.cm_config.cm_rightView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==mariginTop)-[rightView(==height)]" options:0 metrics:@{@"mariginTop":@((self.cm_config.cm_titleHeight - self.cm_config.cm_rightView.cm_height)*0.5),@"height":@(self.cm_config.cm_rightView.cm_height)}views:@{@"rightView":self.cm_config.cm_rightView}]];
    }
}




#pragma mark --- CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentViewClickWithLastIndex:(NSUInteger)LastIndex Index:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewSelectedWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewSelectedWithIndex:index Repeat:repeat];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewClickWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewClickWithIndex:index Repeat:repeat];
    
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







- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
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
    
}

@end
