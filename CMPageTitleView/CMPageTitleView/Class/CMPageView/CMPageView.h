//
//  CMPageView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMPageViewDelegate  <NSObject>

- (void)pageViewTitleChangedAtIndex:(NSUInteger)index;

@end


@interface CMPageView : UIView <CMPageViewDelegate>


/**代理*/
@property (nonatomic,weak) id<CMPageViewDelegate> delegate;



/**
 
 标题滚动视图背景颜色
 */
@property (nonatomic,strong) UIColor *pageTitleColor;

/**
 标题高度
 */
@property (nonatomic,assign) CGFloat titleHeight;


/**
 标题正常颜色
 */
@property (nonatomic,strong) UIColor *normalColor;

/**
 标题选中颜色
 */
@property (nonatomic,strong) UIColor *selectedColor;


/**
 标题字体
 */
@property (nonatomic,strong) UIFont *titleFont;

/**
 下划线颜色
 */
@property (nonatomic,strong) UIColor *underLineColor;



- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ChildControllers:(NSArray *)childControllers ParentController:(UIViewController *)parentController;

@end
