//
//  CMPageTitleContentView.h
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMPageTitleContentViewDelegate <NSObject>

@required
/**
 当CMPageTitleContentView 中标题被点击会调用该代理方法

 @param index 当前点击的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleContentViewClickWithLastIndex:(NSUInteger)LastIndex Index:(NSUInteger)index Repeat:(BOOL)repeat;

@end


@interface CMPageTitleContentView : UIScrollView

/**选中的标题*/
@property (nonatomic,assign) NSInteger cm_selectedIndex;


/**点击daili*/
@property (nonatomic,weak) id <CMPageTitleContentViewDelegate> cm_delegate;


/**
 初始化方法

 @param config 配置对象
 @return CMPageTitleContentView对象
 */
- (instancetype)initWithConfig:(CMPageTitleConfig *)config;


/**
 
 根据CMPageContentView对象的滚动情况，
 调整CMPageTitleContentView对象的滚动情况
 
 @param progress 0~1 推拽比例
 @param leftIndex 左边的下标
 @param rightIndex 右边的下标
 */
- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex;


/**
 根据CMPageContentView对象的滚动情况，
 调整CMPageTitleContentView对象的滚动情况
 @param scrollView  CMPageContentView对象
 */
- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView;





@end




@interface CMDisplayTitleLabel : UILabel

@property (nonatomic,assign) CGFloat cm_progress;
@property (nonatomic,strong) UIColor *cm_fillColor;

@end
