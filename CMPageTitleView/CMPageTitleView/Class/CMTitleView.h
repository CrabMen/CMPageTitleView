//
//  CMTitleView.h
//  CMDisplayTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMTitleViewDelegate <NSObject>

@required
/**
 当CMTitleView 中标题被点击会调用该代理方法

 @param index 当前点击的标题的index
 @param repeat 是否是重复点击
 */
- (void)cm_pageTitleContentViewClickWithLastIndex:(NSUInteger)LastIndex Index:(NSUInteger)index Repeat:(BOOL)repeat;

@end


@interface CMTitleView : UIView

/**选中的标题*/
@property (nonatomic,assign) NSInteger cm_selectedIndex;


/**点击daili*/
@property (nonatomic,weak) id <CMTitleViewDelegate> cm_delegate;


/**
 初始化方法

 @param config 配置对象
 @return CMTitleView对象
 */
- (instancetype)initWithConfig:(CMPageTitleConfig *)config;


/**
 
 根据CMPageView对象的滚动情况，
 调整CMTitleView对象的滚动情况
 
 @param progress 0~1 推拽比例
 @param leftIndex 左边的下标
 @param rightIndex 右边的下标
 */
- (void)cm_pageTitleViewDidScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex;


/**
 根据CMPageView对象的滚动情况，
 调整CMTitleView对象的滚动情况
 @param scrollView  CMPageView对象
 */
- (void)cm_pageTitleContentViewAdjustPosition:(UIScrollView *)scrollView;


- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress FromIndex:(NSUInteger)fromIndex ToIndex:(NSUInteger)toIndex;



@end




@interface CMDisplayTitleLabel : UILabel

@property (nonatomic,assign) CGFloat cm_progress;
@property (nonatomic,strong) UIColor *cm_fillColor;

@end

@protocol CMPageTitleDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemImageViewAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface CMPageTitleFlowLayout : UICollectionViewFlowLayout


@end



typedef NS_ENUM(NSUInteger,CMTitleCellContentMode) {
   
    CMTitleCellContentMode_ImageTop,
    
    CMTitleCellContentMode_ImageLeft,
    
    CMTitleCellContentMode_ImageBottom,
    
    CMTitleCellContentMode_ImageRigth,
    
};


@interface CMPageTitleBgCell : UICollectionViewCell

@property(nonatomic,weak) UIImageView *imageView;

@end

@interface CMTitleCell : UICollectionViewCell

@property(nonatomic,strong) NSString *text;

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,weak) UIStackView *container;

@property(nonatomic,weak) CMDisplayTitleLabel *titleLabel;

@property(nonatomic,weak) UIImageView *imageView;

@property (nonatomic,assign) CGFloat spacing;

@property(nonatomic,assign) CGSize imgViewSize;

@property(nonatomic,assign) CMPageTitleContentMode cm_contentMode;


- (void)cm_cellSetSelectedCompletion:(void(^)(BOOL selected))completion;


@end
