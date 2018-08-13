//
//  UIView+Frame.m
//  CMCustomTitleBar
//
//  Created by CrabMan on 16/5/1.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(CGFloat)width {
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



-(CGFloat)height {
    return self.frame.size.height;
    
}
-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


-(CGFloat)x {
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}


-(CGFloat)y {
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


-(CGFloat)centerX {
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
