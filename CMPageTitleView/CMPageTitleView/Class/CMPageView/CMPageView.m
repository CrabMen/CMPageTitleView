//
//  CMPageView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageView.h"
#import "CMPageTitleView.h"
#import "CMPageContentView.h"
#import "CMFlowLayout.h"
@interface CMPageView() <CMPageTitleViewDelegate,CMPageContentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/**标题视图*/
@property (nonatomic,strong) CMPageTitleView *titleView;

/**内容视图*/
@property (nonatomic,strong) CMPageContentView *contentView;


/**标题数组*/
@property (nonatomic,strong) NSArray *titles;
/**子视图控制器*/
@property (nonatomic,strong) NSArray *childControllers;
/**父视图控制器*/
@property (nonatomic,strong) UIViewController *parentController;


@end

@implementation CMPageView

- (CMPageTitleView *)titleView {
    
    if (!_titleView) {

        _titleView = [[CMPageTitleView alloc] initWithConfig:self.cm_config];
        _titleView.delegate = self;
    }
    return _titleView;
}


- (CMPageContentView *)contentView {
    if (!_contentView) {
        CMFlowLayout *layout = [CMFlowLayout new];
        CGRect rect = CGRectMake(0, self.cm_config.cm_titleHeight, self.cm_width, self.cm_height - self.cm_config.cm_titleHeight - self.cm_config.cm_seperateLineHeight);
//        layout.itemSize = rect.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentView = [[CMPageContentView alloc] initWithFrame:rect collectionViewLayout:layout];
        _contentView.cm_config = self.cm_config;
        [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell" ];
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.delegate = self;
        _contentView.dataSource = self;
    }
    return _contentView;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self initSubViews];
  
   
}

- (void)initSubViews {
   
    self.backgroundColor = self.cm_config.cm_seperaterLineColor;
    
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    
    
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.cm_config.cm_childControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    //移除之前的子控件
    // [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加控制器
    //    UIViewController *VC = self.config.cm_childControllers[indexPath.row];
    //    VC.view.frame = CGRectMake(0, 0, self.cm_width, self.cm_height);
    //
    //    [cell.contentView addSubview:VC.view];
    UILabel *label = [UILabel new];
    label.text = [self.cm_config.cm_childControllers[indexPath.row] title];
    [label sizeToFit];
    label.textColor = [UIColor blackColor];
    
    [cell.contentView addSubview:label];
    
    return cell;
    
    
}


#pragma mark --- CMPageTitleViewDelegate


- (void)titleDidClick:(NSUInteger)index {
    
    NSLog(@"当前点击的是第%ld个",index);
    
    [self.contentView setContentOffset:CGPointMake(index * CMSCREEN_W , 0)];
    
}

#pragma mark --- CMPageContentViewDelegate

- (void)contentViewDidEndDecelerating:(NSUInteger)index {
    
    
//    [self.titleView selectLabelWithIndex:index];
    
}

-(void)contentViewDidScroll:(UIScrollView *)scrollView {
//
//    //获取偏移量
//    CGFloat offSetX = scrollView.contentOffset.x;
//
//    //获取左边角标
//    NSInteger leftIndex = offSetX / CMSCREEN_W;
//
//    //左边按钮
//    UILabel *leftLabel = self.titleView.titleLabels[leftIndex];
//
//    //右边角标
//    NSInteger rightIndex = leftIndex + 1;
//    //右边角标
//    UILabel *rightLabel = nil;
//
//    if (rightIndex < self.titleView.titleLabels.count) {
//        rightLabel = self.titleView.titleLabels[rightIndex];
//    }
//
//
//    //字体放大
//    [self.titleView setUpTitleScaleWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
//
//    //设置遮罩偏移
//    [self.titleView setUpCoverOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
//
//    //设置标题渐变
//    [self.titleView setUpTitleColorGradientWithOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
//
////    if (_isDelayScroll == NO) { // 延迟滚动，不需要移动下标
//
//        [self.titleView setUpUnderLineOffset:offSetX rightLabel:rightLabel leftLabel:leftLabel];
////    }
//    //记录上一次的偏移量
////    _lastOffsetX = offSetX;
//
//
//
//  //  [self.titleView selectLabelWithIndex:offSetX /CMSCREEN_W ];
//
//    self.titleView.lastOffsetX = scrollView.contentOffset.x;
    
}



@end
