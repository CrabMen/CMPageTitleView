//
//  UIScrollView+CMGestureConflict.m
//  CMPageTitleView
//
//  Created by zhijie on 第224天 Aug的第2周.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "UIScrollView+CMGestureConflict.h"

@implementation UIScrollView (CMGestureConflict)

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return [otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")] ? ((otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) ? YES :NO) : NO;
    
}


@end
