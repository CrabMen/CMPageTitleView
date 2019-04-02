//
//  CMPageTitleContentView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMPageTitleContentViewDelegate <NSObject>

/**
 当CMPageTitleContentView 中标题被点击会调用该代理方法

 @param index 当前点击的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleContentViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat;

@end


@interface CMPageTitleContentView : UIScrollView

/**选中的标题*/
@property (nonatomic,assign) NSInteger cm_selectedIndex;


/**点击daili*/
@property (nonatomic,weak) id <CMPageTitleContentViewDelegate> cm_delegate;


- (instancetype)initWithConfig:(CMPageTitleConfig *)config;



/**
 根据CMPageContentView对象的滚动情况，
 操作CMPageTitleContentView对象的界面显示
 
 @param scrollView CMPageContentView对象
 */
- (void)cm_pageTitleContentViewDidScroll:(UIScrollView *)scrollView;


/**
 根据CMPageContentView对象的滚动情况，
 调整CMPageTitleContentView对象的滚动情况
 @param scrollView  CMPageContentView对象
 */
- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView;
@end
