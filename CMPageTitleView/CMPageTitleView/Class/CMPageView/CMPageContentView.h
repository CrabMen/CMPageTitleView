//
//  CMPageContentView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageTitleConfig.h"
@protocol CMPageContentViewDelegate <NSObject>

- (void)contentViewDidScroll:(UIScrollView *)scrollView;

- (void)contentViewDidEndDecelerating:(NSUInteger )index;
@end



@interface CMPageContentView : UICollectionView

/**配置*/
@property (nonatomic,strong) CMPageTitleConfig *cm_config;
/**代理*/
//@property (nonatomic,assign) id <CMPageContentViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout Config:(CMPageTitleConfig *)config;

- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)childControllers ParentController:(UIViewController *)parentController;

- (void)setContentOffset:(CGPoint)offset;


@end
