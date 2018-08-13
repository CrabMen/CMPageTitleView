//
//  CMPageTitleView.h
//  CMDisplayTitleView
//
//  Created by CrabMan on 2018/1/15.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMPageTitleViewDelegate <NSObject>

- (void)titleDidClick:(NSUInteger)index;


@end


typedef NS_ENUM(NSUInteger,CMTitleColorGradientStyle) {
    /**rgb颜色渐变*/
    CMTitleColorGradientStyleRGB = 0,
    /**填充色颜色渐变*/
    CMTitleColorGradientStyleFill = 1
};


@interface CMPageTitleView : UIView

/**颜色渐变样式*/
@property (nonatomic,assign) CMTitleColorGradientStyle titleColorGradientStyle;

/**点击daili*/
@property (nonatomic,weak) id <CMPageTitleViewDelegate> delegate;

/**标题数组*/
@property (nonatomic,strong) NSMutableArray *titleLabels;

/**
 标题滚动视图背景颜色
 */
@property (nonatomic,strong) UIColor *pageTitleColor;

/**
 标题高度
 */
@property (nonatomic,assign) CGFloat titleHeight;


/**
 标题正常颜色
 */
@property (nonatomic,strong) UIColor *normalColor;

/**
 标题选中颜色
 */
@property (nonatomic,strong) UIColor *selectedColor;

/**
 标题字体
 */
@property (nonatomic,strong) UIFont *titleFont;


/**是否显示下划线*/
@property (nonatomic,assign) BOOL isShowUnderLine;


/**下划线高度*/
@property (nonatomic,assign) CGFloat underLineH;

/**下划线宽度*/
@property (nonatomic,assign) CGFloat cm_underLineW;


/**下划线颜色*/
@property (nonatomic,strong) UIColor *underLineColor;

/**是否显示遮罩*/
@property (nonatomic,assign) BOOL isShowTitleCover;


/**遮罩颜色*/
@property (nonatomic,strong) UIColor *titleCoverColor;


/**遮罩圆角半径*/
@property (nonatomic,assign) CGFloat titleCoverRadius;


/**是否显示字体缩放*/
@property (nonatomic,assign) BOOL isShowTitleScale;


/**标题的缩放等级*/
@property (nonatomic,assign) CGFloat titleScale;


/**标题的偏移量*/
@property (nonatomic,assign) CGFloat lastOffsetX;


/**标题之间的间隔*/
@property (nonatomic,assign) CGFloat cm_titleMargin;

/**默认选择的index*/
@property (nonatomic,assign,getter=cm_selectedIndex) NSInteger cm_defaultIndex;


/**标题栏下方分割线的颜色*/
@property (nonatomic,strong) UIColor *cm_seperaterLineColor;

/**标题分割线的高度*/
@property (nonatomic,assign) CGFloat cm_seperateLineH;

- (instancetype)initWithSize:(CGSize)size Titles:(NSArray *)titles;

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ;

- (void)selectLabelWithIndex:(NSUInteger)index;

- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel ;
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel ;
- (void)setUpCoverOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel ;
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel ;


@end
