//
//  CMPageContentView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"


@class CMPageContentView;
@protocol CMPageContentViewDelegate <NSObject>


/**
结束拖拽时，即手指离开屏幕时 会调用该代理方法
 @param scrollView 当前操作的scrollView
 @param decelerate 是否是减速
 */
- (void)cm_pageContentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


/**
 减速停止，即结束滚动时 会调用该代理方法

 @param index 结束滚动时，当前的index
 */
- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index;


/**
 滚动时调用该代理方法

 @param scrollView 当前滚动视图
 */
- (void)cm_pageContentViewDidScroll:(UIScrollView *)scrollView;


- (void)cm_pageContentViewDidScrollProgress:(CGFloat)progress OriginalIndex:(NSUInteger)originalIndex TargetIndex:(NSUInteger)targetIndex;

@end


@interface CMPageContentView : UICollectionView

/**delegate*/
@property (nonatomic,weak) id <CMPageContentViewDelegate> cm_delegate;



/**
 初始化方法

 @param frame frame
 @param layout layout
 @param config config 用于配置视图
 @return CMPageContentView对象
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout Config:(CMPageTitleConfig *)config;


@end

