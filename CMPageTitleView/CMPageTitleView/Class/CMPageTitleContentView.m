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


/**
 让选中的按钮居中显示
 */
- (void)modifyCenterWithIndexPath:(NSIndexPath *)indexPath{
    
    
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
    
    [self modifyCenterWithIndexPath:indexPath];
    
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
    
}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//  
//    
//    return attribute;
//}




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
