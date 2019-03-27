//
//  CMPageView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"

@protocol CMPageViewDelegate <NSObject>

- (void)cm_pageViewClickWithIndex:(NSInteger)index Repeat:(BOOL)repeat;

@end

@interface CMPageView : UIView

/**代理*/
@property (nonatomic,assign) id <CMPageViewDelegate> delegate;

/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *cm_config;

@end
