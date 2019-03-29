//
//  CMPageTitleConfig.h
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMPageTitleViewMacro.h"
#import "UIColor+CMCommon.h"
#import "NSString+CMCommon.h"
#import "UIView+CMCommon.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CMTitleColorGradientStyle) {
    /**rgb颜色渐变*/
    CMTitleColorGradientStyle_RGB = 0,
    /**填充色颜色渐变*/
    CMTitleColorGradientStyle_Fill = 1
};

@interface CMPageTitleConfig : NSObject

/**
 标题字体
 */
@property (nonatomic,strong) UIFont *cm_font;

/**
 标题滚动视图背景颜色
 */
@property (nonatomic,strong) UIColor *cm_backgroundColor;

/**
 标题正常颜色
 默认为黑色
 */
@property (nonatomic,strong) UIColor *cm_normalColor;

/**
 标题选中颜色
 默认为红色
 */
@property (nonatomic,strong) UIColor *cm_selectedColor;

/**
 标题高度
 默认为44
 */
@property (nonatomic,assign) CGFloat cm_titleHeight;


/**颜色渐变样式
 默认为 CMTitleColorGradientStyle_RGB
 */
@property (nonatomic,assign) CMTitleColorGradientStyle cm_gradientStyle;


/**标题之间的间隔*/
@property (nonatomic,assign) CGFloat cm_titleMargin;

/**默认选择的index*/
@property (nonatomic,assign,getter=cm_selectedIndex) NSInteger cm_defaultIndex;


/**标题栏下方分割线的颜色*/
@property (nonatomic,strong) UIColor *cm_seperaterLineColor;

/**标题分割线的高度*/
@property (nonatomic,assign) CGFloat cm_seperateLineHeight;

/**标题数组
 默认为cm_childControllers 的 title
 */
@property (nonatomic,copy) NSArray *cm_titles;

/**子视图控制器数组*/
@property (nonatomic,copy) NSArray *cm_childControllers;



#pragma mark --- 下划线效果

/**是否显示下划线*/
@property (nonatomic,assign) BOOL cm_showUnderLine;



/**
 下划线视图是否圆角
 默认为NO
 */
@property (nonatomic,assign) BOOL cm_underLineBorder;


/**下划线高度*/
@property (nonatomic,assign) CGFloat cm_underLineHeight;

/**
下划线宽度
默认跟随文字宽度
 */
@property (nonatomic,assign) CGFloat cm_underLineW;


/**下划线颜色
 默认跟随标题的选中颜色
 */
@property (nonatomic,strong) UIColor *cm_underLineColor;




#pragma mark --- 遮罩效果

/**是否显示遮罩*/
@property (nonatomic,assign) BOOL cm_showCover;

/**遮罩颜色*/
@property (nonatomic,strong) UIColor *cm_coverColor;

/**遮罩圆角半径
 默认为 cover高度的一半
 */
@property (nonatomic,assign) CGFloat cm_coverRadius;


#pragma mark --- 缩放效果

/**是否显示字体缩放*/
@property (nonatomic,assign) BOOL cm_showScale;


/**标题的缩放等级*/
@property (nonatomic,assign) CGFloat cm_scale;


/**标题的偏移量*/
@property (nonatomic,assign) CGFloat lastOffsetX;


/**标题宽度*/
@property (nonatomic,strong,readonly) NSArray *cm_titleWidths;

/**所有标题的总宽度*/
@property (nonatomic,assign,readonly) CGFloat cm_totalWidth;


@end

NS_ASSUME_NONNULL_END
