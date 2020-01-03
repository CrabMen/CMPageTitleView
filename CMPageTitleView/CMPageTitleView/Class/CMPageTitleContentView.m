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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.cm_width, self.cm_height) collectionViewLayout:layout];
       [_collectionView registerClass:CMPageTitleCell.class forCellWithReuseIdentifier:NSStringFromClass(CMPageTitleCell.class)];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

    }
    return _collectionView;
}


- (void)setCm_selectedIndex:(NSInteger)cm_selectedIndex {
    
    _cm_selectedIndex = cm_selectedIndex;
    
    
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
    
}

- (void)initSubViews {

}

- (void)modifyContentInset {
 
}


- (void)initContentSize{
    
    
    
    [self layoutIfNeeded];
    
}



#pragma mark --- UICollectionViewDelegate
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
    
}






- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
//    [self modifyTitleScaleWithScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
//
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



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@"偏移量：%@",NSStringFromCGPoint(proposedContentOffset));
    
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    
    CGRect visibleRect = CGRectZero;
    visibleRect.size = self.collectionView.bounds.size;
    visibleRect.origin = proposedContentOffset;
    
    //获得所有的attribute数组
    NSArray *itemAttrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat minMargin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in itemAttrs) {
        CGFloat deltaMargin = attr.center.x - screenCenterX;
      
        if (fabs(deltaMargin) < fabs(minMargin)) {
            minMargin = deltaMargin;
        }
        
    }
    
    return CGPointMake(proposedContentOffset.x +minMargin, proposedContentOffset.y);

}


@end



@interface CMPageTitleCell ()

@end

@implementation CMPageTitleCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
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

@end
