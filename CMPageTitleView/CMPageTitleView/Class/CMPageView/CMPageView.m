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
#import "CMFlowLayout.h"
@interface CMPageView() <CMPageTitleViewDelegate,CMPageContentViewDelegate>

/**标题视图*/
@property (nonatomic,strong) CMPageTitleView *titleView;

/**内容视图*/
@property (nonatomic,strong) CMPageContentView *contentView;

@end

@implementation CMPageView

- (CMPageTitleView *)titleView {
    
    if (!_titleView) {
        _titleView = [[CMPageTitleView alloc] initWithConfig:self.cm_config];
        _titleView.cm_delegate = self;
    }
    return _titleView;
}


- (CMPageContentView *)contentView {
    if (!_contentView) {
        CMFlowLayout *layout = [CMFlowLayout new];
        CGRect rect = CGRectMake(0, self.cm_config.cm_titleHeight + self.cm_config.cm_seperateLineHeight, self.cm_width, self.cm_height - self.cm_config.cm_titleHeight - self.cm_config.cm_seperateLineHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentView = [[CMPageContentView alloc] initWithFrame:rect collectionViewLayout:layout Config:self.cm_config];
        _contentView.cm_delegate = self;
       
    }
    return _contentView;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self initSubViews];
  
   
}

- (void)initSubViews {
   
    self.backgroundColor = self.cm_config.cm_seperaterLineColor;
    
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    
    
}

#pragma mark --- CMPageTitleViewDelegate

- (void)cm_pageTitleViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (repeat) {
        //获取子视图控制器，刷新数据
        
    } else {
        //获取子视图控制器 切换
        [self.contentView setContentOffset:CGPointMake(index * CMScreenW, 0)];
    }

}


#pragma mark --- CMPageContentViewDelegate

- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index {
    
    self.titleView.cm_selectedIndex = index;
    
}


- (void)cm_pageContentViewDidScroll:(UIScrollView *)scrollView {
    
    [self.titleView cm_pageTitleViewDidScroll:scrollView];
    
}

@end
