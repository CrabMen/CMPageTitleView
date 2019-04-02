//
//  CMPageTitleView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"

@protocol CMPageTitleViewDelegate <NSObject>
/**
 当标题被点击会调用该代理方法
 
 @param index 当前点击的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat;
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

@end
