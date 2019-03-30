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

- (void)cm_pageTitleContentViewClickWithIndex:(NSUInteger)index Repeat:(BOOL)repeat;

@end


@interface CMPageTitleContentView : UIScrollView

/**选中的标题*/
@property (nonatomic,assign) NSInteger cm_selectedIndex;


/**点击daili*/
@property (nonatomic,weak) id <CMPageTitleContentViewDelegate> cm_delegate;

- (instancetype)initWithConfig:(CMPageTitleConfig *)config;

/**
 
 */
- (void)cm_pageTitleContentViewDidScroll:(UIScrollView *)scrollView;

@end
