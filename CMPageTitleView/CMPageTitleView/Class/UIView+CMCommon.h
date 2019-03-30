//
//  UIView+Common.h
//  EBan
//
//  Created by CrabMan on 16/9/18.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CMCommon)


@property (nonatomic, assign) CGFloat cm_x;
@property (nonatomic, assign) CGFloat cm_y;
@property (nonatomic, assign) CGFloat cm_centerX;
@property (nonatomic, assign) CGFloat cm_centerY;

@property (nonatomic, assign) CGFloat cm_width;
@property (nonatomic, assign) CGFloat cm_height;
@property (nonatomic, assign) CGPoint cm_origin;
@property (nonatomic, assign) CGSize  cm_size;

@property (readonly) CGPoint cm_bottomLeft;
@property (readonly) CGPoint cm_bottomRight;
@property (readonly) CGPoint cm_topRight;

@property CGFloat cm_top;
@property CGFloat cm_left;

@property CGFloat cm_bottom;
@property CGFloat cm_right;


/**
 只读属性，可以获得当前视图所在控制器的导航控制器
 */
@property (nonatomic,strong,readonly) UINavigationController *cm_navigationController;

/**
 只读属性，获得当前视图所在的视图控制器
 */
@property (nonatomic,strong,readonly) UIViewController *cm_currentController;


/**
 给view 画虚线

 @param lineLength 虚线宽度
 @param lineSpacing 虚线间隔
 @param lineColor 虚线颜色
 */
- (void)cm_drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**警告抖动动画（输入框为空或内容非法时）*/
- (void)cm_warnningShakeAnimation;

@end
