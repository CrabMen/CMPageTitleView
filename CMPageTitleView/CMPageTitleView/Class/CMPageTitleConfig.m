//
//  CMPageTitlem
//  CMPageTitleView
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//

//  Created by CrabMan on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//


#import "CMPageTitleConfig.h"
#import "CMPageTitleViewMacro.h"
@interface CMPageTitleConfig ()

/**视图宽度*/
@property (nonatomic,strong) NSNumber *cm_pageTitleViewWidth;

@end

@implementation CMPageTitleConfig

#pragma mark -- setter

- (void)setCm_childControllers:(NSArray *)cm_childControllers {
    
    _cm_childControllers = cm_childControllers;
    
    self.cm_titles = [_cm_childControllers valueForKey:@"title"];
    
}

- (void)setCm_titles:(NSArray *)cm_titles {
    
    _cm_titles = cm_titles;
    
    if (_cm_titles.count) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSString *string in cm_titles) {
            [mArray addObject:@(CMStringWidth(string, self.cm_font))];
        }
        [self setValue:[mArray copy] forKey:NSStringFromSelector(@selector(cm_titleWidths))];
        
        NSNumber *cm_titlesWidth = [self.cm_titleWidths valueForKeyPath:@"@sum.floatValue"];
        
        [self setValue:cm_titlesWidth forKey:NSStringFromSelector(@selector(cm_titlesWidth))];
    }
    
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

- (void)setCm_animationDruction:(CGFloat)cm_animationDruction {
    
    _cm_animationDruction = (cm_animationDruction >= 0.25 && cm_animationDruction <= 0.8 ) ? cm_animationDruction : 0.25 ;

}

- (void)setCm_contentMode:(CMPageTitleContentMode)cm_contentMode {
    _cm_contentMode = cm_contentMode;
    NSUInteger count = self.cm_contentMode == CMPageTitleContentMode_Center ? self.cm_titles.count + 1 : self.cm_titles.count;
    [self setValue:@(self.cm_titlesWidth + count * self.cm_minTitleMargin) forKey:NSStringFromSelector(@selector(cm_minContentWidth))];
    
    _cm_contentMode = cm_contentMode;
    
    if (cm_contentMode == CMPageTitleContentMode_Left) {
        //左对齐
        
        _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
        
    } else if (cm_contentMode == CMPageTitleContentMode_Right) {
        //右对齐
        
        _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
        
    }else if (cm_contentMode == CMPageTitleContentMode_Center || cm_contentMode == CMPageTitleContentMode_SpaceAround) {
        
        if (self.cm_titlesWidth  >= self.cm_pageTitleViewWidth.floatValue) {
            _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
            
        } else {
            
            NSUInteger count = cm_contentMode == CMPageTitleContentMode_Center ? self.cm_titles.count + 1 : self.cm_titles.count;
            
            CGFloat titleMargin = (self.cm_pageTitleViewWidth.floatValue - self.cm_titlesWidth )/count;
            
            _cm_titleMargin = titleMargin < self.cm_minTitleMargin ? self.cm_minTitleMargin : titleMargin;
            
        }
    }
    
}

- (void)setCm_rightView:(UIView *)cm_rightView {
    _cm_rightView = cm_rightView;
    
    if (_cm_rightView.cm_height > self.cm_titleHeight) {
        _cm_rightView.cm_height = self.cm_titleHeight;
    }
    
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
