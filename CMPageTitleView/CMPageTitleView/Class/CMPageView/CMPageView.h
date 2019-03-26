//
//  CMPageView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMPageViewDelegate  <NSObject>

- (void)pageViewTitleChangedAtIndex:(NSUInteger)index;

@end


@interface CMPageView : UIView <CMPageViewDelegate>


/**代理*/
@property (nonatomic,weak) id<CMPageViewDelegate> delegate;

/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *cm_config;


@end
