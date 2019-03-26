//
//  CMPageTitleView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPageTitleView.h"
#import "UIColor+Hex.h"

#import "CMParameterSetting.h"
#import "CMDisplayTitleLabel.h"

@interface CMPageTitleView ()


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


@implementation CMPageTitleView

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
        
        [self addSubview:underLineView];
        
        _underLine = underLineView;
    }
    
    return self.config.cm_showUnderLine ? _underLine : nil;

}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
        UIView *titleCover = [UIView new];
        
        titleCover.backgroundColor = self.config.cm_coverColor ?: [UIColor blueColor];
        
        titleCover.layer.cornerRadius = self.config.cm_coverRadius ?: CMCoverCornerRadius;
        
        [self insertSubview:titleCover atIndex:0
         ];
        _titleCover = titleCover;
    }
    return self.config.cm_showCover?_titleCover:nil;
    
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
   
    
}

- (void)initSubViews {
    
    self.frame = CGRectMake(0, 0, CMScreenW, self.config.cm_titleHeight);
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, -self.config.cm_titleMargin);
    
    [self initTitleLabels];
    
}

- (void)initTitleLabels {
    
    CGFloat labelX = 0;
    CGFloat labelW = 0;
    //设置所有的labelframe
    
    [self.titleLabels removeAllObjects];
    
    for (int i = 0; i < self.config.cm_titles.count; i++) {
        CMDisplayTitleLabel *label = [CMDisplayTitleLabel new];
        label.textColor = self.config.cm_normalColor;
        label.font = self.config.cm_font;

        //将label的text与视图控制器对应
        label.text = self.config.cm_titles[i];
        label.lineBreakMode = NSLineBreakByWordWrapping;

        //设置按钮的位置(按钮的frame与前一个按钮的frame有关系)
        UILabel *lastLabel = [self.titleLabels lastObject];
        labelX = self.config.cm_titleMargin + CGRectGetMaxX(lastLabel.frame);
        
        //设置label 的宽度
        labelW = [self.config.cm_titleWidths[i] floatValue];
        label.frame = CGRectMake(labelX, 0, labelW, CMTitleScrollViewH);
        
        //设置label可以与用户交互
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
        [label addGestureRecognizer:tap];
        //监听标题的点击事件
        
        [self.titleLabels addObject:label];
        [self addSubview:label];
    }
    
    
     //设置scrollView的contentSize
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]), 0);
    
    /*如果设置的默认选择index在范围内则使用该index
     否则则默认选择当前数组的第一个
     */
    if (self.config.cm_defaultIndex < self.titleLabels.count && self.config.cm_defaultIndex > 0 ) {
        
        
        [self selectLabel:self.titleLabels.firstObject];
   
    
    } else {
        
        //设置默认选择
        [self selectLabel:self.titleLabels.firstObject];
        
        
    }
    
    
    [self setUnderLineWithLabel:self.titleLabels.firstObject];
    [self setTitleCoverWithLabel:self.titleLabels.firstObject];
    
}


#pragma mark --- 样式视图
- (void)setUnderLineWithLabel:(UILabel *)label {
    //根据标题的宽度获得下划线的宽度
    NSUInteger index = [self.titleLabels indexOfObject:label];
    CGFloat underLineWidth = [self.config.cm_titleWidths[index] floatValue];
    
    // 获取文字尺寸
    CGFloat underLineH = self.config.cm_underLineHeight ?: CMUnderLineH;
        self.underLine.cm_y = label.cm_height - underLineH;
        self.underLine.cm_height = underLineH;
    
    // 最开始不需要动画
        if (self.underLine.cm_x == 0) {
            
            self.underLine.cm_width = underLineWidth;
            self.underLine.cm_x = label.cm_x;

            
        } else {
            
    // 点击时候需要动画
            [UIView animateWithDuration:0.25 animations:^{
                
                self.underLine.cm_width = underLineWidth;
                self.underLine.cm_x = label.cm_x;
                
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
        
        //最开始的时候不需要动画(即x等于0的时候)
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
    CMDisplayTitleLabel *label = (CMDisplayTitleLabel *)tap.view;
    
    //每次点击都需走代理方法，便于网络请求
    if (self.delegate) {
        [self.delegate titleDidClick:[self.titleLabels indexOfObject:label]];

    }
    
    //二次点击 界面无需变化
    
    if (label == self.selectedLabel) return;
    
    // 选中label
    [self selectLabel:label];
    
//    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
   _lastOffsetX = [self.titleLabels indexOfObject:label] * self.bounds.size.width;

    // 点击事件处理完成
    _isClickTitle = NO;
    
    
    
}


- (void)selectLabelWithIndex:(NSUInteger)index {
    
    
    [self selectLabel:self.titleLabels[index]];
    
    
    //渐变效果
    
    
    
}

/**
 选中标题Label的设置
 */
- (void)selectLabel:(UILabel *)label {
    
    if (_selectedLabel == label) return;
    
    _selectedLabel.transform = CGAffineTransformIdentity;
    _selectedLabel.textColor = self.config.cm_normalColor;
    _selectedLabel.fillColor = self.config.cm_selectedColor;
    //_selectedLabel.progress = 1;
    label.textColor = self.config.cm_selectedColor;

    // 标题缩放
  if (self.config.cm_showScale) {
        label.transform = CGAffineTransformMakeScale(self.config.cm_scale, self.config.cm_scale);
    }
    
    
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
//    //设置遮罩
    [self setTitleCoverWithLabel:label];
//
//    //设置下标位置
    [self setUnderLineWithLabel:label];
//
    
    _selectedLabel = (CMDisplayTitleLabel *)label;
    
    //并设置选中的index
//    _cm_defaultIndex = [self.titleLabels indexOfObject:_selectedLabel];
}



/**
 让选中的按钮居中显示
 */
- (void)setLabelTitleCenter:(UILabel *)label
{

    
    
    
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - self.bounds.size.width * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.contentSize.width - self.bounds.size.width + self.config.cm_titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
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
    
        // 获取移动距离
        CGFloat offsetDelta = offsetX - _lastOffsetX;
        
        if (offsetDelta > 0) { // 往右边
            
            
            rightLabel.fillColor = self.config.cm_selectedColor;
            rightLabel.progress = rightScale;
            
            leftLabel.fillColor = self.config.cm_normalColor;
            leftLabel.progress = rightScale;
            
        } else if(offsetDelta < 0){ // 往左边
            
            rightLabel.textColor = self.config.cm_normalColor;
            rightLabel.fillColor = self.config.cm_selectedColor;
            rightLabel.progress = rightScale;
            
            leftLabel.textColor = self.config.cm_selectedColor;
            leftLabel.fillColor = self.config.cm_normalColor;
            leftLabel.progress = rightScale;
            
        }
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
    CGFloat scaleTransform = self.config.cm_scale ?: CMTitleTransformScale;
    
    scaleTransform -= 1;
    //
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
    
    
//    [self setLabelWidthAccordingToTitle:rightLabel.text].size.width - [self setUpLabelWidthAccordingToTitle:leftLabel.text].size.width;
    
    //移动距离
    CGFloat deltaOffSet = offsetX -_lastOffsetX;
    
    /*计算当前的偏移量
     deltaOffSet / CMScreen = coverTransformX / deltaX;
     
     计算宽度偏增量
     deltaOffSet / CMScreen = coverWidth / deltaWidth;
     */
    
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
    CGFloat deltaX = rightLabel.cm_x - leftLabel.cm_x;
    
    //标题宽度的差值
    CGFloat deltaWidth = [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:rightLabel]] floatValue] - [[self.config.cm_titleWidths objectAtIndex:[self.titleLabels indexOfObject:leftLabel]] floatValue];
    
    //移动距离
    CGFloat deltaOffSet = offsetX -_lastOffsetX;
    
    /*计算当前的偏移量
     deltaOffSet / CMScreen = underLineTransformX / deltaX;
     
     计算宽度偏增量
     deltaOffSet / CMScreen = underLineWidth / deltaWidth;
     */
    
    CGFloat underLineTransformX = deltaOffSet * deltaX / self.bounds.size.width;
    
    // 宽度递增偏移量
    CGFloat underLineWidth = deltaOffSet * deltaWidth / self.bounds.size.width;
    
    self.underLine.cm_width += underLineWidth;
    self.underLine.cm_x += underLineTransformX;
    
}


@end
