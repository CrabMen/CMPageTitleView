//
//  CMPageContentView.m
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageContentView.h"
@interface CMPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**是否动画*/
@property (nonatomic,assign) BOOL isAniming;
/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *config;

@end

@implementation CMPageContentView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout Config:(CMPageTitleConfig *)config{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.config = config;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CMPageContentCell class] forCellWithReuseIdentifier:NSStringFromClass(CMPageContentCell.class)];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.scrollEnabled = self.config.cm_slideGestureEnable;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        if (self.cm_navigationController && self.config.cm_slideGestureEnable) {
            [self.panGestureRecognizer requireGestureRecognizerToFail:self.cm_navigationController.interactivePopGestureRecognizer];
        }
    }
    return self;
}

#pragma mark --- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.config.cm_childControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMPageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CMPageContentCell.class) forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.cm_contentView = [self.config.cm_childControllers[indexPath.row] view];
    [self.config.cm_parentController addChildViewController:self.config.cm_childControllers[indexPath.row]];
    [self.config.cm_childControllers[indexPath.row] didMoveToParentViewController:self.config.cm_parentController];
    return cell;
}


#pragma --- UIScrollViewDelegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self.cm_delegate) {
        [self.cm_delegate cm_pageContentViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

/**
 scrollView减速完成
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger offSetInx = offSetX;
    NSInteger screenWInt = self.cm_width;
    NSInteger extre = offSetInx % screenWInt;
    
    if (extre > self.cm_width*0.5) {
        //往右边移动
        offSetX = offSetX + (self.cm_width - extre);
        _isAniming = YES;
        [self setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    } else if (extre < self.cm_width * 0.5 && extre > 0){
        _isAniming = YES;
        offSetX = offSetX - extre;
        [self setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    }
    
    NSInteger index = offSetX / self.cm_width;
    
    if (self.cm_delegate) {
        
        [self.cm_delegate cm_pageContentViewDidEndDeceleratingWithIndex:index];
        
    }
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    _isAniming = NO;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isAniming || self.config.cm_childControllers.count == 0) return;
    
    if (self.cm_delegate) {
        
        CGFloat progress = scrollView.contentOffset.x / self.cm_width - floor(scrollView.contentOffset.x / self.cm_width);
        NSUInteger leftIndex = floor(scrollView.contentOffset.x / self.cm_width);
        NSUInteger rightIndex = leftIndex + 1;
        [self.cm_delegate cm_pageContentViewDidScrollProgress:progress LeftIndex:leftIndex RightIndex:rightIndex];
    }
}

@end




@implementation CMFlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}
@end

@implementation CMPageContentCell

- (void)setCm_contentView:(UIView *)cm_contentView {
    
    _cm_contentView = cm_contentView;
    _cm_contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_cm_contentView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:@{} views:@{@"view":_cm_contentView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:@{} views:@{@"view":_cm_contentView}]];
}

@end
