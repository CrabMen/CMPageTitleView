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

- (void)cm_pageContentViewDidEndDeceleratingWithIndex:(NSInteger)index;

- (void)cm_pageContentViewDidScroll:(UIScrollView *)scrollView;


@end


@interface CMPageContentView : UICollectionView

/**delegate*/
@property (nonatomic,weak) id <CMPageContentViewDelegate> cm_delegate;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout Config:(CMPageTitleConfig *)config;


@end

