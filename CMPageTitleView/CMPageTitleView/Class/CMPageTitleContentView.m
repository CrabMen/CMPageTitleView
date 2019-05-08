//
//  CMPageTitleContentView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPageTitleContentView.h"
#import "CMDisplayTitleLabel.h"

@interface CMPageTitleContentView ()


/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *config;

/**选中的标题*/
@property (nonatomic,strong) CMDisplayTitleLabel *selectedLabel;

/**是否点击了标题*/
@property (nonatomic,assign) BOOL isClickTitle;

/**下划线*/
@property (nonatomic,weak) UIView *underLine;

/**遮罩*/
@property (nonatomic,weak) UIView *titleCover;

/**label数组*/
@property (nonatomic,strong) NSMutableArray *titleLabels;

/**上一次的偏移量*/
@property (nonatomic,assign) CGFloat lastOffsetX;


/**分割线视图数组*/
@property (nonatomic,strong) NSArray *seperateLines;



@end


@implementation CMPageTitleContentView

- (NSArray *)seperateLines {
    
    if (!_seperateLines) {
        NSMutableArray *mArray = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < self.titleLabels.count - 1; i++) {
            UIView *layer = [UIView new];
            layer.backgroundColor = self.config.cm_splitterColor;
            layer.cm_size = CGSizeMake(self.config.cm_splitterSize.width, self.config.cm_splitterSize.height);
            layer.center = CGPointMake(CGRectGetMaxX([self.titleLabels[i] frame]) + self.config.cm_titleMargin * 0.5, self.config.cm_titleHeight * 0.5);
            [self addSubview:layer];
            [mArray addObject:layer];
        }
        _seperateLines = [mArray copy];
    }
    
    return _seperateLines;
}

- (NSMutableArray *)titleLabels {
    
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIView *)underLine {
    
    if (!_underLine) {
        UIView *underLineView = [UIView new];
        underLineView.backgroundColor = self.config.cm_underlineColor;
        underLineView.layer.cornerRadius = self.config.cm_underlineBorder ? self.config.cm_underlineHeight * 0.5 : 0;
        underLineView.layer.masksToBounds = YES;
        [self addSubview:underLineView];
        
        _underLine = underLineView;
    }
    
    return _underLine ;

}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
        UIView *titleCover = [UIView new];
        titleCover.backgroundColor = self.config.cm_coverColor ?: [UIColor colorWithWhite:0 alpha:0.3];
        [self insertSubview:titleCover atIndex:0
         ];
        _titleCover = titleCover;
    }
    return _titleCover ;
}

- (void)setCm_selectedIndex:(NSInteger)cm_selectedIndex {
    
    _cm_selectedIndex = cm_selectedIndex;
    
    [self selectLabel:self.titleLabels[cm_selectedIndex]];
    
}



#pragma mark --- Initial

- (instancetype)initWithConfig:(CMPageTitleConfig *)config {
    
    if (self = [super init]) {
        self.config = config;

        self.backgroundColor = self.config.cm_backgroundColor;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        [self initSubViews];
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
   

    if (!self.selectedLabel) {
        [self clickLabel:nil];
    }
    
}

- (void)initSubViews {
    
//   self.contentInset = UIEdgeInsetsMake(0, 0, 0, self.config.cm_titleMargin);

    [self initTitleLabels];
    [self initSepereateLines];
    
}

- (void)initContentInsets {
    
  

    
    
}


- (void)initTitleLabels {
    
    CGFloat labelX = 0;
    CGFloat labelW = 0;
    
    [self.titleLabels removeAllObjects];
    
    for (int i = 0; i < self.config.cm_titles.count; i++) {
        CMDisplayTitleLabel *label = [CMDisplayTitleLabel new];
        label.textColor = self.config.cm_normalColor;
        label.font = self.config.cm_font;
        label.text = self.config.cm_titles[i];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        UILabel *lastLabel = [self.titleLabels lastObject];
        if (i == 0 ) {
            if (self.config.cm_contentMode == CMPageTitleJustifyContentMode_Right) {
                 labelX = [[self.config valueForKey:@"cm_pageTitleViewWidth"] floatValue] - self.config.cm_titleMargin * self.config.cm_titles.count - self.config.cm_titlesWidth;
            } else if (self.config.cm_contentMode == CMPageTitleJustifyContentMode_SpaceAround) {
                
                
                labelX = self.config.cm_titleMargin * 0.5;
                
            } else {
                
                labelX =  self.config.cm_titleMargin;

                
            }
            
           
            
        } else {
        
            labelX =  self.config.cm_titleMargin + CGRectGetMaxX(lastLabel.frame);
            
        }
        labelW = [self.config.cm_titleWidths[i] floatValue];
        label.frame = CGRectMake(labelX, 0, labelW, self.config.cm_titleHeight);
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
        [label addGestureRecognizer:tap];
        
        [self.titleLabels addObject:label];
        [self addSubview:label];
    }
    
    
    switch (self.config.cm_contentMode) {
        case CMPageTitleJustifyContentMode_SpaceAround:
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]) + self.config.cm_titleMargin * 0.5, 0);

            break;
        case CMPageTitleContentMode_Left:
            self.contentSize = self.bounds.size;

            break;
        case CMPageTitleJustifyContentMode_Right:
            self.contentSize = self.bounds.size;

            break;
        case CMPageTitleJustifyContentMode_Center:
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]) + self.config.cm_titleMargin, 0);

            break;
            
        default:
            break;
    }
    
     //设置scrollView的contentSize
    

}

- (void)initSepereateLines {
    
    if (self.config.cm_switchMode & CMPageTitleSwitchMode_SeperateLine) {
        [self seperateLines];
        
    }
    
    
}

- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView {
    

    NSInteger centerIndex = floorf(scrollView.contentOffset.x / self.cm_width);
    
    [self setLabelTitleCenter:self.titleLabels[centerIndex]];
    
    
}


#pragma mark --- 样式视图
- (void)setUnderLineWithLabel:(UILabel *)label {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline)) return;

    //根据标题的宽度获得下划线的宽度
    CGFloat underLineWidth = self.config.cm_underlineWidth ?: label.cm_width * self.config.cm_underlineWidthScale;
    
    self.underLine.cm_height = self.config.cm_underlineHeight;
    self.underLine.cm_bottom = self.cm_bottom;

    
        if (self.underLine.cm_x == 0) {
            
            self.underLine.cm_width = underLineWidth;
            self.underLine.cm_centerX = label.cm_centerX;
            
        } else {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.underLine.cm_width = underLineWidth;
                self.underLine.cm_centerX = label.cm_centerX;
            }];
        }
}

/**遮罩样式*/
- (void)setTitleCoverWithLabel:(UILabel *)label {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Cover)) return;
    
    //根据标题的宽度获得下划线的宽度
    NSUInteger index = [self.titleLabels indexOfObject:label];
   
    CGFloat width = [self.config.cm_titleWidths[index] floatValue];
        
    CGFloat coverH = label.font.pointSize + 2 * self.config.cm_coverVerticalMargin;
    CGFloat coverW = self.config.cm_coverWidth ? : width + 2 * self.config.cm_coverHorizontalMargin;
    
    self.titleCover.cm_y = (label.cm_height - coverH) * 0.5;
    self.titleCover.cm_height = coverH;
    
    self.titleCover.layer.cornerRadius = self.config.cm_coverRadius ?: coverH * 0.5;

    if (self.titleCover.cm_x == 0) {
            self.titleCover.cm_width = coverW;
            self.titleCover.cm_centerX = label.cm_centerX;
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.titleCover.cm_width = coverW;
                self.titleCover.cm_centerX = label.cm_centerX;
            }];
        }

}


/**label点击事件*/
- (void)clickLabel:(UIGestureRecognizer *)tap {
    
    // 记录是否点击标题,通过这个属性防止标题二次偏移
    _isClickTitle = YES;
    
    // 获取对应标题label
    CMDisplayTitleLabel *label = tap ? (CMDisplayTitleLabel *)tap.view : self.titleLabels[self.config.cm_selectedIndex];
    
    [self selectLabel:label];
    
    _isClickTitle = NO;
    
}


/**
 选中标题Label的设置
 */
- (void)selectLabel:(CMDisplayTitleLabel *)label {
    
    if (self.cm_delegate) {
        [self.cm_delegate cm_pageTitleContentViewClickWithIndex:[self.titleLabels indexOfObject:label] Repeat:label == self.selectedLabel];
    }
    
    if (_selectedLabel == label) return;
    
    [self setLabelTitleCenter:label];
    
    [self setTitleScaleCenter:label];
    
    [self setTitleCoverWithLabel:label];
   
    [self setUnderLineWithLabel:label];
    
    _selectedLabel.textColor = self.config.cm_normalColor;
    _selectedLabel.cm_progress = 0;

    label.textColor = self.config.cm_selectedColor;
    label.cm_fillColor = self.config.cm_selectedColor;
    label.cm_progress = 0;
    
    _selectedLabel = (CMDisplayTitleLabel *)label;
    _lastOffsetX = [self.titleLabels indexOfObject:label] * self.cm_width;

}


- (void)setTitleScaleCenter:(UILabel *)label {

    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale)) return;

    _selectedLabel.transform = CGAffineTransformIdentity;
    _selectedLabel.cm_fillColor = self.config.cm_selectedColor;
    _selectedLabel.cm_progress = 1;
    
    label.transform = CGAffineTransformMakeScale(self.config.cm_scale, self.config.cm_scale);

}

/**
 让选中的按钮居中显示
 */
- (void)setLabelTitleCenter:(UILabel *)label {
    
    
    if (self.contentSize.width <= self.cm_width) return;
    

    CGFloat offsetX = label.center.x - self.cm_width * 0.5;

    offsetX = offsetX > 0 ? offsetX : 0;
  
    CGFloat maxOffsetX = self.contentSize.width - self.cm_width + self.config.cm_titleMargin;

    maxOffsetX = maxOffsetX ?:0;

    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;

    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}




- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    [self modifyTitleScaleWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
    [self modifyColorWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
    [self modifyUnderlineWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
    [self modifyCoverWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
    self.lastOffsetX = leftIndex * self.cm_width + progress * self.cm_width;
}



#pragma mark --- 标题各效果渐变

- (void)modifyColorWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    if (_isClickTitle || rightIndex >= self.titleLabels.count) return;
    
    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    if (self.config.cm_gradientStyle == CMTitleColorGradientStyle_RGB) {
        
        NSArray *endRGBA = CMColorGetRGBA(self.config.cm_selectedColor);
        NSArray *startRGBA = CMColorGetRGBA(self.config.cm_normalColor);
        
        CGFloat deltaR = [endRGBA[0] floatValue] - [startRGBA[0] floatValue];
        CGFloat deltaG = [endRGBA[1] floatValue] - [startRGBA[1] floatValue];
        CGFloat deltaB = [endRGBA[2] floatValue] - [startRGBA[2] floatValue];
        CGFloat deltaA = [endRGBA[3] floatValue] - [startRGBA[3] floatValue];
        
        
        UIColor *rightColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + rightScale *deltaR green:[startRGBA[1] floatValue] + rightScale *deltaG blue:[startRGBA[2] floatValue] + rightScale *deltaB alpha:[startRGBA[3] floatValue] + rightScale *deltaA];
        
        UIColor *leftColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + leftScale * deltaR green:[startRGBA[1] floatValue] + leftScale *deltaG blue:[startRGBA[2] floatValue] + leftScale *deltaB alpha:[startRGBA[3] floatValue] + leftScale *deltaA];
        
        rightLabel.textColor = rightColor;
        leftLabel.textColor = leftColor;
        
    }
    
    // 填充渐变
    if (self.config.cm_gradientStyle == CMTitleColorGradientStyle_Fill) {
        
        rightLabel.textColor = self.config.cm_normalColor;
        rightLabel.cm_fillColor = self.config.cm_selectedColor;
        rightLabel.cm_progress = rightScale;
        
        leftLabel.textColor = self.config.cm_selectedColor;
        leftLabel.cm_fillColor = self.config.cm_normalColor;
        leftLabel.cm_progress = rightScale;
        
    }
    
}


- (void)modifyTitleScaleWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale) || _isClickTitle || rightIndex >= self.titleLabels.count) return;
    
    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat scaleTransform = self.config.cm_scale;
    
    scaleTransform -= 1;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
    
}




- (void)modifyCoverWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {

    
    //通过判断isClickTitle的属性来防止二次偏移
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Cover) || _isClickTitle || rightIndex >= self.titleLabels.count) return;
    
    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    
    CGFloat deltaX = self.config.cm_coverWidth ? rightLabel.cm_centerX - leftLabel.cm_centerX : rightLabel.cm_x - leftLabel.cm_x;
    
    CGFloat deltaWidth = self.config.cm_coverWidth ? 0 : rightLabel.cm_width - leftLabel.cm_width;
    
    
    CGFloat newCenterX = progress * deltaX + leftLabel.cm_centerX ;
    CGFloat newWidth = self.config.cm_coverWidth ? : (progress * deltaWidth + leftLabel.cm_width + 2*self.config.cm_coverHorizontalMargin);
    self.titleCover.cm_centerX = newCenterX;
    self.titleCover.cm_width = newWidth;
  
    
}



- (void)modifyUnderlineWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline) || _isClickTitle || rightIndex >= self.titleLabels.count) return;
    
    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    
    CGFloat rightLabelX = rightLabel.cm_x + (1 - self.config.cm_underlineWidthScale)*rightLabel.cm_width*0.5;
    CGFloat leftLabelX = leftLabel.cm_x + (1 - self.config.cm_underlineWidthScale)*leftLabel.cm_width*0.5;
    CGFloat rightLabelWidth = rightLabel.cm_width * self.config.cm_underlineWidthScale;
    CGFloat leftLabelWidth = leftLabel.cm_width * self.config.cm_underlineWidthScale;
    
    if (!self.config.cm_underlineStretch) {
        
        CGFloat deltaX = self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : (rightLabelX - leftLabelX);
        
        CGFloat deltaWidth = self.config.cm_underlineWidth ? 0 : (rightLabelWidth - leftLabelWidth);
        
        CGFloat newOriginalX = self.config.cm_underlineWidth ? progress*deltaX + leftLabel.cm_centerX - self .config.cm_underlineWidth * 0.5: progress * deltaX + leftLabelX;
        CGFloat newWidth = self.config.cm_underlineWidth ? : (progress * deltaWidth + leftLabelWidth);
        
        self.underLine.cm_x = newOriginalX;
        self.underLine.cm_width = newWidth;
        
    } else {
       
        CGFloat rightLabelRight = rightLabel.cm_right - (rightLabel.cm_width - rightLabelWidth)*0.5;
        CGFloat leftLabelRight = leftLabel.cm_right - (leftLabel.cm_width - leftLabelWidth)*0.5;
        
        if (progress <= 0.5) {
            CGFloat deltaWidth =  self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : rightLabelRight - leftLabelRight;
            
            CGFloat originalWidth = self.config.cm_underlineWidth ?: leftLabelWidth;
            
            CGFloat newWidth = 2 * progress * deltaWidth + originalWidth;
            
            CGFloat originalX = self.config.cm_underlineWidth ? leftLabel.cm_centerX - self.config.cm_underlineWidth * 0.5 : leftLabelX;
            
            self.underLine.cm_width = newWidth;
            self.underLine.cm_x = originalX;
            
            
        } else {
            
            CGFloat deltaWidth = self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : rightLabelX - leftLabelX;
            
            progress = 1- progress;
            CGFloat newWidth = 2 * progress * deltaWidth + (self.config.cm_underlineWidth ?: rightLabelWidth);
            
            CGFloat originalX = self.config.cm_underlineWidth ? rightLabel.cm_centerX + self.config.cm_underlineWidth * 0.5 - newWidth : rightLabelRight - newWidth;
            
            self.underLine.cm_x = originalX;
            self.underLine.cm_width = newWidth;
            
        }
    }

}



@end
