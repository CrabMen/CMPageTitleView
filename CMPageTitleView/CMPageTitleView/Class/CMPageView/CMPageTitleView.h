//
//  CMPageTitleView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//
/**
 
 时间：2018年09月06日 13：58：00
 需要优化的地方：修改scrollView 上的label的x默认从零开始；
 不需要设置从计算边距开始；
 并设置默认的scrollView 的edge左右边距默认为与label的计算边距
一些应用场景里面，标题的左右边距与label的中间边距不一致，一般会比中间边距宽一些
 */

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMPageTitleViewDelegate <NSObject>

- (void)cm_pageTitleViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat;


@end





@interface CMPageTitleView : UIScrollView

/**选中的标题*/
@property (nonatomic,assign) NSInteger cm_selectedIndex;


/**点击daili*/
@property (nonatomic,weak) id <CMPageTitleViewDelegate> cm_delegate;

- (instancetype)initWithConfig:(CMPageTitleConfig *)config;


/**
 
 */
- (void)cm_pageTitleViewDidScroll:(UIScrollView *)scrollView;

@end
