//
//  UIView+Common.m
//  EBan
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//
//  Created by CrabMan on 16/9/18.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "UIView+CMCommon.h"

@implementation UIView (CMCommon)


- (CGFloat)cm_x{
    return self.frame.origin.x;
}

- (void)setCm_x:(CGFloat)cm_x{
    CGRect frame = self.frame;
    frame.origin.x = cm_x;
    self.frame = frame;
}

- (CGFloat)cm_y{
    return self.frame.origin.y;
}

- (void)setCm_y:(CGFloat)cm_y{
    CGRect frame = self.frame;
    frame.origin.y = cm_y;
    self.frame = frame;
}


- (CGFloat)cm_width{
    return self.frame.size.width;
}

- (void)setCm_width:(CGFloat)cm_width{
    CGRect frame = self.frame;
    frame.size.width = cm_width;
    self.frame = frame;
}

- (CGFloat)cm_height{
    return self.frame.size.height;
}

- (void)setCm_height:(CGFloat)cm_height{
    CGRect frame = self.frame;
    frame.size.height = cm_height;
    self.frame = frame;
}


- (CGFloat)cm_centerX{
    return self.center.x;
}

- (void)setCm_centerX:(CGFloat)cm_centerX{
    CGPoint center = self.center;
    center.x = cm_centerX;
    self.center = center;
}

- (CGFloat)cm_centerY{
    return self.center.y;
}

- (void)setCm_centerY:(CGFloat)cm_centerY{
    CGPoint center = self.center;
    center.y = cm_centerY;
    self.center = center;
}

- (CGPoint)cm_origin{
    return self.frame.origin;
}

- (void)setCm_origin:(CGPoint)cm_origin{
    CGRect frame = self.frame;
    frame.origin = cm_origin;
    self.frame = frame;
}

- (CGSize)cm_size{
    return self.frame.size;
}

- (void)setCm_size:(CGSize)cm_size{
    CGRect frame = self.frame;
    frame.size = cm_size;
    self.frame = frame;
}

// Query other frame locations
- (CGPoint) cm_bottomRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) cm_bottomLeft{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)cm_topRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

// Retrieve and set top, bottom, left, right

- (CGFloat) cm_top{
    return self.frame.origin.y;
}

- (void) setCm_top:(CGFloat)cm_top{
    CGRect newframe = self.frame;
    newframe.origin.y = cm_top;
    self.frame = newframe;
}

- (CGFloat)cm_left{
    return self.frame.origin.x;
}

- (void)setCm_left:(CGFloat)cm_left{
    CGRect newframe = self.frame;
    newframe.origin.x = cm_left;
    self.frame = newframe;
}

- (CGFloat)cm_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCm_bottom:(CGFloat)cm_bottom{
    CGRect newframe = self.frame;
    newframe.origin.y = cm_bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)cm_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCm_right:(CGFloat)cm_right{
    CGFloat delta = cm_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


-(UINavigationController *)cm_navigationController {
    return (self.cm_viewController ? (self.cm_viewController.navigationController ?: nil): nil);
}

- (UIViewController *)cm_viewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while(next != nil);
    
    return nil;
}
@end
