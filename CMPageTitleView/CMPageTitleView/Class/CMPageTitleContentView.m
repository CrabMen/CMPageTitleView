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

@property (nonatomic,assign) CGFloat underlineX;

@property (nonatomic,assign) CGFloat underlineW;

@property (nonatomic,strong) NSLayoutConstraint *xConstraint;
@property (nonatomic,strong) NSLayoutConstraint *yConstraint;
@property (nonatomic,strong) NSLayoutConstraint *wConstraint;
@property (nonatomic,strong) NSLayoutConstraint *hConstraint;



@end


@implementation CMPageTitleContentView

- (NSLayoutConstraint *)xConstraint {
    
    if (!_xConstraint) {
        _xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.underlineX];
    }
    
    return _xConstraint;
    
}

- (NSLayoutConstraint *)yConstraint {
    
    if (!_yConstraint) {
        _yConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:self.underlineW];
        
    }
    
    return _yConstraint;
    
}
- (NSLayoutConstraint *)wConstraint {
    
    if (!_wConstraint) {
        _wConstraint = [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
    }
    
    return _wConstraint;
    
}
- (NSLayoutConstraint *)hConstraint {
    
    if (!_hConstraint) {
        _hConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:2];
    }
    
    return _hConstraint;
    
}

- (UICollectionView *)collectionView {
    
    
    if (!_collectionView) {
        CMPageTitleFlowLayout *layout = [CMPageTitleFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 30;
        
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
        UIView *underLine = [UIView new];
        underLine.backgroundColor = self.config.cm_underlineColor;
        underLine.layer.cornerRadius = self.config.cm_underlineBorder ? self.config.cm_underlineHeight * 0.5 : 0;
        underLine.layer.masksToBounds = YES;
        underLine.translatesAutoresizingMaskIntoConstraints = NO;
        _underLine = underLine;
        [self insertSubview:_underLine aboveSubview:self.collectionView];
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
    //    [self addSubview:self.collectionView ];
    [self insertSubview:self.collectionView atIndex:0];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    [self initVFLContraints];
}

- (void)initVFLContraints {
    
    
    
    self.underLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    //    self.xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.underlineX];
    //    self.yConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:self.underlineW];
    //    self.wConstraint = [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
    //    self.hConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:2];
    
    [self addConstraint:self.xConstraint];
    [self addConstraint:self.yConstraint];
    [self.underLine addConstraint:self.wConstraint];
    [self.underLine addConstraint:self.hConstraint];
    
    
    //    [self.underLine addConstraints:array];
    
    
    
    
    
}



- (void)initSubViews {
    //    [self initVFLContraints];
    
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
    
    
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
//    [self modifyCenterWithIndexPath:indexPath];
    
    
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
    
//        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
  
    
    
    
}


#pragma mark --- UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
      CMPageTitleCell *cell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0]];
       
    CGRect frame = [self.collectionView convertRect:cell.frame toView:self];
    
    
       if (self.xConstraint) {
             self.xConstraint.constant = frame.origin.x;
             [self layoutIfNeeded];

         }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CMPageTitleCell *cell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0]];
         
      CGRect frame = [self.collectionView convertRect:cell.frame toView:self];
      
      
         if (self.xConstraint) {
               self.xConstraint.constant = frame.origin.x;
               [self layoutIfNeeded];

           }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //    NSArray *array =  [self.collectionView indexPathsForVisibleItems];
    //    NSInteger idx = ceil(array.count / 2) ;
    //    [self.collectionView scrollToItemAtIndexPath:array[idx] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//
//    CMPageTitleCell *cell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0]];
//
//    if (self.xConstraint) {
//          self.xConstraint.constant = cell.cm_x;
//          [self layoutIfNeeded];
//
//      }
    
}

- (void)setUnderlineWithCell:(CMPageTitleCell *)cell {
    
    
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _isClickTitle = YES;
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    CMPageTitleCell *cell = (CMPageTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"选中 -- %02ld -- %@",(long)indexPath.item,cell.titleLabel.text]);
    
    if (self.cm_delegate) {
        
        NSInteger lastIndex =  collectionView.contentOffset.x / self.cm_width;
        
        [self.cm_delegate cm_pageTitleContentViewClickWithLastIndex:lastIndex Index:indexPath.item Repeat:lastIndex == indexPath.item];
    }
    
    _isClickTitle = NO;
    
//    [self modifyUnderlineWithScrollProgress:1 fromIndex:self.config.cm_selectedIndex toIndex:indexPath.item];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CMPageTitleCell *cell = (CMPageTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"反选 -- %02ld -- %@",(long)indexPath.item,cell.titleLabel.text]);
}
//
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
    CGSize size = [self.config.cm_titles[indexPath.item] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    NSLog(@"重新计算宽度");
    return CGSizeMake(size.width, self.config.cm_titleHeight);
}


#pragma mark --- UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMPageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CMPageTitleCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = self.config.cm_titles[indexPath.item];
    cell.titleLabel.font = self.config.cm_font;
    
    [cell cm_cellSetSelectedCompletion:^(BOOL selected) {
        
        if (self.config.cm_switchMode & CMPageTitleSwitchMode_Scale){
            
            CGFloat scale = 1/ self.config.cm_scale ;
            UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
            cell.titleLabel.font = font;
            cell.transform = CGAffineTransformMakeScale(scale, scale);
            cell.itemSize = [cell.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:cell.titleLabel.font} context:nil].size;
            
            if (cell.isSelected) {
                cell.transform = CGAffineTransformIdentity;
            }
            
        }
        
    }];
    
    if (self.config.cm_switchMode & CMPageTitleSwitchMode_Scale){
        
        CGFloat scale = 1/ self.config.cm_scale ;
        UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
        cell.titleLabel.font = font;
        cell.transform = CGAffineTransformMakeScale(scale, scale);
        
        if (cell.isSelected) {
            cell.transform = CGAffineTransformIdentity;
        }
        
    }
    
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
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:centerIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

//    [self modifyCenterWithIndexPath:[NSIndexPath indexPathForItem:centerIndex inSection:0]];
    
}



- (void)modifyColorWithScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    
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



- (void)modifyScaleWithScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Scale) || _isClickTitle || toIndex >= [self.collectionView numberOfItemsInSection:0] || self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
    CMPageTitleCell *fromCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMPageTitleCell *toCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat scaleTransform = 1 - 1/self.config.cm_scale;
    
    
    fromCell.transform = CGAffineTransformMakeScale(1 - progress * scaleTransform ,1- progress * scaleTransform );
    toCell.transform = CGAffineTransformMakeScale(1 - leftScale * scaleTransform , 1 -  leftScale * scaleTransform );
}
- (void)modifyUnderlineWithScrollProgress:(CGFloat)progress fromCell:(CMPageTitleCell *)fromCell targetCell:(CMPageTitleCell *)targetCell {
    
    
     if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline) || _isClickTitle || fromCell == nil || targetCell == nil || self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
     
     
     CGFloat rightLabelX = targetCell.cm_x + (1 - self.config.cm_underlineWidthScale)*targetCell.cm_width*0.5;
     CGFloat leftLabelX = fromCell.cm_x + (1 - self.config.cm_underlineWidthScale)*fromCell.cm_width*0.5;
     CGFloat rightLabelWidth = targetCell.cm_width * self.config.cm_underlineWidthScale;
     CGFloat leftLabelWidth = fromCell.cm_width * self.config.cm_underlineWidthScale;
     
     if (!self.config.cm_underlineStretch) {
         
         CGFloat deltaX = self.config.cm_underlineWidth ? (targetCell.cm_centerX - fromCell.cm_centerX) : (rightLabelX - leftLabelX);
         
         CGFloat deltaWidth = self.config.cm_underlineWidth ? 0 : (rightLabelWidth - leftLabelWidth);
         
         CGFloat newOriginalX = self.config.cm_underlineWidth ? progress*deltaX + fromCell.cm_centerX - self.config.cm_underlineWidth * 0.5: progress * deltaX + leftLabelX;
         CGFloat newWidth = self.config.cm_underlineWidth ? : (progress * deltaWidth + leftLabelWidth);
         
         self.xConstraint.constant= newOriginalX - self.collectionView.contentOffset.x;
         self.wConstraint.constant = newWidth;
         [self layoutIfNeeded];
         [self.underLine layoutIfNeeded];
         
         //        NSLog(@"下划线宽度--%lf",newWidth);
         NSLog(@"下划线x--%lf",newOriginalX);
         
         
     } else {
         
         CGFloat rightLabelRight = targetCell.cm_right - (targetCell.cm_width - rightLabelWidth)*0.5;
         CGFloat leftLabelRight = fromCell.cm_right - (fromCell.cm_width - leftLabelWidth)*0.5;
         
         if (progress <= 0.5) {
             CGFloat deltaWidth =  self.config.cm_underlineWidth ? (targetCell.cm_centerX - fromCell.cm_centerX) : rightLabelRight - leftLabelRight;
             
             CGFloat originalWidth = self.config.cm_underlineWidth ?: leftLabelWidth;
             
             CGFloat newWidth = 2 * progress * deltaWidth + originalWidth;
             
             CGFloat originalX = self.config.cm_underlineWidth ? fromCell.cm_centerX - self.config.cm_underlineWidth * 0.5 : leftLabelX;
             self.xConstraint.constant= originalX - self.collectionView.contentOffset.x;
             self.wConstraint.constant = newWidth;
             [self layoutIfNeeded];
             [self.underLine layoutIfNeeded];
             
         } else {
             
             CGFloat deltaWidth = self.config.cm_underlineWidth ? (targetCell.cm_centerX - fromCell.cm_centerX) : rightLabelX - leftLabelX;
             progress = 1- progress;
             CGFloat newWidth = 2 * progress * deltaWidth + (self.config.cm_underlineWidth ?: rightLabelWidth);
             CGFloat originalX = self.config.cm_underlineWidth ? targetCell.cm_centerX + self.config.cm_underlineWidth * 0.5 - newWidth : rightLabelRight - newWidth;
             self.xConstraint.constant= originalX - self.collectionView.contentOffset.x;
             self.wConstraint.constant = newWidth;
             [self layoutIfNeeded];
             [self.underLine layoutIfNeeded];
             
         }
     }
     

}

- (void)modifyUnderlineWithScrollProgress:(CGFloat)progress fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline) || _isClickTitle || toIndex >= [self.collectionView numberOfItemsInSection:0]|| self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
    
    CMPageTitleCell *fromCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMPageTitleCell *toCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    
    CGFloat rightLabelX = toCell.cm_x + (1 - self.config.cm_underlineWidthScale)*toCell.cm_width*0.5;
    CGFloat leftLabelX = fromCell.cm_x + (1 - self.config.cm_underlineWidthScale)*fromCell.cm_width*0.5;
    CGFloat rightLabelWidth = toCell.cm_width * self.config.cm_underlineWidthScale;
    CGFloat leftLabelWidth = fromCell.cm_width * self.config.cm_underlineWidthScale;
    
    if (!self.config.cm_underlineStretch) {
        
        CGFloat deltaX = self.config.cm_underlineWidth ? (toCell.cm_centerX - fromCell.cm_centerX) : (rightLabelX - leftLabelX);
        
        CGFloat deltaWidth = self.config.cm_underlineWidth ? 0 : (rightLabelWidth - leftLabelWidth);
        
        CGFloat newOriginalX = self.config.cm_underlineWidth ? progress*deltaX + fromCell.cm_centerX - self.config.cm_underlineWidth * 0.5: progress * deltaX + leftLabelX;
        CGFloat newWidth = self.config.cm_underlineWidth ? : (progress * deltaWidth + leftLabelWidth);
        
        self.xConstraint.constant= newOriginalX;
        self.wConstraint.constant = newWidth;
        [self layoutIfNeeded];
        [self.underLine layoutIfNeeded];
        
        //        NSLog(@"下划线宽度--%lf",newWidth);
        NSLog(@"下划线x--%lf",newOriginalX);
        
        
    } else {
        
        
        CGFloat rightLabelRight = toCell.cm_right - (toCell.cm_width - rightLabelWidth)*0.5;
        CGFloat leftLabelRight = fromCell.cm_right - (fromCell.cm_width - leftLabelWidth)*0.5;
        
        if (progress <= 0.5) {
            CGFloat deltaWidth =  self.config.cm_underlineWidth ? (toCell.cm_centerX - fromCell.cm_centerX) : rightLabelRight - leftLabelRight;
            
            CGFloat originalWidth = self.config.cm_underlineWidth ?: leftLabelWidth;
            
            CGFloat newWidth = 2 * progress * deltaWidth + originalWidth;
            
            CGFloat originalX = self.config.cm_underlineWidth ? fromCell.cm_centerX - self.config.cm_underlineWidth * 0.5 : leftLabelX;
            self.xConstraint.constant= originalX;
            self.wConstraint.constant = newWidth;
            [self layoutIfNeeded];
            [self.underLine layoutIfNeeded];
            
        } else {
            
            CGFloat deltaWidth = self.config.cm_underlineWidth ? (toCell.cm_centerX - fromCell.cm_centerX) : rightLabelX - leftLabelX;
            progress = 1- progress;
            CGFloat newWidth = 2 * progress * deltaWidth + (self.config.cm_underlineWidth ?: rightLabelWidth);
            CGFloat originalX = self.config.cm_underlineWidth ? toCell.cm_centerX + self.config.cm_underlineWidth * 0.5 - newWidth : rightLabelRight - newWidth;
            self.xConstraint.constant= originalX;
            self.wConstraint.constant = newWidth;
            [self layoutIfNeeded];
            [self.underLine layoutIfNeeded];
            
        }
        
        
        
        
        
    }
    
    
    
    
}

//
//- (void)modifyUnderlineWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
//
//
//    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline) || _isClickTitle || rightIndex >= self.titleLabels.count|| self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
//
//    CMDisplayTitleLabel *rightLabel = self.titleLabels[rightIndex];
//    CMDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
//
//
//    CGFloat rightLabelX = rightLabel.cm_x + (1 - self.config.cm_underlineWidthScale)*rightLabel.cm_width*0.5;
//    CGFloat leftLabelX = leftLabel.cm_x + (1 - self.config.cm_underlineWidthScale)*leftLabel.cm_width*0.5;
//    CGFloat rightLabelWidth = rightLabel.cm_width * self.config.cm_underlineWidthScale;
//    CGFloat leftLabelWidth = leftLabel.cm_width * self.config.cm_underlineWidthScale;
//
//    if (!self.config.cm_underlineStretch) {
//
//        CGFloat deltaX = self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : (rightLabelX - leftLabelX);
//
//        CGFloat deltaWidth = self.config.cm_underlineWidth ? 0 : (rightLabelWidth - leftLabelWidth);
//
//        CGFloat newOriginalX = self.config.cm_underlineWidth ? progress*deltaX + leftLabel.cm_centerX - self .config.cm_underlineWidth * 0.5: progress * deltaX + leftLabelX;
//        CGFloat newWidth = self.config.cm_underlineWidth ? : (progress * deltaWidth + leftLabelWidth);
//
//        self.underLine.cm_x = newOriginalX;
//        self.underLine.cm_width = newWidth;
//
//    } else {
//
//        CGFloat rightLabelRight = rightLabel.cm_right - (rightLabel.cm_width - rightLabelWidth)*0.5;
//        CGFloat leftLabelRight = leftLabel.cm_right - (leftLabel.cm_width - leftLabelWidth)*0.5;
//
//        if (progress <= 0.5) {
//            CGFloat deltaWidth =  self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : rightLabelRight - leftLabelRight;
//
//            CGFloat originalWidth = self.config.cm_underlineWidth ?: leftLabelWidth;
//
//            CGFloat newWidth = 2 * progress * deltaWidth + originalWidth;
//
//            CGFloat originalX = self.config.cm_underlineWidth ? leftLabel.cm_centerX - self.config.cm_underlineWidth * 0.5 : leftLabelX;
//
//            self.underLine.cm_width = newWidth;
//            self.underLine.cm_x = originalX;
//
//
//        } else {
//
//            CGFloat deltaWidth = self.config.cm_underlineWidth ? (rightLabel.cm_centerX - leftLabel.cm_centerX) : rightLabelX - leftLabelX;
//            progress = 1- progress;
//            CGFloat newWidth = 2 * progress * deltaWidth + (self.config.cm_underlineWidth ?: rightLabelWidth);
//            CGFloat originalX = self.config.cm_underlineWidth ? rightLabel.cm_centerX + self.config.cm_underlineWidth * 0.5 - newWidth : rightLabelRight - newWidth;
//
//            self.underLine.cm_x = originalX;
//            self.underLine.cm_width = newWidth;
//
//        }
//    }
//



- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    
    NSLog(@"滚动时的progress ----- %lf",progress);
    
    CMPageTitleCell *fromCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
      CMPageTitleCell *targetCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    [self modifyColorWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
    [self modifyScaleWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
//    [self modifyUnderlineWithScrollProgress:progress fromIndex:fromIndex toIndex:toIndex];
    [self modifyUnderlineWithScrollProgress:progress fromCell:fromCell targetCell:targetCell];

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
//
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
////        CGFloat scale = fabs(deltaCenterX/self.collectionView.bounds.size.width * 0.5 - 1.2) ;
////
//        CGRect frame = attribute.frame;
//        frame.origin.x += deltaCenterX;
//
//        attribute.frame = frame;
//    }
//
//
//    return itemAttrs;
//
//
//}
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//
//    return YES;
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//
//
//
//}

@end

typedef void(^SelectedBlock)(BOOL selected);

@interface CMPageTitleCell ()

@property(nonatomic,copy) SelectedBlock block;

@end


@implementation CMPageTitleCell

- (CMDisplayTitleLabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[CMDisplayTitleLabel alloc] initWithFrame:self.bounds];
        //        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (void)cm_cellSetSelectedCompletion:(void (^)(BOOL))completion {
    
    self.block = completion;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.titleLabel];
    
    self.itemSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (self.block) {
        self.block(selected);
    }
    
    
    self.titleLabel.textColor = selected ? UIColor.redColor : UIColor.blackColor ;
    self.titleLabel.cm_fillColor =  UIColor.redColor;
    self.titleLabel.cm_progress =  0;
    
}
//
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//
//    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//
//    CGRect rect =[self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
//    rect.size.height = 40;
//
//    CGRect frame = attributes.frame;
//    frame.size  = rect.size;
//    attributes.frame = frame;
//    return attributes;
//
//}



@end
