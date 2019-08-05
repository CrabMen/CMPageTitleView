//
//  CMPageTitleView.m
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//
//#warning TODO：将frame布局优化为layout布局

#import "CMPageTitleView.h"
#import "CMPageTitleContentView.h"
#import "CMPageContentView.h"
#import "CMPageTitleViewMacro.h"

@interface CMPageTitleView() <CMPageTitleContentViewDelegate,CMPageContentViewDelegate>

/**标题视图*/
@property (nonatomic,weak) CMPageTitleContentView *titleView;

/**内容视图*/
@property (nonatomic,weak) CMPageContentView *contentView;

/**标题视图和内容视图间的分割线*/
@property (nonatomic,weak) UIView *seperateLine;


@end

@implementation CMPageTitleView

- (UIView *)seperateLine {
    
    if (!_seperateLine) {
        UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectZero];
        
        seperateLine.backgroundColor = self.cm_config.cm_seperaterLineColor;
        
        _seperateLine = seperateLine;
        
        [self addSubview:_seperateLine];
    }
    
    return _seperateLine;
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
        CGRect rect = CGRectMake(0, self.titleView.cm_height +
                                 _seperateLine.cm_height, self.cm_width, self.cm_height - self.titleView.cm_height - _seperateLine.cm_height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       CMPageContentView *contentView = [[CMPageContentView alloc] initWithFrame:rect collectionViewLayout:layout Config:self.cm_config];
        contentView.cm_delegate = self;
        _contentView = contentView;
        [self addSubview:_contentView];
    
    }
    return _contentView;
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

    [self addSubview:self.titleView];
    
    if (self.cm_config.cm_additionalMode & CMPageTitleAdditionalMode_Seperateline) {
        [self addSubview:self.seperateLine];

    }
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, self.titleView.cm_height +
                                        _seperateLine.cm_height, self.cm_width, self.cm_height - self.titleView.cm_height - _seperateLine.cm_height);
    

    [self initVFLContraints];
}

- (void)initVFLContraints {
    
    [self addSubview:self.titleView];
    [self addSubview:self.seperateLine];
    [self addSubview:self.contentView];

    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.seperateLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seperateline]|" options:0 metrics:@{}views:@{@"seperateline":self.seperateLine}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:@{}views:@{@"content":self.contentView}]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title(==titleH)][seperateline(==seperateH)][content]|" options:0 metrics:@{@"titleH":@(self.cm_config.cm_titleHeight),@"seperateH":@(self.cm_config.cm_seperateLineHeight)}views:@{@"title":self.titleView,@"seperateline":self.seperateLine,@"content":self.contentView}]];


}

- (void)initConstraints {
    
    [self addSubview:self.titleView];
    
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.seperateLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftConstraint0 = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
     NSLayoutConstraint *topConstraint0 = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
     NSLayoutConstraint *rightConstraint0 = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *heightConstraint0 = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.cm_config.cm_titleHeight];
    
    
      [NSLayoutConstraint activateConstraints:@[leftConstraint0,topConstraint0,rightConstraint0,heightConstraint0]];
    
    [self addSubview:self.seperateLine];

    NSLayoutConstraint *leftConstraint1 = [NSLayoutConstraint constraintWithItem:self.seperateLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint1 = [NSLayoutConstraint constraintWithItem:self.seperateLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *rightConstraint1 = [NSLayoutConstraint constraintWithItem:self.seperateLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:self.seperateLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.cm_config.cm_seperateLineHeight];

    [NSLayoutConstraint activateConstraints:@[leftConstraint1,topConstraint1,rightConstraint1,heightConstraint1]];

    
    NSLayoutConstraint *leftConstraint2 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint2 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *rightConstraint2 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *heightConstraint2 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [NSLayoutConstraint activateConstraints:@[leftConstraint2,topConstraint2,rightConstraint2,heightConstraint2]];

    
    
    
    
    
}

#pragma mark --- CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewSelectedWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewSelectedWithIndex:index Repeat:repeat];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewClickWithIndex:Repeat:)])
       [self.delegate cm_pageTitleViewClickWithIndex:index Repeat:repeat];

    
    //获取子视图控制器 切换
    if (!repeat)  [self.contentView setContentOffset:CGPointMake(index * self.cm_width, 0)];


}


#pragma mark --- CMPageContentViewDelegate

- (void)cm_pageContentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self.titleView cm_pageTitleContentViewAdjustPosition:scrollView];

}

- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index {

    if (self.titleView.cm_selectedIndex == index) return;

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
