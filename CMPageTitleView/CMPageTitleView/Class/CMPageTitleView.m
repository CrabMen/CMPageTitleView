//
//  CMPageTitleView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageTitleView.h"
#import "CMPageTitleContentView.h"
#import "CMPageContentView.h"
#import "CMFlowLayout.h"

@interface CMPageTitleView() <CMPageTitleContentViewDelegate,CMPageContentViewDelegate>

/**标题视图*/
@property (nonatomic,strong) CMPageTitleContentView *titleView;

/**内容视图*/
@property (nonatomic,strong) CMPageContentView *contentView;

@end

@implementation CMPageTitleView

- (CMPageTitleContentView *)titleView {
    
    if (!_titleView) {
        _titleView = [[CMPageTitleContentView alloc] initWithConfig:self.cm_config];
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

#pragma mark --- CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat {
    
    if (self.delegate) {
        [self.delegate cm_pageTitleViewClickWithIndex:index Repeat:repeat];
    }
    //获取子视图控制器 切换
    if (!repeat)  [self.contentView setContentOffset:CGPointMake(index * CMSCREEN_W, 0)];


}


#pragma mark --- CMPageContentViewDelegate

- (void)cm_pageContentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.titleView cm_pageTitleContentViewAdjustPosition:scrollView];
    
}

- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index {
    
    self.titleView.cm_selectedIndex = index;
    
}


- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    [self.titleView cm_pageTitleViewDidScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
}

@end
