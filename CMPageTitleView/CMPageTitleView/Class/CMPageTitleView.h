//
//  CMPageTitleView.h
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"

@protocol CMPageTitleViewDelegate <NSObject>

@optional
/**
 当标题被点击会或滚动选中后调用该代理方法
 
 @param index 当前选中的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleViewSelectedWithIndex:(NSInteger)index Repeat:(BOOL)repeat;


/**
 当标题被点击会调用该方法
 
 @param index 当前选中的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat;

/**
 当标题滚动选中后调用该代理方法
 
 @param index 当前选中的标题的index

 */
- (void)cm_pageTitleViewScrollToIndex:(NSInteger)index;

/**
标题内容视图滚动会调用

@param fromIndex 当前选中的标题的index
@param targetIndex 目标标题的index
@param progress 进度 (0 ~ 1.0)
*/
- (void)cm_pageTitleDidScrollFromIndex:(NSInteger)fromIndex TargetIndex:(NSInteger)targetIndex Progress:(CGFloat)progress;

@end

@interface CMPageTitleView : UIView

/**
 代理
 */
@property (nonatomic,assign) id <CMPageTitleViewDelegate> delegate;

/**
 配置
 */
@property (nonatomic,strong) CMPageTitleConfig *cm_config;


/**重载配置*/
- (void)cm_reloadConfig;

@end
