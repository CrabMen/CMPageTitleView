//
//  CMPageTitleConfig.h
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+CMCommon.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger,CMPageTitleSwitchModeOptions) {
    
    /**字体放大*/
    CMPageTitleSwitchMode_Scale = 1 << 0,
    
    /**下划线样式*/
    CMPageTitleSwitchMode_Underline = 1 << 1,
    
    /**遮罩样式*/
    CMPageTitleSwitchMode_Cover = 1 << 2

};

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


/**标题切换样式*/
@property (nonatomic,assign) CMPageTitleSwitchModeOptions cm_switchMode;


/**
 标题之间的间隔
 */
@property (nonatomic,assign) CGFloat cm_titleMargin;

/**
 默认选择的index
 */
@property (nonatomic,assign,getter=cm_selectedIndex) NSInteger cm_defaultIndex;


/**
 标题栏下方分割线的颜色
 */
@property (nonatomic,strong) UIColor *cm_seperaterLineColor;

/**
 标题分割线的高度
 */
@property (nonatomic,assign) CGFloat cm_seperateLineHeight;

/**标题数组
 默认为cm_childControllers 的 title
 */
@property (nonatomic,copy) NSArray *cm_titles;

/**子视图控制器数组*/
@property (nonatomic,copy) NSArray *cm_childControllers;



#pragma mark --- 下划线效果

/**
 下划线视图是否圆角
 默认为NO
 */
@property (nonatomic,assign) BOOL cm_underlineBorder;


/**
 下划线高度
 */
@property (nonatomic,assign) CGFloat cm_underlineHeight;

/**
下划线宽度
默认跟随文字宽度
 */
@property (nonatomic,assign) CGFloat cm_underlineWidth;

/**
 下划线跟随文字宽度 * 比例
 比例范围 0 ~ 1.3
 超出 1.3 按 1.0 处理
 */
@property (nonatomic,assign) CGFloat cm_underlineWidthScale;


/**
 下划线颜色
 默认跟随标题的选中颜色
 */
@property (nonatomic,strong) UIColor *cm_underlineColor;



/**是否延长*/
@property (nonatomic,assign) BOOL cm_underlineStretch;




#pragma mark --- 遮罩效果

/**
 遮罩颜色
 */
@property (nonatomic,strong) UIColor *cm_coverColor;

/**
 遮罩圆角半径
 默认为 cover高度的一半
 */
@property (nonatomic,assign) CGFloat cm_coverRadius;


/**
 遮罩固定宽度 未做最大最小限制
 请根据实际情况妥善设置
 */
@property (nonatomic,assign) CGFloat cm_coverWidth;

/**
 遮罩垂直方向边距 未做最大最小限制
 请根据实际情况妥善设置
 */
@property (nonatomic,assign) CGFloat cm_coverVerticalMargin;

/**
 遮罩水平方向边距 未做最大最小限制
 请根据实际情况妥善设置
 */
@property (nonatomic,assign) CGFloat cm_coverHorizontalMargin;


#pragma mark --- 缩放效果

/**
 标题的缩放等级
 */
@property (nonatomic,assign) CGFloat cm_scale;


/**
 标题的偏移量
 */
@property (nonatomic,assign) CGFloat lastOffsetX;


/**
 标题宽度
 */
@property (nonatomic,strong,readonly) NSArray *cm_titleWidths;

/**
 所有标题的总宽度
 */
@property (nonatomic,assign,readonly) CGFloat cm_totalWidth;







/**
 获得某个颜色的rgba的值
 
 @param color 颜色对象
 @return 返回rgba颜色值数组
 */
CG_EXTERN NSArray* CMColorGetRGBA(UIColor *color);

/**
 获得某个颜色的r值
 
 @param color 颜色对象
 @return 返回r的值
 */
CG_EXTERN CGFloat CMColorGetR(UIColor *color);

/**
 获得某个颜色的g值
 
 @param color 颜色对象
 @return 返回g的值
 */
CG_EXTERN CGFloat CMColorGetG(UIColor *color);

/**
 获得某个颜色的b值
 
 @param color 颜色对象
 @return 返回b的值
 */
CG_EXTERN CGFloat CMColorGetB(UIColor *color);

/**
 获得某个颜色的a值
 
 @param color 颜色对象
 @return 返回a的值
 */
CG_EXTERN CGFloat CMColorGetA(UIColor *color);

/**
 获得指定font的字符串宽度
 
 @param string 目标字符串
 @param font 目标字符串对应的font
 @return 返回该字符串的宽度
 */
CG_EXTERN CGFloat CMStringWidth(NSString *string ,UIFont *font);




@end

NS_ASSUME_NONNULL_END
