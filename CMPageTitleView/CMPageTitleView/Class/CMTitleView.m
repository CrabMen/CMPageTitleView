//
//  CMTitleView.m
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMTitleView.h"
@interface CMTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CMPageTitleDelegateFlowLayout>


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


@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,assign) CGFloat underlineX;

@property (nonatomic,assign) CGFloat underlineW;

@property (nonatomic,strong) NSLayoutConstraint *xConstraint;
@property (nonatomic,strong) NSLayoutConstraint *yConstraint;
@property (nonatomic,strong) NSLayoutConstraint *wConstraint;
@property (nonatomic,strong) NSLayoutConstraint *hConstraint;

@property (nonatomic,weak) UICollectionView *backgroundCollection;


@property (nonatomic,weak) id <CMPageTitleDelegateFlowLayout> delegate;

@end


@implementation CMTitleView

- (NSLayoutConstraint *)xConstraint {
    if (!_xConstraint) {
        //        _xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.underlineX];
        UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
        CGSize size = [self.config.cm_titles[self.config.cm_selectedIndex] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
        
        
        _xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:size.width * 0.5];
        
    }
    
    return _xConstraint;
    
}

- (NSLayoutConstraint *)yConstraint {
    
    if (!_yConstraint) {
        self.config.cm_underlineSpacing = -4;
        _yConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:self.config.cm_underlineSpacing];
    }
    
    return _yConstraint;
    
}
- (NSLayoutConstraint *)wConstraint {
    
    if (!_wConstraint) {
        
        UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
        CGSize size = [self.config.cm_titles[self.config.cm_selectedIndex] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
        CGFloat width = self.config.cm_underlineWidth ? : size.width;
        
        _wConstraint = [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:width];
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
        layout.minimumLineSpacing = 30;

        layout.estimatedItemSize = CGSizeMake(0, self.config.cm_titleHeight);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionView registerClass:CMTitleCell.class forCellWithReuseIdentifier:NSStringFromClass(CMTitleCell.class)];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = UIColor.clearColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//        collectionView.hidden = YES;
        _collectionView = collectionView;
        
        [self insertSubview:_collectionView atIndex:0];
        
    }
    return _collectionView;
}

- (UICollectionView *)backgroundCollection {
    
    if (!_backgroundCollection) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.config.cm_titleHeight);
        UICollectionView *backgroundCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        backgroundCollection.translatesAutoresizingMaskIntoConstraints = NO;
        [backgroundCollection registerClass:CMPageTitleBgCell.class forCellWithReuseIdentifier:NSStringFromClass(CMPageTitleBgCell.class)];
        backgroundCollection.showsHorizontalScrollIndicator = NO;
        backgroundCollection.backgroundColor = UIColor.clearColor;
        backgroundCollection.delegate = self;
        backgroundCollection.dataSource = self;
        backgroundCollection.pagingEnabled = YES;
        
        
        _backgroundCollection = backgroundCollection;
        
        [self insertSubview:_backgroundCollection belowSubview:self.collectionView];
        
    }
    return _backgroundCollection;
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
        self.delegate = self;
        [self initSubViews];
        
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)initVFLContraints {
    
    
  
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundCollection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundCollection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundCollection attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundCollection attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.backgroundCollection reloadData];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.collectionView reloadData];
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    
    if (self.config.cm_switchMode & CMPageTitleSwitchMode_Underline ) {
        self.underLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:self.xConstraint];
        [self addConstraint:self.yConstraint];
        [self.underLine addConstraint:self.wConstraint];
        [self.underLine addConstraint:self.hConstraint];
    }
    
    
    
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
}



- (void)initSubViews {
    
    [self initVFLContraints];
    
    
}


- (void)selectCellIndex:(NSInteger)index{
    _lastOffsetX = index * self.cm_width;
    _cm_selectedIndex = index;
    self.config.cm_defaultIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
}


#pragma mark --- UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CMTitleCell *cell = (CMTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0]];
    
    CGRect frame = [self.collectionView convertRect:cell.frame toView:self];
    
    if (self.xConstraint) {
        self.xConstraint.constant = frame.origin.x + frame.size.width * 0.5;
        [self layoutIfNeeded];
        
    }
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.backgroundCollection) return;

    _isClickTitle = YES;
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    CMTitleCell *cell = (CMTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"选中 -- %02ld -- %@",(long)indexPath.item,cell.titleLabel.text]);
    
    if (self.cm_delegate) {
        
        NSInteger lastIndex =  collectionView.contentOffset.x / self.cm_width;
        lastIndex = self.config.cm_selectedIndex;
        self.cm_selectedIndex = indexPath.item;
        [self.cm_delegate cm_pageTitleContentViewClickWithLastIndex:lastIndex Index:indexPath.item Repeat:lastIndex == indexPath.item];
        
        self.config.cm_defaultIndex = indexPath.item;
        [self animateUnderlineWithCell:cell];
        
    }
    
    _isClickTitle = NO;
    
    
}


- (void)animateUnderlineWithCell:(CMTitleCell *)cell {
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline)) return;
    
    CGFloat underLineWidth = self.config.cm_underlineWidth ?: cell.cm_width * self.config.cm_underlineWidthScale;
    [UIView animateWithDuration:1 animations:^{
        self.xConstraint.constant = cell.cm_centerX - self.collectionView.contentOffset.x;
        self.wConstraint.constant = underLineWidth;
        [self layoutIfNeeded];
        [self.underLine layoutIfNeeded];
    }];
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.backgroundCollection) return;
    
    CMTitleCell *cell = (CMTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"反选 -- %02ld -- %@",(long)indexPath.item,cell.titleLabel.text]);
}




#pragma mark --- UICollectionViewDataSource


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView  == self.backgroundCollection) {
      return [self backgroundCollection:collectionView cellForItemAtIndexPath:indexPath];
    } else {
       return [self titleCollection:collectionView cellForItemAtIndexPath:indexPath];
    }
}


- (UICollectionViewCell *)titleCollection:(UICollectionView *)titleCollection cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  CMTitleCell *cell = [titleCollection dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CMTitleCell.class) forIndexPath:indexPath];
  cell.titleLabel.text = self.config.cm_titles[indexPath.item];
  cell.titleLabel.font = self.config.cm_font;
  cell.cm_contentMode = indexPath.item % 4;
  cell.spacing = 6;
  cell.imageView.hidden = cell.cm_contentMode == CMTitleCellContentMode_ImageTop;
  [cell cm_cellSetSelectedCompletion:^(BOOL selected) {
      
      if (self.config.cm_switchMode & CMPageTitleSwitchMode_Scale){
          
          CGFloat scale = 1/ self.config.cm_scale ;
          UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
          cell.titleLabel.font = font;
          cell.transform = CGAffineTransformMakeScale(scale, scale);
          //            cell.itemSize = [cell.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:cell.titleLabel.font} context:nil].size;
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

    
    
    
    if (indexPath.row == self.config.cm_selectedIndex) {
        [self initUnderlineConstraintsWithCell:cell indexPath:indexPath];
    }
    

    
    
  return cell;
  
}



- (void)initUnderlineConstraintsWithCell:(UICollectionViewCell*)cell indexPath:(NSIndexPath *)indexPath{
    
    if (!(self.config.cm_switchMode & CMPageTitleSwitchMode_Underline)) return;
    
        
    UICollectionViewLayoutAttributes *attr = [cell preferredLayoutAttributesFittingAttributes:[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]];
    
    self.xConstraint.constant = attr.center.x ;
    self.wConstraint.constant = attr.size.width;
    
    
}


- (UICollectionViewCell *)backgroundCollection:(UICollectionView *)backgroundCollection cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   CMPageTitleBgCell *cell = (CMPageTitleBgCell *)[backgroundCollection dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CMPageTitleBgCell.class) forIndexPath:indexPath];
    
    return  cell;
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.config.cm_titles.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  1;
    
}


- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView {
    
    
}


- (void)modifyColorWithScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    
    if (_isClickTitle || toIndex >= [self.collectionView numberOfItemsInSection:0]) return;
    
    CMTitleCell *toCell = (CMTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    CMTitleCell *fromCell = (CMTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
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
    
    CMTitleCell *fromCell = (CMTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMTitleCell *toCell = (CMTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat scaleTransform = 1 - 1/self.config.cm_scale;
    
    
    fromCell.transform = CGAffineTransformMakeScale(1 - progress * scaleTransform ,1- progress * scaleTransform );
    toCell.transform = CGAffineTransformMakeScale(1 - leftScale * scaleTransform , 1 -  leftScale * scaleTransform );
}
- (void)modifyUnderlineWithScrollProgress:(CGFloat)progress fromCell:(CMTitleCell *)fromCell targetCell:(CMTitleCell *)targetCell {
    
    
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
        
        //        self.xConstraint.constant= newOriginalX - self.collectionView.contentOffset.x;
        
        CGFloat deltaCX = targetCell.cm_centerX - fromCell.cm_centerX;
        
        
        self.xConstraint.constant=  fromCell.cm_centerX + deltaCX *progress - self.collectionView.contentOffset.x;
        self.wConstraint.constant = newWidth;
        [self layoutIfNeeded];
        [self.underLine layoutIfNeeded];
        
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
    
    
    CMTitleCell *fromCell = (CMTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMTitleCell *toCell = (CMTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    
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




- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex {
    
    NSLog(@"滚动时的progress ----- %lf",progress);
    
    CMTitleCell *fromCell = (CMTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMTitleCell *targetCell = (CMTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    [self modifyColorWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
    [self modifyScaleWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
    [self modifyUnderlineWithScrollProgress:progress fromCell:fromCell targetCell:targetCell];
    
    self.backgroundCollection.contentOffset = CGPointMake(0, 0);
    
    
}

- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    if (self.config.cm_switchMode & CMPageTitleSwitchMode_Delay) return;
    
    
    
    
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

- (void)prepareLayout {
    [super prepareLayout];
    if (!self.collectionView) return;

}
@end

typedef void(^SelectedBlock)(BOOL selected);


#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))




@interface CMPageTitleBgCell ()



@end

@implementation CMPageTitleBgCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_image"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initSubviewsVFL];
    
    
}

- (void)initSubviewsVFL {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image]|" options:0 metrics:@{} views:@{@"image":self.imageView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image]|" options:0 metrics:@{} views:@{@"image":self.imageView}]];

}
@end



@interface CMTitleCell ()

@property(nonatomic,copy) SelectedBlock block;

/**角标 */
@property (nonatomic,weak) UILabel *badgeLabel;

@property (nonatomic,strong) NSLayoutConstraint *badgeRightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *badgeTopConstraint;
@property (nonatomic,strong) NSLayoutConstraint *badgeWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *badgeHightConstraint;

@end


@implementation CMTitleCell

- (NSLayoutConstraint *)badgeRightConstraint {
    if (!_badgeRightConstraint) {
       _badgeRightConstraint = [NSLayoutConstraint constraintWithItem:self.cm_badgeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.container attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    }
    return _badgeRightConstraint;
}

- (NSLayoutConstraint *)badgeTopConstraint {
    if (!_badgeTopConstraint) {
       _badgeTopConstraint = [NSLayoutConstraint constraintWithItem:self.cm_badgeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.container attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    }
    return _badgeTopConstraint;
}


- (NSLayoutConstraint *)badgeWidthConstraint {
    if (!_badgeWidthConstraint) {
       _badgeWidthConstraint = [NSLayoutConstraint constraintWithItem:self.cm_badgeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5];
    }
    return _badgeWidthConstraint;
}


- (NSLayoutConstraint *)badgeHightConstraint {
    if (!_badgeHightConstraint) {
       _badgeHightConstraint = [NSLayoutConstraint constraintWithItem:self.cm_badgeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5];
    }
    return _badgeHightConstraint;
}


- (UIStackView *)container {
    if (!_container) {
        UIStackView *container = [[UIStackView alloc] initWithArrangedSubviews:@[self.titleLabel,self.imageView]];
        container.translatesAutoresizingMaskIntoConstraints = NO;
        container.axis = UILayoutConstraintAxisHorizontal;
        container.alignment = UIStackViewAlignmentFill;
        container.distribution= UIStackViewDistributionFill;
        _container = container;
        [self.contentView addSubview:_container];
    }
    return _container;
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.image = [UIImage imageNamed:@"home_message"];
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (CMDisplayTitleLabel *)titleLabel {
    
    if (!_titleLabel) {
        CMDisplayTitleLabel *titleLabel = [CMDisplayTitleLabel new];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.textColor = UIColor.blackColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [self.contentView addSubview:_titleLabel];
        
    }
    return _titleLabel;
}

- (UILabel *)badgeLabel {
    
    if (!_badgeLabel) {
        UILabel *badgeLabel = [UILabel new];
        badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        badgeLabel.layer.cornerRadius = 2.5;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.backgroundColor = UIColor.redColor;
        _badgeLabel = badgeLabel;
        [self.contentView addSubview:_badgeLabel];
    }
    return _badgeLabel;
}


- (void)cm_cellSetSelectedCompletion:(void (^)(BOOL))completion {
    
    self.block = completion;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
         self.cm_contentMode = CMTitleCellContentMode_ImageTop;
        _cm_badgeLabel = self.badgeLabel;
        [self initSubviewsVFL];
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    UICollectionViewLayoutAttributes *attr = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:attr.size];
    CGRect frame = layoutAttributes.frame;
    frame.size = size;
    attr.frame = frame;
    NSLog(@"自适应大小");
    return  attr;
    
}


- (void)setCm_contentMode:(CMPageTitleContentMode)cm_contentMode {
    
     _cm_contentMode = cm_contentMode;
    self.container.axis = (cm_contentMode == CMTitleCellContentMode_ImageLeft || cm_contentMode == CMTitleCellContentMode_ImageRigth) ? UILayoutConstraintAxisHorizontal : UILayoutConstraintAxisVertical;

    if (cm_contentMode == CMTitleCellContentMode_ImageTop || cm_contentMode == CMTitleCellContentMode_ImageLeft) {
       NSArray *subviews = [[self.container.arrangedSubviews reverseObjectEnumerator] allObjects];
       [self.container setValue:subviews forKey:@"arrangedSubviews"];
    }
    
      
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    
    _badgeOffset = badgeOffset;
    
    self.badgeTopConstraint.constant = badgeOffset.y;
    self.badgeRightConstraint.constant = badgeOffset.x;
    
    
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    self.container.spacing = spacing;
}

- (void)initSubviewsVFL {
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[container]|" options:0 metrics:@{}views:@{@"container":self.container}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[container]|" options:0 metrics:@{}views:@{@"container":self.container}]];
 
    [self.contentView addConstraints:@[self.badgeRightConstraint,self.badgeTopConstraint,self.badgeWidthConstraint,self.badgeHightConstraint]];
    
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




@end



#pragma mark --- Class CMTitleSplitterCell

@interface CMTitleSplitterCell ()

/**尺寸 */
@property (nonatomic,weak) UIImageView *splitter;


@property (nonatomic,strong) NSLayoutConstraint *centerXConstraint;
@property (nonatomic,strong) NSLayoutConstraint *centerYConstraint;
@property (nonatomic,strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *heightConstraint;


@end


@implementation CMTitleSplitterCell


- (NSLayoutConstraint *)centerXConstraint {
    if (!_centerXConstraint) {
       _centerXConstraint = [NSLayoutConstraint constraintWithItem:self.splitter attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    }
    return _centerXConstraint;
}

- (NSLayoutConstraint *)centerYConstraint {
    if (!_centerYConstraint) {
       _centerYConstraint = [NSLayoutConstraint constraintWithItem:self.splitter attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    }
    return _centerYConstraint;
}


- (NSLayoutConstraint *)widthConstraint {
    if (!_widthConstraint) {
       _widthConstraint = [NSLayoutConstraint constraintWithItem:self.splitter attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5];
    }
    return _widthConstraint;
}


- (NSLayoutConstraint *)heightConstraint {
    if (!_heightConstraint) {
       _heightConstraint = [NSLayoutConstraint constraintWithItem:self.splitter attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5];
    }
    return _heightConstraint;
}


- (UIImageView *)splitter {
    if (!_splitter) {
        UIImageView *splitter = [UIImageView new];
        splitter.backgroundColor = UIColor.lightGrayColor;
        _splitter = splitter;
        [self.contentView addSubview:_splitter];
    }
    return _splitter;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviewsConstraint];
    }
    
    return self;
}


-(void)setCm_size:(CGSize)cm_size {
    _cm_size = cm_size;
    
    self.widthConstraint.constant = cm_size.width;
    self.heightConstraint.constant = cm_size.height;
    
    
}

- (void)setCm_color:(UIColor *)cm_color {
    _cm_color = cm_color;
    
    self.splitter.backgroundColor = cm_color;
}



- (void)initSubviewsConstraint {
    
    [self.contentView addConstraints:@[self.centerXConstraint,self.centerYConstraint,self.widthConstraint,self.heightConstraint]];
    
}

@end
