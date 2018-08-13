//
//  CMPageTitleView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPageTitleView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "CMParameterSetting.h"
#import "CMDisplayTitleLabel.h"

@interface CMPageTitleView ()
/**标题数组*/
@property (nonatomic,strong) NSArray *titles;

/**标题自适应宽度*/
@property (nonatomic,strong) NSArray *titlesWidth;

/**所有标题的label宽度*/
@property (nonatomic,assign) CGFloat totalLabelWidth;

/**标题间距*/
@property (nonatomic,assign) CGFloat titleMargin;

/**滚动视图*/
@property (nonatomic,strong) UIScrollView *titleScrollView;

/**选中的标题*/
@property (nonatomic,strong) CMDisplayTitleLabel *selectedLabel;

/**是否点击了标题*/
@property (nonatomic,assign) BOOL isClickTitle;

/**下划线*/
@property (nonatomic,weak) UIView *underLine;

/**遮罩*/
@property (nonatomic,weak) UIView *titleCover;

/**分割线*/
@property (nonatomic,strong) UIView *seperateLine;





@end


@implementation CMPageTitleView

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    }
    
    return _titleScrollView;
}

- (NSMutableArray *)titleLabels {
    
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}


- (UIColor *)cm_seperaterLineColor {
    
    _cm_seperaterLineColor = _cm_seperaterLineColor ? _cm_seperaterLineColor : [UIColor blueColor];
    
    return _cm_seperaterLineColor;
    
}

- (CGFloat)cm_seperateLineH {
    
    
    _cm_seperateLineH = _cm_seperateLineH ? _cm_seperateLineH : CM_ONE_PX;
    
    return _cm_seperateLineH;
}


- (UIView *)seperateLine {
    
    if (!_seperateLine) {
        _seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, CMTitleScrollViewH - CM_ONE_PX, self.titleScrollView.bounds.size.width, self.cm_seperateLineH)];
        _seperateLine.backgroundColor = self.cm_seperaterLineColor;
        
        
    }
    return _seperateLine;
    
}

#pragma mark --- Setter Method



- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    
   
}

-(CGFloat)totalLabelWidth {
    
    
    if (!_totalLabelWidth) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        
        for (NSString *title in self.titles) {
            CGFloat width = [self setLabelWidthAccordingToTitle:title].size.width;
            [mutableArr addObject:@(width)];
        }
        
        _titlesWidth = [mutableArr copy];
        
        //给totalLabelWidth属性赋值
        _totalLabelWidth = [[_titlesWidth valueForKeyPath:@"@sum.floatValue"] floatValue];
    }
    return _totalLabelWidth;
    
}


- (NSArray *)titlesWidth {
    
    if (!_titlesWidth) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        
        for (NSString *title in self.titles) {
            CGFloat width = [self setLabelWidthAccordingToTitle:title].size.width;
            [mutableArr addObject:@(width)];
        }
        
        _titlesWidth = [mutableArr copy];
        
        //给totalLabelWidth属性赋值
      //  _totalLabelWidth = [[_titlesWidth valueForKeyPath:@"@sum.floatValue"] floatValue];
    }
    
    return _titlesWidth;
    
}


#pragma mark --- Getter Method

- (CGFloat)titleMargin {
    
    if (self.totalLabelWidth  >= self.bounds.size.width) {
        _titleMargin = self.cm_titleMargin ? self.cm_titleMargin : titleLabelMargin;
        
    } else {
        
        //        CGFloat titleMargin = (self.bounds.size.width - self.labesTotalWidth)/(self.childViewControllers.count + 1);
        CGFloat titleMargin = (self.bounds.size.width - self.totalLabelWidth)/(self.titles.count + 1);
        
        NSLog(@"titleMargin的大小为:%f",titleMargin);
        
        _titleMargin = titleMargin < titleLabelMargin ? titleLabelMargin : titleMargin;
        
//        if (self.cm_titleMargin) {
//            _titleMargin = titleMargin < self.cm_titleMargin ? self.cm_titleMargin : titleMargin;
//
//        }
        
    }
    

    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);

    return _titleMargin;
}


- (UIFont *)titleFont {
    
    return _titleFont ? _titleFont : CMTitleFont;
    
}

- (UIColor *)normalColor {
    
    return _normalColor ? _normalColor : CMNormalColor;
}

- (UIColor *)selectedColor{
    
    return _selectedColor ? _selectedColor : CMSelectColor;
}



- (UIView *)underLine {
    
    if (!_underLine) {
        UIView *underLineView = [UIView new];
        underLineView.backgroundColor = _underLineColor ? _underLineColor : [UIColor redColor];
        
        [self.titleScrollView addSubview:underLineView];
        
        _underLine = underLineView;
    }
    
    return _isShowUnderLine ? _underLine : nil;

}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
        UIView *titleCover = [UIView new];
        
        titleCover.backgroundColor = _titleCoverColor ? _titleCoverColor : [UIColor blueColor];
        
        titleCover.layer.cornerRadius = _titleCoverRadius ? _titleCoverRadius : CMCoverCornerRadius;
        
        [self.titleScrollView insertSubview:titleCover atIndex:0
         ];
        _titleCover = titleCover;
    }
    return _isShowTitleCover?_titleCover:nil;
    
}



#pragma mark --- Initial


- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles {
    
    if (self = [super init]) {
        
      
        self.frame = frame;
        
        self.titles = titles;
        //  [self initSubViews];
    }
    
    return self;
    
    
}


- (instancetype)initWithSize:(CGSize)size Titles:(NSArray *)titles {
    
    if (self = [super init]) {
        
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        self.frame = frame;
        
        self.titles = titles;
      //  [self initSubViews];
    }
    
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
   
    
    
    
    [self initSubViews];
    
}

- (void)initSubViews {
    
    [self addSubview:self.titleScrollView];
    
    [self initTitleLabels];
    
    
}

- (void)initTitleLabels {
    
    CGFloat labelX = 0;
    CGFloat labelW = 0;
    //设置所有的labelframe
    for (int i = 0; i < self.titles.count; i++) {
        CMDisplayTitleLabel *label = [CMDisplayTitleLabel new];
        label.textColor = self.normalColor;
        label.font = self.titleFont;

        //将label的text与视图控制器对应
        label.text = self.titles[i];
        label.lineBreakMode = NSLineBreakByWordWrapping;

        label.textColor = self.normalColor;
        //设置按钮的位置(按钮的frame与前一个按钮的frame有关系)
        UILabel *lastLabel = [self.titleLabels lastObject];
        labelX = self.titleMargin + CGRectGetMaxX(lastLabel.frame);
        
        //设置label 的宽度
        labelW = [self.titlesWidth[i] floatValue];
        label.frame = CGRectMake(labelX, 0, labelW, CMTitleScrollViewH);
        
        //设置label可以与用户交互
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
        [label addGestureRecognizer:tap];
        //监听标题的点击事件
        
        [self.titleLabels addObject:label];
        [self.titleScrollView addSubview:label];
    }
    
     //设置scrollView的contentSize
    self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels.lastObject frame]), 0);
    
    
    //添加分割线
    
    [self.titleScrollView addSubview:self.seperateLine];

  
    /*如果设置的默认选择index在范围内则使用该index
     否则则默认选择当前数组的第一个
     */
    if (self.cm_defaultIndex < self.titleLabels.count && self.cm_defaultIndex > 0 ) {
        
        
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
    CGFloat underLineWidth = [self.titlesWidth[index] floatValue];
    
    // 获取文字尺寸
        CGFloat underLineH = _underLineH ? _underLineH : CMUnderLineH;
        self.underLine.y = label.height - underLineH;
        self.underLine.height = underLineH;
    
    // 最开始不需要动画
        if (self.underLine.x == 0) {
            
            
            self.underLine.width = underLineWidth;
            self.underLine.x = label.x;
            
            
            //如果下划线的宽度为固定值则
            if (self.cm_underLineW) {
                self.underLine.width = self.cm_underLineW;
                self.underLine.centerX = label.centerX;
            }
            
            
        } else {
            
    // 点击时候需要动画
            [UIView animateWithDuration:0.25 animations:^{
                
                if (self.cm_underLineW) {
                    
                    self.underLine.width = self.cm_underLineW;
                    self.underLine.centerX = label.centerX;
                
                } else {
                
                self.underLine.width = underLineWidth;
                self.underLine.x = label.x;
                
                }
            }];
        }
}

/**遮罩样式*/
- (void)setTitleCoverWithLabel:(UILabel *)label {
    
    //根据标题的宽度获得下划线的宽度
    NSUInteger index = [self.titleLabels indexOfObject:label];
    CGFloat width = [self.titlesWidth[index] floatValue];
        
        CGFloat border = 5;
        CGFloat coverH = label.font.pointSize + 2 * border;
        CGFloat coverW = width + 2 * border;
        
        self.titleCover.y = (label.height - coverH) * 0.5;
        self.titleCover.height = coverH;
        
        //最开始的时候不需要动画(即x等于0的时候)
        if (self.titleCover.x ) {
            self.titleCover.width = coverW;
            
            self.titleCover.x = label.x - border;
        } else {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.titleCover.width = coverW;
                
                self.titleCover.x = label.x - border;
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
    _selectedLabel.textColor = self.normalColor;
    _selectedLabel.fillColor = self.normalColor;
    //_selectedLabel.progress = 1;
    label.textColor = self.selectedColor;

    // 标题缩放
  if (_isShowTitleScale) {

        CGFloat scaleTransform = _titleScale?_titleScale:CMTitleTransformScale;

        label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
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
    _cm_defaultIndex = [self.titleLabels indexOfObject:_selectedLabel];
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
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.bounds.size.width + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
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
    
    
    
    if (self.titleColorGradientStyle == CMTitleColorGradientStyleRGB) {
       
        NSArray *endRGBA = CMColorGetRGBA(self.selectedColor);
        NSArray *startRGBA = CMColorGetRGBA(self.normalColor);
        
        CGFloat deltaR = [endRGBA[0] floatValue] - [startRGBA[0] floatValue];
        CGFloat deltaG = [endRGBA[1] floatValue] - [startRGBA[1] floatValue];
        CGFloat deltaB = [endRGBA[2] floatValue] - [startRGBA[2] floatValue];
        
        UIColor *rightColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + rightScale *deltaR green:[startRGBA[1] floatValue] + rightScale *deltaG blue:[startRGBA[2] floatValue] + rightScale *deltaB alpha:1.0];
        
        UIColor *leftColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + leftScale * deltaR green:[startRGBA[1] floatValue] + leftScale *deltaG blue:[startRGBA[2] floatValue] + leftScale *deltaB alpha:1.0];
        
        rightLabel.textColor = rightColor;
        leftLabel.textColor = leftColor;
    
    }
    
    // 填充渐变
    if (self.titleColorGradientStyle == CMTitleColorGradientStyleFill) {
    
        // 获取移动距离
        CGFloat offsetDelta = offsetX - _lastOffsetX;
        
        if (offsetDelta > 0) { // 往右边
            
            
            rightLabel.fillColor = self.selectedColor;
            rightLabel.progress = rightScale;
            
            leftLabel.fillColor = self.normalColor;
            leftLabel.progress = rightScale;
            
        } else if(offsetDelta < 0){ // 往左边
            
            rightLabel.textColor = self.normalColor;
            rightLabel.fillColor = self.selectedColor;
            rightLabel.progress = rightScale;
            
            leftLabel.textColor = self.selectedColor;
            leftLabel.fillColor = self.normalColor;
            leftLabel.progress = rightScale;
            
        }
    }
}


/**
 标题缩放
 */
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    
    if (_isShowTitleScale == NO || _isClickTitle) return;
    //获取右边的缩放
    CGFloat rightScale = offsetX / self.bounds.size.width - [self.titleLabels indexOfObject:leftLabel];
    
    CGFloat leftScale = 1 - rightScale;
    
    //左右按钮缩放计算
    CGFloat scaleTransform = _titleScale?_titleScale:CMTitleTransformScale;
    
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
    CGFloat deltaX = rightLabel.x - leftLabel.x;
    
    //标题宽度的差值
    CGFloat deltaWidth = [[self.titlesWidth objectAtIndex:[self.titleLabels indexOfObject:rightLabel]] floatValue] - [[self.titlesWidth objectAtIndex:[self.titleLabels indexOfObject:leftLabel]] floatValue];
    
    
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
    
    self.titleCover.width += coverWidth;
    self.titleCover.x += coverTransformX;
}

/**
 设置下标偏移
 */
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    if (  rightLabel == nil ||  _isClickTitle) return;
    
    //获取两个标题x的距离
    CGFloat deltaX = rightLabel.x - leftLabel.x;
    
    //标题宽度的差值
    CGFloat deltaWidth = [[self.titlesWidth objectAtIndex:[self.titleLabels indexOfObject:rightLabel]] floatValue] - [[self.titlesWidth objectAtIndex:[self.titleLabels indexOfObject:leftLabel]] floatValue];
    
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
    
    self.underLine.width += underLineWidth;
    self.underLine.x += underLineTransformX;
    
}




/**
 根据label的内容动态获得label的bounds
 */
- (CGRect)setLabelWidthAccordingToTitle:(NSString *)title {
    
    //如果没有设置vc的title，设置抛异常
    if ([title isKindOfClass:[NSNull class]]) {
        NSException *exception = [NSException exceptionWithName:@"CMDisplayViewControllerException" reason:@"未设置对应的childController的title属性" userInfo:nil];
        [exception raise];
    }
    CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    return CGRectMake(0, 0, ceil(titleBounds.size.width), titleBounds.size.width);
}


@end
