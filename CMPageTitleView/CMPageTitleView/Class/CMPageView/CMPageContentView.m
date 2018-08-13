//
//  CMPageContentView.m
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CMPageContentView.h"
#import "CMFlowLayout.h"
#import "UIView+Frame.h"
@interface CMPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>


/**底部视图*/
@property (nonatomic,strong) UICollectionView *containerView;

/**自视图控制器数组*/
@property (nonatomic,strong) NSArray *childControllers;

/**父视图*/
@property (nonatomic,strong) UIViewController *parentController;


/**是否动画*/
@property (nonatomic,assign) BOOL isAniming;


@end

@implementation CMPageContentView

- (UICollectionView *)containerView {
    if (!_containerView) {
        CMFlowLayout *layout = [[CMFlowLayout alloc]init];
        
        _containerView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        [_containerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell" ];
        _containerView.pagingEnabled = YES;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.bounces = NO;
        _containerView.delegate = self;
        _containerView.dataSource = self;
        
    }
    return _containerView;
}


- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)childControllers ParentController:(UIViewController *)parentController {
    
    if (self = [super initWithFrame:frame]) {
        self.childControllers = childControllers;
        self.parentController = parentController;
        
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    
    
    [self addSubview:self.containerView];
    
    
}


- (void)setContentOffset:(CGPoint)offset {
    
    [self.containerView setContentOffset:offset];
    
}


#pragma mark --- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.childControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加控制器
    UIViewController *VC = self.childControllers[indexPath.row];
    VC.view.frame = CGRectMake(0, 0, self.containerView.width, self.containerView.height);
    
    [cell.contentView addSubview:VC.view];
    
    return cell;
    
}


#pragma --- UIScrollViewDelegate

/**
 scrollView减速完成
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger offSetInx = offSetX;
    NSInteger screenWInt = CMSCREEN_W;
    NSInteger extre = offSetInx % screenWInt;
    
    if (extre > CMSCREEN_W*0.5) {
        //往右边移动
        offSetX = offSetX + (CMSCREEN_W - extre);
        _isAniming = YES;
        [self.containerView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    } else if (extre < CMSCREEN_W * 0.5 && extre > 0){
        _isAniming = YES;
        offSetX = offSetX - extre;
        [self.containerView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    }
    
    //获取角标
    NSInteger i = offSetX / CMSCREEN_W;
    
    //选中标题
    [self.delegate contentViewDidEndDecelerating:i];
   
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _isAniming = NO;
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isAniming || self.childControllers.count == 0) return;
    
    
    if (self.delegate) {
        [self.delegate contentViewDidScroll:scrollView];
    }
    

    
    
}





@end
