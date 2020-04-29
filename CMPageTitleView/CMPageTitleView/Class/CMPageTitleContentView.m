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


@property (nonatomic,weak) UICollectionView *collectionView;

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
        //        _xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.underlineX];
        UIFont *font = [UIFont systemFontOfSize:self.config.cm_font.pointSize*self.config.cm_scale];
        CGSize size = [self.config.cm_titles[self.config.cm_selectedIndex] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
        
        
        _xConstraint =  [NSLayoutConstraint constraintWithItem:self.underLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:size.width * 0.5];
        
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
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collectionView registerClass:CMPageTitleCell.class forCellWithReuseIdentifier:NSStringFromClass(CMPageTitleCell.class)];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = UIColor.whiteColor;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        _collectionView = collectionView;
        
        [self insertSubview:_collectionView atIndex:0];
        
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
    
    
}

- (void)initVFLContraints {
    
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
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
    
    CMPageTitleCell *cell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.config.cm_selectedIndex inSection:0]];
    
    CGRect frame = [self.collectionView convertRect:cell.frame toView:self];
    
    if (self.xConstraint) {
        self.xConstraint.constant = frame.origin.x + frame.size.width * 0.5;
        [self layoutIfNeeded];
        
    }
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _isClickTitle = YES;
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    CMPageTitleCell *cell = (CMPageTitleCell*)[collectionView cellForItemAtIndexPath:indexPath];
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


- (void)animateUnderlineWithCell:(CMPageTitleCell *)cell {
    
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
    
    CMPageTitleCell *fromCell = (CMPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    CMPageTitleCell *targetCell = (CMPageTitleCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    [self modifyColorWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
    [self modifyScaleWithScrollProgress:progress FromIndex:fromIndex ToIndex:toIndex];
    //    [self modifyUnderlineWithScrollProgress:progress fromIndex:fromIndex toIndex:toIndex];
    [self modifyUnderlineWithScrollProgress:progress fromCell:fromCell targetCell:targetCell];
    
}

- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
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



@end

typedef void(^SelectedBlock)(BOOL selected);


#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface CMPageTitleCell ()

@property(nonatomic,copy) SelectedBlock block;



@end


@implementation CMPageTitleCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuijian"]];
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (CMDisplayTitleLabel *)titleLabel {
    
    if (!_titleLabel) {
        
        CMDisplayTitleLabel *titleLabel = [CMDisplayTitleLabel new];
        titleLabel.textColor = UIColor.blackColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [self.contentView addSubview:_titleLabel];
        
    }
    return _titleLabel;
}


- (void)cm_cellSetSelectedCompletion:(void (^)(BOOL))completion {
    
    self.block = completion;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initSubviewsVFL];
    
    
    self.itemSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
}

- (void)initSubviewsVFL {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.contentMode == CMPageTitleCellContentMode_ImageTop) {
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image][title]|" options:0 metrics:@{}views:@{@"image":self.imageView,@"title":self.titleLabel}]];

        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image(==H)][title(==H)]|" options:0 metrics:@{@"H":@22} views:@{@"image":self.imageView,@"title":self.titleLabel}]];

//
//        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
//        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image(==imageW)]|" options:0 metrics:@{@"imageW":@40}views:@{@"image":self.imageView}]];
//
//        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image(==imageH)][title]|" options:0 metrics:@{@"imageH":@22} views:@{@"title":self.titleLabel,@"image":self.imageView}]];
        
    } else if (self.contentMode == CMPageTitleCellContentMode_ImageBottom) {
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image]|" options:0 metrics:@{}views:@{@"image":self.imageView}]];
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title][image]|" options:0 metrics:@{}views:@{@"title":self.titleLabel,@"image":self.imageView}]];
        
    }else if (self.contentMode == CMPageTitleCellContentMode_ImageLeft) {
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image][title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel,@"image":self.imageView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image]|" options:0 metrics:@{}views:@{@"image":self.imageView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
        
        
        
    }else if (self.contentMode == CMPageTitleCellContentMode_ImageRigth) {
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title][image]|" options:0 metrics:@{}views:@{@"title":self.titleLabel,@"image":self.imageView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image]|" options:0 metrics:@{}views:@{@"image":self.imageView}]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
        
    }
    
    
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]|" options:0 metrics:@{}views:@{@"title":self.titleLabel}]];
}



- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (self.block) {
        self.block(selected);
    }
    
    self.titleLabel.backgroundColor = RandomColor;
    
    self.titleLabel.textColor = selected ? UIColor.redColor : UIColor.blackColor ;
    self.titleLabel.cm_fillColor =  UIColor.redColor;
    self.titleLabel.cm_progress =  0;
    
}




@end
