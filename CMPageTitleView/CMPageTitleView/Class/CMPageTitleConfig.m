//
//  CMPageTitlem
//  CMPageTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//
//#warning TODO：优化getter方法


#import "CMPageTitleConfig.h"
#import "CMPageTitleViewMacro.h"
@interface CMPageTitleConfig ()

/**视图宽度*/
@property (nonatomic,strong) NSNumber *cm_pageTitleViewWidth;


/**cm_slideGestureEnable对应的nsnumber类型*/
@property (nonatomic,strong) NSNumber *cm_slideGestureEnableNumber;

/**cm_seperateLineHeight对应的nsnumber类型*/
@property (nonatomic,strong) NSNumber *cm_seperateLineHeightNumber;



@end

@implementation CMPageTitleConfig

@synthesize cm_slideGestureEnable = _cm_slideGestureEnable;
@synthesize cm_seperateLineHeight = _cm_seperateLineHeight;

#pragma mark -- setter

- (void)setCm_slideGestureEnable:(BOOL)cm_slideGestureEnable {
    
    _cm_slideGestureEnable = cm_slideGestureEnable;
    
    self.cm_slideGestureEnableNumber = @(cm_slideGestureEnable);
    
}

- (void)setCm_seperateLineHeight:(CGFloat)cm_seperateLineHeight {
    
    _cm_seperateLineHeight = cm_seperateLineHeight;
    
    self.cm_seperateLineHeightNumber = @(cm_seperateLineHeight);
    
    
}

- (void)setCm_selectedFont:(UIFont *)cm_selectedFont {
    
    _cm_selectedFont = cm_selectedFont;
    
    self.cm_scale = self.cm_font.pointSize ? cm_selectedFont.pointSize / self.cm_font.pointSize : self.cm_scale;
    
    
}

- (void)setCm_pageTitleViewWidth:(NSNumber *)cm_pageTitleViewWidth {
    
    _cm_pageTitleViewWidth = cm_pageTitleViewWidth;
    
    if (self.cm_minContentWidth > _cm_pageTitleViewWidth.floatValue) {
        //如果理论最小宽度已经大于视图宽度，对齐样式自动变成居中样式
        if (self.cm_contentMode == CMPageTitleContentMode_Left || self.cm_contentMode == CMPageTitleContentMode_Right) {
            self.cm_contentMode = CMPageTitleContentMode_Center;
            
        }
    }
    
}

- (void)setCm_underlineWidthScale:(CGFloat)cm_underlineWidthScale {
    _cm_underlineWidthScale = cm_underlineWidthScale;
    
    _cm_underlineWidthScale = fabs(_cm_underlineWidthScale) > 1.3 || _cm_underlineWidthScale == 0 ? 1 :fabs(_cm_underlineWidthScale) ;
    
}

- (void)setCm_defaultIndex:(NSInteger)cm_defaultIndex {
    _cm_defaultIndex = cm_defaultIndex;
    
    _cm_defaultIndex = _cm_defaultIndex < self.cm_titles.count ? _cm_defaultIndex : 0;
    
    
}

#pragma mark -- getter

- (CGFloat)cm_seperateLineHeight {
    
    [self cm_seperateLineHeightNumber];
    
    return _cm_seperateLineHeight;
    
}

- (NSNumber *)cm_seperateLineHeightNumber {
    
    _cm_seperateLineHeight = _cm_seperateLineHeightNumber ? [_cm_seperateLineHeightNumber floatValue] : 1.0/[UIScreen mainScreen].scale;
    
    return _cm_seperateLineHeightNumber;
}

- (BOOL)cm_slideGestureEnable {
    [self cm_slideGestureEnableNumber];
    
    return _cm_slideGestureEnable;
}

- (NSNumber *)cm_slideGestureEnableNumber {
    
    _cm_slideGestureEnable = _cm_slideGestureEnableNumber ? [_cm_slideGestureEnableNumber boolValue] : YES;
    
    return _cm_slideGestureEnableNumber;
    
}

- (NSArray *)cm_titles {
    
    CMPageErrorAssert(self.cm_childControllers != nil, @"cm_childControllers属性未赋值");
    CMPageErrorAssert(self.cm_childControllers.count != 0, @"cm_childControllers数组个数不能为空");
    
    NSArray *titles = [self.cm_childControllers valueForKey:@"title"];
    
    return _cm_titles ?: titles;
    
    
}


-(UIColor *)cm_seperaterLineColor {
    
    return _cm_seperaterLineColor ?: [UIColor grayColor];
}

- (NSArray *)cm_titleWidths {
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSString *string in self.cm_titles) {
        
        [mArray addObject:@(CMStringWidth(string, self.cm_font))];
        
    }
    
    return [mArray copy];
    
}

- (CGFloat)cm_titlesWidth {
    
    return [[self.cm_titleWidths valueForKeyPath:@"@sum.floatValue"] floatValue];
    
}

- (CGFloat)cm_minContentWidth {
    
    NSUInteger count = self.cm_contentMode == CMPageTitleContentMode_Center ? self.cm_titles.count + 1 : self.cm_titles.count;
    
    
    return  self.cm_titlesWidth + count * self.cm_minTitleMargin;
    
}


- (CGFloat)cm_titleMargin {
    
    
    if (self.cm_contentMode == CMPageTitleContentMode_Left) {
        //左对齐
        
        _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
        
    } else if (self.cm_contentMode == CMPageTitleContentMode_Right) {
        //右对齐
        
        _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
        
    }else if (self.cm_contentMode == CMPageTitleContentMode_Center || self.cm_contentMode == CMPageTitleContentMode_SpaceAround) {
        
        if (self.cm_titlesWidth  >= self.cm_pageTitleViewWidth.floatValue) {
            _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
            
        } else {
            
            NSUInteger count = self.cm_contentMode == CMPageTitleContentMode_Center ? self.cm_titles.count + 1 : self.cm_titles.count;
            
            CGFloat titleMargin = (self.cm_pageTitleViewWidth.floatValue - self.cm_titlesWidth )/count;
            
            _cm_titleMargin = titleMargin < self.cm_minTitleMargin ? self.cm_minTitleMargin : titleMargin;
            
        }
    }
    
    return _cm_titleMargin;
}



- (CGFloat)cm_animationDruction {
    
    return (_cm_animationDruction >= 0.25 && _cm_animationDruction <= 0.8) ? _cm_animationDruction : 0.25;
}




+ (instancetype)defaultConfig{
    
    
    return [[super alloc]initWithDefaultConfig];
    
}


- (instancetype)initWithDefaultConfig {
    
    
    if (self = [super init]) {
        
        self.cm_titleHeight = 44;
        
        self.cm_font = [UIFont systemFontOfSize:15];
        
        self.cm_backgroundColor = [UIColor whiteColor];
        
        self.cm_normalColor = [UIColor blackColor];
        
        self.cm_selectedColor = [UIColor redColor];
        
        _cm_defaultIndex = 0;
        
        self.cm_minTitleMargin = 20;
        
        self.cm_scale = 1.2;
        
        self.cm_animationDruction = 0.25;
        
        self.cm_contentMode = CMPageTitleContentMode_Center;
        
        self.cm_slideGestureEnable = YES;
        
        self.cm_underlineStretch = NO;
        
        self.cm_seperateLineHeight = 1.0 / [UIScreen mainScreen].scale;
        
        self.cm_seperaterLineColor = [UIColor lightGrayColor];
        
        self.cm_underlineColor = self.cm_selectedColor;
        
        self.cm_underlineWidthScale = 1;
        
        self.cm_underlineHeight = 2;
        
        self.cm_coverVerticalMargin = 5;
        
        self.cm_coverHorizontalMargin = 10;
        
        self.cm_splitterColor = [UIColor lightGrayColor];
        
        self.cm_splitterSize = CGSizeMake(1.0 / [UIScreen mainScreen].scale, 22);
        
        
    }
    return self;
    
}




CG_EXTERN NSArray* CMColorGetRGBA(UIColor *color) {
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
    
}

CG_EXTERN CGFloat CMColorGetR(UIColor *color) {
    
    return  [CMColorGetRGBA(color)[0] floatValue];
    
}

CG_EXTERN CGFloat CMColorGetG(UIColor *color) {
    
    return  [CMColorGetRGBA(color)[1] floatValue];
}

CG_EXTERN CGFloat CMColorGetB(UIColor *color) {
    
    return  [CMColorGetRGBA(color)[2] floatValue];
}

CG_EXTERN CGFloat CMColorGetA(UIColor *color) {
    
    return  [CMColorGetRGBA(color)[3] floatValue];
    
}

CG_EXTERN CGFloat CMStringWidth(NSString *string ,UIFont *font) {
    
    if ([string isKindOfClass:[NSNull class]] || string == nil || string.length == 0) {
        NSException *exception = [NSException exceptionWithName:@"CMStringWidth C Method Exception" reason:@"title的标题不能为空" userInfo:nil];
        [exception raise];
    }
    
    CGFloat width = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.width ;
    
    return ceilf(width);
}



@end
