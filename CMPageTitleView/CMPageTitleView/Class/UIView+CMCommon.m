//
//  UIView+Common.m
//  EBan
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
- (CGPoint) cm_bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) cm_bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)cm_topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

// Retrieve and set top, bottom, left, right

- (CGFloat) cm_top
{
    return self.frame.origin.y;
}

- (void) setCm_top:(CGFloat)cm_top
{
    CGRect newframe = self.frame;
    newframe.origin.y = cm_top;
    self.frame = newframe;
}

- (CGFloat)cm_left
{
    return self.frame.origin.x;
}

- (void)setCm_left:(CGFloat)cm_left
{
    CGRect newframe = self.frame;
    newframe.origin.x = cm_left;
    self.frame = newframe;
}

- (CGFloat)cm_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCm_bottom:(CGFloat)cm_bottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = cm_bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)cm_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCm_right:(CGFloat)cm_right
{
    CGFloat delta = cm_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setCm_fixedRightWidth:(CGFloat)cm_fixedRightWidth {
    
    CGRect frame = self.frame;
    frame.origin.x -= cm_fixedRightWidth - frame.size.width;
    frame.size.width = cm_fixedRightWidth;
    
    self.frame = frame;
    
    
}


#pragma mark --- UIView跳转到UIViewController

-(UINavigationController *)cm_navigationController {
    
    UIViewController *vc = self.cm_currentController;
    
 vc.navigationController.interactivePopGestureRecognizer.enabled = NO;
    return vc.navigationController;
    
}



- (UIViewController *)cm_currentController {
    //通过响应者链，获得view所在的视图控制器
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while(next != nil);
    
    return nil;
}


- (void)cm_warnningShakeAnimation {
    
    CALayer *lbl = [self layer];
    CGPoint posLbl = [lbl position];
    CGPoint startPoint = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint endPoint = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:startPoint]];
    [animation setToValue:[NSValue valueWithCGPoint:endPoint]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
    
}



- (void)cm_drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer   = [[CAShapeLayer alloc] init];
    shapeLayer.frame            = CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height);
    shapeLayer.backgroundColor   = [UIColor clearColor].CGColor;
    
    UIBezierPath *path  = [UIBezierPath bezierPathWithRoundedRect:shapeLayer.frame cornerRadius:self.layer.cornerRadius];
    
    shapeLayer.path             = path.CGPath;
    shapeLayer.lineWidth         = 1.0f;
    shapeLayer.lineDashPattern    = @[@(lineLength), @(lineSpacing)];
    shapeLayer.fillColor          = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor       = lineColor.CGColor;
    
    [self.layer addSublayer:shapeLayer];
}

@end
