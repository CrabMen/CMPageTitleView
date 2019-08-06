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
@property (nonatomic,weak) UIView *seperateline;


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

    self.backgroundColor = self.cm_config.cm_backgroundColor;
    
    [self.cm_config setValue:@(self.cm_width) forKey:@"cm_pageTitleViewWidth"];

    [self addSubview:self.titleView];
    
    if (self.cm_config.cm_additionalMode & CMPageTitleAdditionalMode_Seperateline) {
        [self addSubview:self.seperateline];

    }
    
    [self addSubview:self.contentView];

    [self initVFLContraints];
}

- (void)initVFLContraints {
    
    [self addSubview:self.titleView];
    [self addSubview:self.seperateline];
    [self addSubview:self.contentView];

    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.seperateline.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seperateline]|" options:0 metrics:@{}views:@{@"seperateline":self.seperateline}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:@{}views:@{@"content":self.contentView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title(==titleH)][seperateline(==seperateH)][content]|" options:0 metrics:@{@"titleH":@(self.cm_config.cm_titleHeight),@"seperateH":@(self.cm_config.cm_seperateLineHeight)}views:@{@"title":self.titleView,@"seperateline":self.seperateline,@"content":self.contentView}]];

    
    if (self.cm_config.cm_rightView && (self.titleView.contentSize.width - self.titleView.contentInset.right > self.titleView.cm_width)) {
#warning TODO：cm_rightView 的容错处理（修改contentInset和是否添加）
        [self addSubview:self.cm_config.cm_rightView];
        self.cm_config.cm_rightView.translatesAutoresizingMaskIntoConstraints = NO;

        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightView(==width)]|" options:NSLayoutFormatAlignAllRight metrics:@{@"width":@(self.cm_config.cm_rightView.cm_width)}views:@{@"rightView":self.cm_config.cm_rightView}]];
         [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightView(==height)]" options:0 metrics:@{@"height":@(self.cm_config.cm_rightView.cm_height)}views:@{@"rightView":self.cm_config.cm_rightView}]];

    }
}


#pragma mark --- CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewSelectedWithIndex:Repeat:)])
        [self.delegate cm_pageTitleViewSelectedWithIndex:index Repeat:repeat];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cm_pageTitleViewClickWithIndex:Repeat:)])
       [self.delegate cm_pageTitleViewClickWithIndex:index Repeat:repeat];

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
