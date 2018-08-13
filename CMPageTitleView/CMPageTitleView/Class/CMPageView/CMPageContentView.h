//
//  CMPageContentView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMPageContentViewDelegate <NSObject>

- (void)contentViewDidScroll:(UIScrollView *)scrollView;

- (void)contentViewDidEndDecelerating:(NSUInteger )index;
@end



@interface CMPageContentView : UIView


/**代理*/
@property (nonatomic,assign) id <CMPageContentViewDelegate> delegate;



- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)childControllers ParentController:(UIViewController *)parentController;

- (void)setContentOffset:(CGPoint)offset;


@end
