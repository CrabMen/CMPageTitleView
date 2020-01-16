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
@interface CMPageTitleContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *config;


/**是否点击了标题*/
@property (nonatomic,assign) BOOL isClickTitle;

/**下划线*/
@property (nonatomic,weak) UIView *underLine;

/**遮罩*/
@property (nonatomic,weak) UIView *titleCover;

/**上一次的偏移量*/
@property (nonatomic,assign) CGFloat lastOffsetX;


@property (nonatomic,strong) UICollectionView *collectionView;


@end


@implementation CMPageTitleContentView

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        CMPageTitleFlowLayout *layout = [CMPageTitleFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 30;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.cm_width, self.cm_height) collectionViewLayout:layout];
        [_collectionView registerClass:CMPageTitleCell.class forCellWithReuseIdentifier:NSStringFromClass(CMPageTitleCell.class)];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}


- (void)setCm_selectedIndex:(NSInteger)cm_selectedIndex {
    
    _cm_selectedIndex = cm_selectedIndex;
    [self selectCellIndex:cm_selectedIndex];

    
}


- (UIView *)underLine {
    
    if (!_underLine) {
//        UIView *underLine = [UIView new];
//        underLine.backgroundColor = self.config.cm_underlineColor;
//        underLine.layer.cornerRadius = self.config.cm_underlineBorder ? self.config.cm_underlineHeight * 0.5 : 0;
//        underLine.layer.masksToBounds = YES;
//        CGFloat underLineWidth = self.config.cm_underlineWidth ?: [self.titleLabels[self.config.cm_selectedIndex] cm_width] * self.config.cm_underlineWidthScale;
//        underLine.cm_height = self.config.cm_underlineHeight;
//        underLine.cm_bottom = self.config.cm_titleHeight;
//        underLine.cm_width  = underLineWidth;
//        underLine.cm_centerX = [self.titleLabels[self.config.cm_selectedIndex] cm_centerX];
//        _underLine = underLine;
        [self addSubview:_underLine];

    }
    
    return _underLine ;
    
}


-(UIView *)titleCover {
    
    if (!_titleCover) {
        
//        UIView *titleCover = [UIView new];
//        titleCover.backgroundColor = self.config.cm_coverColor ?: [UIColor colorWithWhite:0 alpha:0.3];
//        UILabel *label = self.titleLabels[self.config.cm_selectedIndex];
//        CGFloat width = [self.config.cm_titleWidths[self.config.cm_selectedIndex] floatValue];
//        CGFloat coverW = self.config.cm_coverWidth ? : width + 2 * self.config.cm_coverHorizontalMargin;
//        CGFloat coverH = label.font.pointSize + 2 * self.config.cm_coverVerticalMargin;
//        titleCover.layer.cornerRadius = self.config.cm_coverRadius ?: coverH * 0.5;
//        titleCover.cm_height = coverH;
//        titleCover.cm_width = coverW;
//        titleCover.cm_centerX = label.cm_centerX;
//        titleCover.cm_centerY = self.config.cm_titleHeight * 0.5;
//        _titleCover = titleCover;
//        [self insertSubview:_titleCover atIndex:0];

    }
    return _titleCover ;
}

#pragma mark --- Initial

- (instancetype)initWithConfig:(CMPageTitleConfig *)config {
    
    if (self = [super init]) {
        self.config = config;
        
        self.backgroundColor = self.config.cm_backgroundColor ? : [UIColor whiteColor];
        
        [self initSubViews];
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.collectionView];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
}

- (void)initSubViews {
    
}

- (void)modifyContentInset {
    
}


- (void)initContentSize{
    
    
    
    [self layoutIfNeeded];
    
}

- (void)selectCellIndex:(NSInteger)index{
  _lastOffsetX = index * self.cm_width;
    _cm_selectedIndex = index;
//    self.config.cm_defaultIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
  
    [self modifyCenterWithIndexPath:indexPath];
 
    
}
/**
 让选中的按钮居中显示
 */
- (void)modifyCenterWithIndexPath:(NSIndexPath *)indexPath{
    self.config.cm_defaultIndex = indexPath.item;

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.collectionView.contentSize.width <= self.cm_width) return;
    
    
    CGFloat offsetX = cell.center.x - self.cm_width * 0.5;
    
    offsetX = offsetX > 0 ? offsetX : 0;
    
    CGFloat maxOffsetX = self.collectionView.contentSize.width - self.cm_width + self.collectionView.contentInset.right;
    
    maxOffsetX = maxOffsetX ?:0;
    
    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}


#pragma mark --- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _isClickTitle = YES;

    [self modifyCenterWithIndexPath:indexPath];
    CMPageTitleCell *cell = (CMPageTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"选中 -- %02ld -- %@",indexPath.item,cell.titleLabel.text]);
    
    if (self.cm_delegate) {
        
        
        NSInteger lastIndex =  collectionView.contentOffset.x / self.cm_width;
        
        [self.cm_delegate cm_pageTitleContentViewClickWithLastIndex:lastIndex Index:indexPath.item Repeat:lastIndex == indexPath.item];
    }
    
    _isClickTitle = NO;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CMPageTitleCell *cell = (CMPageTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
       NSLog(@"%@", [NSString stringWithFormat:@"反选 -- %02ld -- %@",indexPath.item,cell.titleLabel.text]);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [self.config.cm_titles[indexPath.item] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.config.cm_font} context:nil].size;
    return CGSizeMake(size.width, self.config.cm_titleHeight);
}


#pragma mark --- UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMPageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CMPageTitleCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = self.config.cm_titles[indexPath.item];
    
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.config.cm_titles.count;
    
}


- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView {
    NSInteger centerIndex = floorf(scrollView.contentOffset.x / self.cm_width);

    [self modifyCenterWithIndexPath:[NSIndexPath indexPathForItem:centerIndex inSection:0]];

}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//    return attribute;
//}


- (void)modifyColorWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    if (_isClickTitle || rightIndex >= [self.collectionView numberOfItemsInSection:0]) return;
    
    CMPageTitleCell *rightCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];
    CMPageTitleCell *leftCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
    CMDisplayTitleLabel *rightLabel = rightCell.titleLabel;
    CMDisplayTitleLabel *leftLabel = leftCell.titleLabel;

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
        leftLabel.cm_fillColor = leftColor;
        
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
    
    
//    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale) || _isClickTitle || rightIndex >= [self.collectionView numberOfItemsInSection:0] || self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
//
//
//       CMPageTitleCell *rightCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];
//       CMPageTitleCell *leftCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
//       CMDisplayTitleLabel *rightLabel = rightCell.titleLabel;
//       CMDisplayTitleLabel *leftLabel = leftCell.titleLabel;
//
//    CGFloat rightScale = progress;
//
//    CGFloat leftScale = 1 - rightScale;
//
//    CGFloat scaleTransform = self.config.cm_scale;
//
//    scaleTransform -= 1;
//    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
//    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
    
//    if (self.selectedLabel == leftLabel) {
//
//        [self resetLayoutConstraintWithLabel:rightLabel Scale:round(rightScale * scaleTransform * 100)/100.0 + 1];
//    }
//
//    if (self.selectedLabel == rightLabel) {
//
//        [self resetLayoutConstraintWithLabel:leftLabel Scale:round(leftScale * scaleTransform * 100)/100.0 + 1];
//    }
    
    
    
}

- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    if (_isClickTitle || toIndex >= [self.collectionView numberOfItemsInSection:0]) return;
       
       CMPageTitleCell *toCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
       CMPageTitleCell *fromCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
       CMDisplayTitleLabel *toLabel = toCell.titleLabel;
       CMDisplayTitleLabel *fromLabel = fromCell.titleLabel;

    CGFloat toScale = fabs(progress);
       
       if (self.config.cm_gradientStyle == CMTitleColorGradientStyle_RGB) {
           
           NSArray *endRGBA = CMColorGetRGBA(self.config.cm_selectedColor);
           NSArray *startRGBA = CMColorGetRGBA(self.config.cm_normalColor);
           
           CGFloat deltaR = [endRGBA[0] floatValue] - [startRGBA[0] floatValue];
           CGFloat deltaG = [endRGBA[1] floatValue] - [startRGBA[1] floatValue];
           CGFloat deltaB = [endRGBA[2] floatValue] - [startRGBA[2] floatValue];
           CGFloat deltaA = [endRGBA[3] floatValue] - [startRGBA[3] floatValue];
           
           
           UIColor *toColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + toScale *deltaR green:[startRGBA[1] floatValue] + toScale *deltaG blue:[startRGBA[2] floatValue] + toScale *deltaB alpha:[startRGBA[3] floatValue] + toScale *deltaA];
           
           UIColor *fromColor = [UIColor colorWithRed:[endRGBA[0] floatValue] - toScale * deltaR green:[endRGBA[1] floatValue] - toScale *deltaG blue:[endRGBA[2] floatValue] + toScale *deltaB alpha:[endRGBA[3] floatValue] - toScale *deltaA];

           toLabel.textColor = toColor;
           fromLabel.textColor = fromColor;
           
       }
       
       // 填充渐变
       if (self.config.cm_gradientStyle == CMTitleColorGradientStyle_Fill) {
           
           toLabel.textColor    = progress > 0 ? self.config.cm_normalColor : self.config.cm_selectedColor;
           toLabel.cm_fillColor = progress > 0 ? self.config.cm_selectedColor : self.config.cm_normalColor;
           toLabel.cm_progress  = progress > 0 ? toScale : 1-toScale;

           fromLabel.textColor     = progress > 0 ? self.config.cm_selectedColor : self.config.cm_normalColor;
           fromLabel.cm_fillColor  = progress > 0 ? self.config.cm_normalColor : self.config.cm_selectedColor;
           fromLabel.cm_progress   = progress > 0 ? toScale : 1-toScale;
           
       }
       
    
    
    
    
}

- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
//    [self modifyTitleScaleWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    
//    [self modifyColorWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    //
    //    [self modifyUnderlineWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    //
    //    [self modifyCoverWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    //
    //    self.lastOffsetX = leftIndex * self.cm_width + progress * self.cm_width;
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


@interface CMPageTitleFlowLayout ()

@end

@implementation CMPageTitleFlowLayout

//
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//
//    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
//
//    NSArray *itemAttrs = [[NSArray alloc]initWithArray:attrs copyItems:YES];
//
//    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
//
//    for (UICollectionViewLayoutAttributes *attribute in itemAttrs) {
//
//        CGFloat deltaCenterX = fabs(screenCenterX - attribute.center.x);
//
//        CGFloat scale = fabs(deltaCenterX/self.collectionView.bounds.size.width * 0.5 - 1.2) ;
//
//        attribute.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//
//    return itemAttrs;
//
//
//}
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//
//    return YES;
//}

@end



@interface CMPageTitleCell ()

@end

@implementation CMPageTitleCell

- (CMDisplayTitleLabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[CMDisplayTitleLabel alloc] initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.titleLabel];
    
    self.itemSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleLabel.textColor = selected ? UIColor.redColor : UIColor.blackColor ;
    self.titleLabel.cm_fillColor =  UIColor.redColor;
    self.titleLabel.cm_progress =  0;
    
}



@end
