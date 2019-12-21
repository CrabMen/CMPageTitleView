//
//  CMPageTitleConfig.h
//  CMPageTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+CMCommon.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CMTitleColorGradientStyle) {
    
    /**颜色无渐变*/
    CMTitleColorGradientStyle_None = 0,
    
    /**rgb颜色渐变*/
    CMTitleColorGradientStyle_RGB = 1,
    
    /**填充色颜色渐变*/
    CMTitleColorGradientStyle_Fill = 2,
    
};

typedef NS_OPTIONS(NSUInteger,CMPageTitleSwitchModeOptions) {
    
    /**字体放大*/
    CMPageTitleSwitchMode_Scale = 1 << 0,
    
    /**下划线样式*/
    CMPageTitleSwitchMode_Underline = 1 << 1,
    
    /**遮罩样式*/
    CMPageTitleSwitchMode_Cover = 1 << 2,
    
    /**滑动切换时延迟，配合其他样式使用*/
    CMPageTitleSwitchMode_Delay = 1 << 3
    

};

typedef NS_OPTIONS(NSUInteger, CMPageTitleAdditionalModeOptions) {
    
    /**标题栏下方的分割线*/
    CMPageTitleAdditionalMode_Seperateline = 1 << 0,
    
    /**标题文字之间的分割线*/
    CMPageTitleAdditionalMode_Splitter = 1 << 1
    
    
};

typedef NS_ENUM(NSUInteger,CMPageTitleContentMode) {
    /**左右边距与标题间距一致*/
    CMPageTitleContentMode_Center,
    
    /**左右边距等于标题间距的一半*/
    CMPageTitleContentMode_SpaceAround,
    
    /**左对齐*/
    CMPageTitleContentMode_Left,
    
    /**右对齐*/
    CMPageTitleContentMode_Right
    
};

typedef NS_ENUM(NSUInteger,CMPageTitleScaleGradientContentMode) {
    /**居中*/
    CMPageTitleScaleGradientContentMode_Center,
    
    /**上对其*/
    CMPageTitleScaleGradientContentMode_Top,
    
    /**下对齐*/
    CMPageTitleScaleGradientContentMode_Bottom,
    
};

@interface CMPageTitleConfig : NSObject
/**
 颜色渐变样式
 默认为 CMTitleColorGradientStyle_RGB
 */
@property (nonatomic,assign) CMTitleColorGradientStyle cm_gradientStyle;

/**
 标题切换样式
 默认为：0，无任何效果
 */
@property (nonatomic,assign) CMPageTitleSwitchModeOptions cm_switchMode;

/**
 标题栏附加样式
 默认为：0 无任何附加效果效果
 */
@property (nonatomic,assign) CMPageTitleAdditionalModeOptions cm_additionalMode;

/**
 对齐方式
默认值：CMPageTitleContentMode_Center
 */
@property (nonatomic,assign) CMPageTitleContentMode cm_contentMode;

/**
 垂直方向上的对齐方式
 只有属性cm_switchMode包含CMPageTitleSwitchMode_Scale下有效果
 默认值：CMPageTitleVerticalContentMode_Center
 */
@property (nonatomic,assign) CMPageTitleScaleGradientContentMode cm_scaleGradientContentMode;


/**子视图控制器数组*/
@property (nonatomic,copy) NSArray <UIViewController *>*cm_childControllers;


/**标题数组
 默认为cm_childControllers 的 title
 */
@property (nonatomic,copy) NSArray <NSString *>*cm_titles;

/**
 标题正常字体
 默认字体大小：[UIFont systemFontOfSize:15]
 */
@property (nonatomic,strong) UIFont *cm_font;

/**
 标题选中字体
 默认选中字体大小：cm_font的1.15倍
 */
@property (nonatomic,strong) UIFont *cm_selectedFont;

/**
 视图的背景色
 默认颜色：[UIColor whiteColor]
 */
@property (nonatomic,strong) UIColor *cm_backgroundColor;

/**
 标题正常颜色
 默认颜色：[UIColor blackColor]
 */
@property (nonatomic,strong) UIColor *cm_normalColor;

/**
 标题选中颜色
 默认颜色：[UIColor redColor]
 */
@property (nonatomic,strong) UIColor *cm_selectedColor;

/**
 标题高度
 默认高度：44
 */
@property (nonatomic,assign) CGFloat cm_titleHeight;

/**
 是否支持侧滑
 默认值：YES
 */
@property (nonatomic,assign) BOOL cm_slideGestureEnable;

/**
 标题之间的间隔
 */
@property (nonatomic,assign) CGFloat cm_titleMargin;

/**
 最小的标题间距
 默认值为 20
 */
@property (nonatomic,assign) CGFloat cm_minTitleMargin;

/**
 默认选择的index
 默认选择第0个
 */
@property (nonatomic,assign,getter=cm_selectedIndex) NSInteger cm_defaultIndex;

/**
 标题栏下方分割线的颜色
 默认颜色：[UIColor grayColor]
 */
@property (nonatomic,strong) UIColor *cm_seperaterLineColor;

/**
 标题分割线的高度
 默认值：1px
 */
@property (nonatomic,assign) CGFloat cm_seperateLineHeight;

/**
 标题之间的分割线颜色
 默认为：[UIColor lightGrayColor]
 */
@property (nonatomic,strong) UIColor *cm_splitterColor;

/**
 标题之间的分割线size
 默认宽度：1px
 默认高度：标题栏高度的一半
 */
@property (nonatomic,assign) CGSize cm_splitterSize;

/**
 下划线和遮罩，在点击标题时，动画的时间间隔
 默认值为：0.25
 取值范围 0.25~0.8
 (超出范围会使用默认值)
 */
@property (nonatomic,assign) CGFloat cm_animationDruction;


/**右侧视图*/
@property (nonatomic,strong) UIView *cm_rightView;

/**
 父视图控制器
 */
@property (nonatomic,weak,readonly) UIViewController *cm_parentController;


#pragma mark --- 缩放效果

/**
 标题的缩放等级 默认为 1.15
 （若觉得该属性不方便，可以使用cm_selectedFont配合cm_font属性进行设置）
 */
@property (nonatomic,assign) CGFloat cm_scale;

/**
 标题宽度
 */
@property (nonatomic,strong,readonly)  NSArray * _Nonnull cm_titleWidths;

/**
 标题的总宽度 + 左右边距 + 所有的标题最小间距
 */
@property (nonatomic,assign,readonly) CGFloat cm_minContentWidth;


/**
 所有标题的总宽度
 */
@property (nonatomic,assign,readonly) CGFloat cm_titlesWidth;

#pragma mark --- 下划线效果

/**
 下划线视图是否圆角
 默认值:NO
 */
@property (nonatomic,assign) BOOL cm_underlineBorder;


/**
 下划线高度
 默认值：2
 */
@property (nonatomic,assign) CGFloat cm_underlineHeight;

/**
 下划线宽度
 默认跟随文字宽度
 设置该属性后下划线会固定使用该宽度
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



/**
 是否延长
 默认值：NO
 具体效果可以看github效果展示
 */
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

//宏定义单利的定义
+ (instancetype)defaultConfig;
+(instancetype) alloc __attribute__((unavailable("please call class method +(instancetype)defaultConfig instead")));
+(instancetype) new __attribute__((unavailable("please call class method +(instancetype)defaultConfig instead")));
-(instancetype) copy __attribute__((unavailable("please call class method +(instancetype)defaultConfig instead")));
-(instancetype) mutableCopy __attribute__((unavailable("please call class method +(instancetype)defaultConfig instead")));

@end

NS_ASSUME_NONNULL_END
