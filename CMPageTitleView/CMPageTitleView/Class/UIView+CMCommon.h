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

@end
