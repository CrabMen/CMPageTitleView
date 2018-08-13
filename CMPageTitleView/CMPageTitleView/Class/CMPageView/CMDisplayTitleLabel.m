//
//  CMDisplayTitleLabel.m
//  CMCustomTitleBar
//
//  Created by CrabMan on 16/5/1.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CMDisplayTitleLabel.h"

@implementation CMDisplayTitleLabel

-(void)drawRect:(CGRect)rect {
    [super drawRect: rect];

    [_fillColor set];
    
    rect.size.width = rect.size.width *_progress;
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame] ) {
        self.userInteractionEnabled = YES;
        
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress  = progress;
    
    [self setNeedsDisplay];

}
@end
