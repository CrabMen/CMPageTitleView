//
//  CMPageTitleView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

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
