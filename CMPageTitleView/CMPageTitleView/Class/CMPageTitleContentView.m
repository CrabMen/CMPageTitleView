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


@end


@implementation CMPageTitleContentView

- (NSMutableArray *)titleLabels {
    
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIView *)underLine {
    
    if (!_underLine) {
        UIView *underLineView = [UIView new];
        underLineView.backgroundColor = self.config.cm_underLineColor ?: [UIColor redColor];
        underLineView.layer.cornerRadius = self.config.cm_underLineBorder ? self.config.cm_underLineHeight * 0.5 : 0;
        underLineView.layer.masksToBounds = YES;
        [self addSubview:underLineView];
        
        _underLine = underLineView;
    }
    
    return self.config.cm_showUnderLine ? _underLine : nil;

}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
        UIView *titleCover = [UIView new];
        titleCover.backgroundColor = self.config.cm_coverColor ?: [UIColor colorWithWhite:0 alpha:0.3];
        [self insertSubview:titleCover atIndex:0
         ];
        _titleCover = titleCover;
    }
    return self.config.cm_showCover?_titleCover:nil;
}

- (void)setCm_selectedIndex:(NSInteger)cm_selectedIndex {
    
    _cm_selectedIndex = cm_selectedIndex;
    
    [self selectLabel:self.titleLabels[cm_selectedIndex]];
    
}



#pragma mark --- Initial

- (instancetype)initWithConfig:(CMPageTitleConfig *)config {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.config = config;
        
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
    
    self.frame = CGRectMake(0, 0, CMSCREEN_W, self.config.cm_titleHeight);
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, -self.config.cm_titleMargin);
    [self initTitleLabels];
    
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
        labelX = self.config.cm_titleMargin + CGRectGetMaxX(lastLabel.frame);
        labelW = [self.config.cm_titleWidths[i] floatValue];
        label.frame = CGRectMake(labelX, 0, labelW, self.config.cm_titleHeight);
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
        [label addGestureRecognizer:tap];
        
        [self.titleLabels addObject:label];
        [self addSubview:label];
    }
    
    
     //设置scrollView的contentSize
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]), 0);
    

}


- (void)cm_pageTitleViewDidScroll:(UIScrollView *)scrollView {
    
        CGFloat offSetX = scrollView.contentOffset.x;
        NSInteger leftIndex = offSetX / self.cm_width;
        UILabel *leftLabel = self.titleLabels[leftIndex];
        NSInteger rightIndex = leftIndex + 1;
        UILabel *rightLabel = (rightIndex < self.titleLabels.count) ? rightLabel = self.titleLabels[rightIndex] :nil;
    
        [self setUpTitleScaleWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
        [self setUpCoverOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
        [self setUpTitleColorGradientWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //    if (_isDelayScroll == NO) { // 延迟滚动，不需要移动下标
    
        [self setUpUnderLineOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
    //    }
    
        self.lastOffsetX = scrollView.contentOffset.x;

    
}


#pragma mark --- 样式视图
- (void)setUnderLineWithLabel:(UILabel *)label {
    //根据标题的宽度获得下划线的宽度
    NSUInteger index = [self.titleLabels indexOfObject:label];
    CGFloat underLineWidth = self.config.cm_underLineW ?: [self.config.cm_titleWidths[index] floatValue];
    
    CGFloat underLineH = self.config.cm_underLineHeight;
        self.underLine.cm_y = label.cm_height - underLineH;
        self.underLine.cm_height = underLineH;
    
#warning TODO : 这个判断可能还有点问题
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
    //根据标题的宽度获得下划线的宽度
    NSUInteger index = [self.titleLabels indexOfObject:label];
   
    CGFloat width = [self.config.cm_titleWidths[index] floatValue];
        
    CGFloat border = 5;
    CGFloat coverH = label.font.pointSize + 2 * border;
    CGFloat coverW = width + 2 * border;
    
    self.titleCover.cm_y = (label.cm_height - coverH) * 0.5;
    self.titleCover.cm_height = coverH;
    
    self.titleCover.layer.cornerRadius =          self.config.cm_coverRadius ?: coverH * 0.5;

#warning TODO : 这个判断可能还有点问题
    if (self.titleCover.cm_x ) {
            self.titleCover.cm_width = coverW;
            self.titleCover.cm_x = label.cm_x - border;
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.titleCover.cm_width = coverW;
                self.titleCover.cm_x = label.cm_x - border;
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
    
    // 点击事件处理完成
    _isClickTitle = NO;
    
}


/**
 选中标题Label的设置
 */
- (void)selectLabel:(UILabel *)label {
    
    if (self.cm_delegate) {
        [self.cm_delegate cm_pageTitleContentViewClickWithIndex:[self.titleLabels indexOfObject:label] Repeat:label == self.selectedLabel];
    }
    
    if (_selectedLabel == label) return;
    
    _selectedLabel.transform = CGAffineTransformIdentity;
    _selectedLabel.textColor = self.config.cm_normalColor;
    _selectedLabel.cm_fillColor = self.config.cm_selectedColor;
    _selectedLabel.cm_progress = 0;
   label.textColor = self.config.cm_selectedColor;

  if (self.config.cm_showScale) {
        label.transform = CGAffineTransformMakeScale(self.config.cm_scale, self.config.cm_scale);
    }
    
    [self setLabelTitleCenter:label];
    
    [self setTitleCoverWithLabel:label];
   
    [self setUnderLineWithLabel:label];
    
    _selectedLabel = (CMDisplayTitleLabel *)label;
    _lastOffsetX = [self.titleLabels indexOfObject:label] * self.bounds.size.width;

}



/**
 让选中的按钮居中显示
 */
- (void)setLabelTitleCenter:(UILabel *)label {
    

    CGFloat offsetX = label.center.x - CMSCREEN_W * 0.5;

    offsetX = offsetX > 0 ? offsetX : 0;
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.contentSize.width - CMSCREEN_W + self.config.cm_titleMargin;

    maxOffsetX = maxOffsetX ?:0;

    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;

    // 滚动区域
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}




#pragma mark --- 标题各效果渐变

/**
 设置标题的颜色渐变
 */
- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(CMDisplayTitleLabel *)rightLabel leftLabel:(CMDisplayTitleLabel *)leftLabel {
    
   // if (_isShowTitleGradient == NO) return;
    
    if (_isClickTitle) return;
    NSLog(@"颜色渐变效果被调用");
    
    // 获取右边缩放
    CGFloat rightScale = offsetX / self.bounds.size.width - [self.titleLabels indexOfObject:leftLabel];
    
    // 获取左边缩放比例
    CGFloat leftScale = 1 - rightScale;
    
    if (self.config.cm_gradientStyle == CMTitleColorGradientStyle_RGB) {
       
        NSArray *endRGBA = CMColorGetRGBA(self.config.cm_selectedColor);
        NSArray *startRGBA = CMColorGetRGBA(self.config.cm_normalColor);
        
        CGFloat deltaR = [endRGBA[0] floatValue] - [startRGBA[0] floatValue];
        CGFloat deltaG = [endRGBA[1] floatValue] - [startRGBA[1] floatValue];
        CGFloat deltaB = [endRGBA[2] floatValue] - [startRGBA[2] floatValue];
        
        UIColor *rightColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + rightScale *deltaR green:[startRGBA[1] floatValue] + rightScale *deltaG blue:[startRGBA[2] floatValue] + rightScale *deltaB alpha:1.0];
        
        UIColor *leftColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + leftScale * deltaR green:[startRGBA[1] floatValue] + leftScale *deltaG blue:[startRGBA[2] floatValue] + leftScale *deltaB alpha:1.0];
        
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


/**
 标题缩放
 */
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    
    if (self.config.cm_showScale == NO || _isClickTitle) return;
    //获取右边的缩放
    CGFloat rightScale = offsetX / self.bounds.size.width - [self.titleLabels indexOfObject:leftLabel];
    
    CGFloat leftScale = 1 - rightScale;
    
    //左右按钮缩放计算
    CGFloat scaleTransform = self.config.cm_scale;
    
    scaleTransform -= 1;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
    
}



/**
 设置遮罩偏移即遮罩的x
 */
- (void)setUpCoverOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    
    //通过判断isClickTitle的属性来防止二次偏移
    if (_isClickTitle || rightLabel == nil) return;

    //获取两个标题x的距离
    CGFloat deltaX = rightLabel.cm_x - leftLabel.cm_x;
    
    //标题宽度的差值
    CGFloat deltaWidth = [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:rightLabel]] floatValue] - [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:leftLabel]] floatValue];
    
    //移动距离
    CGFloat deltaOffSet = offsetX -_lastOffsetX;
    
    CGFloat coverTransformX = deltaOffSet * deltaX / self.bounds.size.width;
    
    // 宽度递增偏移量
    CGFloat coverWidth = deltaOffSet * deltaWidth / self.bounds.size.width;
    
    self.titleCover.cm_width += coverWidth;
    self.titleCover.cm_x += coverTransformX;
}

/**
 设置下标偏移
 */
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
 
    if (  rightLabel == nil ||  _isClickTitle) return;
    
    //获取两个标题x的距离
    CGFloat deltaX = self.config.cm_underLineW ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : (rightLabel.cm_x - leftLabel.cm_x);
    
    //标题宽度的差值
    CGFloat deltaWidth = [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:rightLabel]] floatValue] - [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:leftLabel]] floatValue];
    
    //移动距离
    CGFloat deltaOffSet = offsetX -_lastOffsetX;
    
    CGFloat underLineTransformX = deltaOffSet * deltaX / self.bounds.size.width;
    
    // 宽度递增偏移量
    CGFloat deltaUnderLineWidth = deltaOffSet * deltaWidth / self.bounds.size.width;
    
    self.underLine.cm_width = self.config.cm_underLineW ?: (self.underLine.cm_width + deltaUnderLineWidth);
    
    self.underLine.cm_centerX += underLineTransformX;
    
}


@end
