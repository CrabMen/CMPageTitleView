//
//  CMPageTitleContentView.m
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPageTitleContentView.h"
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
@property (nonatomic,strong) NSArray *splitters;



@end


@implementation CMPageTitleContentView


- (NSArray *)splitters {
    
    if (!_splitters) {
        NSMutableArray *mArray = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < self.titleLabels.count - 1; i++) {
            UIView *splitter = [UIView new];
            splitter.backgroundColor = self.config.cm_splitterColor;
            splitter.cm_size = CGSizeMake(self.config.cm_splitterSize.width, self.config.cm_splitterSize.height);
            splitter.center = CGPointMake(CGRectGetMaxX([self.titleLabels[i] frame]) + self.config.cm_titleMargin * 0.5, self.config.cm_titleHeight * 0.5);
            [self addSubview:splitter];
            [mArray addObject:splitter];
        }
        _splitters = [mArray copy];
    }
    
    return _splitters;
}

- (NSMutableArray *)titleLabels {
    
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
        
        CGFloat labelX = 0;
        CGFloat labelW = 0;
        
        for (int i = 0; i < self.config.cm_titles.count; i++) {
            CMDisplayTitleLabel *label = [CMDisplayTitleLabel new];
            label.textColor = self.config.cm_normalColor;
            label.font = self.config.cm_font;
            label.text = self.config.cm_titles[i];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            UILabel *lastLabel = [self.titleLabels lastObject];
            if (i == 0 ) {
                if (self.config.cm_contentMode == CMPageTitleContentMode_Right) {
                    labelX = [[self.config valueForKey:@"cm_pageTitleViewWidth"] floatValue] - self.config.cm_titleMargin * self.config.cm_titles.count - self.config.cm_titlesWidth;
                } else if (self.config.cm_contentMode == CMPageTitleContentMode_SpaceAround) {
                    
                    labelX = self.config.cm_titleMargin * 0.5;
                } else {
                    labelX =  self.config.cm_titleMargin;
                }
            } else {
                labelX =  self.config.cm_titleMargin + CGRectGetMaxX(lastLabel.frame);
            }
            labelW = [self.config.cm_titleWidths[i] floatValue];
            
            [self addSubview:label];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabels.lastObject ?: self attribute:self.titleLabels.lastObject ? NSLayoutAttributeRight : NSLayoutAttributeLeft multiplier:1 constant:labelX];
            NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem: self attribute: NSLayoutAttributeCenterY multiplier:1 constant:0];
            
            [NSLayoutConstraint activateConstraints:@[leftConstraint,centerYConstraint]];
            
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
            [label addGestureRecognizer:tap];
            
            [_titleLabels addObject:label];
        }
        
        
    }
    return _titleLabels;
}

- (UIView *)underLine {
    
    if (!_underLine) {
        UIView *underLine = [UIView new];
        underLine.backgroundColor = self.config.cm_underlineColor;
        underLine.layer.cornerRadius = self.config.cm_underlineBorder ? self.config.cm_underlineHeight * 0.5 : 0;
        underLine.layer.masksToBounds = YES;
        CGFloat underLineWidth = self.config.cm_underlineWidth ?: [self.titleLabels[self.config.cm_selectedIndex] cm_width] * self.config.cm_underlineWidthScale;
        underLine.cm_height = self.config.cm_underlineHeight;
        underLine.cm_bottom = self.config.cm_titleHeight;
        underLine.cm_width  = underLineWidth;
        underLine.cm_centerX = [self.titleLabels[self.config.cm_selectedIndex] cm_centerX];
        _underLine = underLine;
        [self addSubview:_underLine];

    }
    
    return _underLine ;
    
}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
        UIView *titleCover = [UIView new];
        titleCover.backgroundColor = self.config.cm_coverColor ?: [UIColor colorWithWhite:0 alpha:0.3];
        UILabel *label = self.titleLabels[self.config.cm_selectedIndex];
        CGFloat width = [self.config.cm_titleWidths[self.config.cm_selectedIndex] floatValue];
        CGFloat coverW = self.config.cm_coverWidth ? : width + 2 * self.config.cm_coverHorizontalMargin;
        CGFloat coverH = label.font.pointSize + 2 * self.config.cm_coverVerticalMargin;
        titleCover.layer.cornerRadius = self.config.cm_coverRadius ?: coverH * 0.5;
        titleCover.cm_height = coverH;
        titleCover.cm_width = coverW;
        titleCover.cm_centerX = label.cm_centerX;
        titleCover.cm_centerY = self.config.cm_titleHeight * 0.5;
        _titleCover = titleCover;
        [self insertSubview:_titleCover atIndex:0];

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
        
        self.backgroundColor = self.config.cm_backgroundColor ? : [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self initSubViews];
        if (self.cm_navigationController && self.config.cm_slideGestureEnable) {
            [self.panGestureRecognizer requireGestureRecognizerToFail:self.cm_navigationController.interactivePopGestureRecognizer];
        }
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self modifyContentInset];
    if (!self.selectedLabel && self.cm_delegate) {
        [self clickLabel:nil];
    }
    
}

- (void)initSubViews {
    
    [self initContentSize];
    [self initSplitters];
    [self modifyContentInset];
}

- (void)modifyContentInset {
    
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, (self.config.cm_rightView && self.config.cm_contentMode != CMPageTitleContentMode_Right)? (self.config.cm_titleMargin+self.config.cm_rightView.cm_width) : self.config.cm_titleMargin);
    
}


- (void)initContentSize{
    
    
    [self titleLabels];
    
    [self layoutIfNeeded];
    
    switch (self.config.cm_contentMode) {
        case CMPageTitleContentMode_SpaceAround:
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]) - self.config.cm_titleMargin * 0.5, 0);
            
            break;
        case CMPageTitleContentMode_Left:
            self.contentSize = self.bounds.size;
            
            break;
        case CMPageTitleContentMode_Right:
            self.contentSize = self.bounds.size;
            
            break;
        case CMPageTitleContentMode_Center:
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]), 0);
            break;
            
        default:
            break;
    }
    
}

- (void)initSplitters {
    
    if (self.config.cm_additionalMode & CMPageTitleAdditionalMode_Splitter) {
        [self splitters];
        
    }
    
    
}

- (void)resetLayoutConstraintWithLabel:(UILabel *)label Scale:(CGFloat)scale{
    
    if (![self.titleLabels containsObject:label] ||
        self.config.cm_scaleGradientContentMode == CMPageTitleScaleGradientContentMode_Center ||
        !(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale)) return;
    
    NSInteger index = [self.titleLabels indexOfObject:label];
    
    NSInteger selectedIndex = self.selectedLabel ? [self.titleLabels indexOfObject:self.selectedLabel] : -1;
    
    NSLayoutConstraint *centerYConstraint = self.constraints[index*2 + 1];
    NSLayoutConstraint *selectedCenterYConstraint = self.selectedLabel ?  self.constraints[selectedIndex*2 + 1] : nil;
    
    switch (self.config.cm_scaleGradientContentMode) {
            
        case CMPageTitleScaleGradientContentMode_Bottom:
            
            centerYConstraint.constant = 0 - label.font.pointSize * 0.5 * (scale - 1);
            selectedCenterYConstraint.constant = 0;
            break;
            
        case CMPageTitleScaleGradientContentMode_Top:
            
            centerYConstraint.constant = label.font.pointSize * 0.5 * (scale - 1);
            selectedCenterYConstraint.constant = 0;
            break;
            
        default:
            break;
    }
    
}

- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView {
    
    NSInteger centerIndex = floorf(scrollView.contentOffset.x / self.cm_width);
    
    [self setLabelTitleCenter:self.titleLabels[centerIndex]];
    
}


#pragma mark --- 样式视图

- (void)setUnderLineWithLabel:(UILabel *)label {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline)) return;
    
    [self underLine];
    
    CGFloat underLineWidth = self.config.cm_underlineWidth ?: label.cm_width * self.config.cm_underlineWidthScale;
    [UIView animateWithDuration:self.config.cm_animationDruction animations:^{
        self.underLine.cm_width = underLineWidth;
        self.underLine.cm_centerX = label.cm_centerX;
        
    }];
    
    
}

/**遮罩样式*/
- (void)setTitleCoverWithLabel:(UILabel *)label {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Cover)) return;
    
    [self titleCover];
    
    NSUInteger index = [self.titleLabels indexOfObject:label];
    CGFloat width = [self.config.cm_titleWidths[index] floatValue];
    CGFloat coverW = self.config.cm_coverWidth ? : width + 2 * self.config.cm_coverHorizontalMargin;
    [UIView animateWithDuration:self.config.cm_animationDruction animations:^{
        self.titleCover.cm_width = coverW;
        self.titleCover.cm_centerX = label.cm_centerX;
    }];
        
    
}


/**label点击事件*/
- (void)clickLabel:(UIGestureRecognizer *)tap {
    
    // 记录是否点击标题,通过这个属性防止标题二次偏移
    _isClickTitle = YES;
    
    // 获取对应标题label
    CMDisplayTitleLabel *label = tap ? (CMDisplayTitleLabel *)tap.view : self.titleLabels[self.config.cm_selectedIndex];
    
    if (self.cm_delegate) {
        [self.cm_delegate cm_pageTitleContentViewClickWithLastIndex:self.cm_selectedIndex Index:[self.titleLabels indexOfObject:label] Repeat:label == self.selectedLabel];
    }
    
    _cm_selectedIndex = [self.titleLabels indexOfObject:label];
    
    [self selectLabel:label];
    
    _isClickTitle = NO;
    
}


/**
 选中标题Label的设置
 */
- (void)selectLabel:(CMDisplayTitleLabel *)label {
    
    
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
    
    self.selectedLabel.cm_progress = 1;
    self.selectedLabel.cm_fillColor = self.config.cm_selectedColor;
    label.transform = CGAffineTransformMakeScale(self.config.cm_scale, self.config.cm_scale);
    self.selectedLabel.transform = CGAffineTransformIdentity;
    
    [self resetLayoutConstraintWithLabel:label Scale:self.config.cm_scale];
    
}

/**
 让选中的按钮居中显示
 */
- (void)setLabelTitleCenter:(UILabel *)label {
    
    
    if (self.contentSize.width <= self.cm_width) return;
    
    
    CGFloat offsetX = label.center.x - self.cm_width * 0.5;
    
    offsetX = offsetX > 0 ? offsetX : 0;
    
    CGFloat maxOffsetX = self.contentSize.width - self.cm_width + self.contentInset.right;
    
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
        
        rightLabel.textColor    = self.config.cm_normalColor;
        rightLabel.cm_fillColor = self.config.cm_selectedColor;
        rightLabel.cm_progress  = rightScale;
        
        leftLabel.textColor     = self.config.cm_selectedColor;
        leftLabel.cm_fillColor  = self.config.cm_normalColor;
        leftLabel.cm_progress   = rightScale;
        
    }
    
}


- (void)modifyTitleScaleWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale) || _isClickTitle || rightIndex >= self.titleLabels.count || self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat scaleTransform = self.config.cm_scale;
    
    scaleTransform -= 1;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
    
    if (self.selectedLabel == leftLabel) {
        
        [self resetLayoutConstraintWithLabel:rightLabel Scale:round(rightScale * scaleTransform * 100)/100.0 + 1];
    }
    
    if (self.selectedLabel == rightLabel) {
        
        [self resetLayoutConstraintWithLabel:leftLabel Scale:round(leftScale * scaleTransform * 100)/100.0 + 1];
    }
    
    
    
}




- (void)modifyCoverWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    //通过判断isClickTitle的属性来防止二次偏移
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Cover) || _isClickTitle || rightIndex >= self.titleLabels.count|| self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
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
    
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline) || _isClickTitle || rightIndex >= self.titleLabels.count|| self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
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



@implementation CMDisplayTitleLabel

-(void)drawRect:(CGRect)rect {
    [super drawRect: rect];
    
    [_cm_fillColor set];
    
    rect.size.width = rect.size.width *_cm_progress;
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame] ) {
        self.userInteractionEnabled = YES;
        
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setCm_progress:(CGFloat)cm_progress {
    _cm_progress  = cm_progress;
    
    [self setNeedsDisplay];
    
}

@end
