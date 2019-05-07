//
//  CMPageTitlem
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMPageTitleConfig.h"

@interface CMPageTitleConfig ()

/**视图宽度*/
@property (nonatomic,assign) CGFloat cm_width;


@end



@implementation CMPageTitleConfig

#pragma mark -- setter

- (void)setCm_selectedFont:(UIFont *)cm_selectedFont {
    
    _cm_selectedFont = cm_selectedFont;
    
    self.cm_scale = self.cm_font.pointSize ? cm_selectedFont.pointSize / self.cm_font.pointSize : self.cm_scale;
    
    
}

- (void)setCm_contentMode:(CMPageTitleContentMode)cm_contentMode {
    
    
    _cm_contentMode = cm_contentMode;
    
    if (self.cm_minContentWidth > [UIScreen mainScreen].bounds.size.width) {
        _cm_contentMode = CMPageTitleJustifyContentMode_Center;
    }
    
    
}


#pragma mark -- getter

- (CGFloat)cm_titleHeight {
    
    return _cm_titleHeight ?: 44;
}

- (UIFont *)cm_font {
    
    return _cm_font ?[UIFont systemFontOfSize:_cm_font.pointSize]: [UIFont systemFontOfSize:15];
    
}


- (UIColor *)cm_normalColor {
    
    return _cm_normalColor ?:[UIColor blackColor];
}

- (UIColor *)cm_selectedColor {
    
    return _cm_selectedColor ?: [UIColor redColor];
}

- (UIColor *)cm_underlineColor {
    
    return _cm_underlineColor ?: self.cm_selectedColor;
    
}

- (CGFloat)cm_underlineWidthScale {
    
    
    return fabs(_cm_underlineWidthScale) > 1.3 || _cm_underlineWidthScale == 0 ? 1 :fabs(_cm_underlineWidthScale) ;
    
}

- (CGFloat)cm_underlineHeight {
    
    return _cm_underlineHeight ?: 2;
    
}


- (CGFloat)cm_coverVerticalMargin {
    
    return _cm_coverVerticalMargin ?: 5;
    
}

- (CGFloat)cm_coverHorizontalMargin {
    
    return _cm_coverHorizontalMargin ?: 10;
    
}

- (NSArray *)cm_titles {
    
    NSArray *titles = [self.cm_childControllers valueForKey:@"title"];
    
    return _cm_titles ?: titles;
    
    
}

- (CGFloat)cm_seperateLineHeight {
    
    return _cm_seperateLineHeight ?: 1.0/[UIScreen mainScreen].scale;
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
    
    return self.cm_horiziontalInsets.left + self.cm_horiziontalInsets.right + self.cm_titlesWidth + (self.cm_titles.count + 1) * self.cm_minTitleMargin;
    
}


- (CGFloat)cm_titleMargin {
    
    
    if (self.cm_contentMode == CMPageTitleContentMode_Left) {
        //左对齐
        
        
        
    } else if (self.cm_contentMode == CMPageTitleJustifyContentMode_Right) {
        //右对齐
        
        
        
    }else if (self.cm_contentMode == CMPageTitleJustifyContentMode_Center) {
        
        
        
    }
    
    
    if (self.cm_titlesWidth  >= [UIScreen mainScreen].bounds.size.width) {
        _cm_titleMargin = _cm_titleMargin ?: self.cm_minTitleMargin;
        
    } else {
        
        CGFloat titleMargin = ([UIScreen mainScreen].bounds.size.width - self.cm_titlesWidth)/(self.cm_titles.count + 1);
        
        _cm_titleMargin = titleMargin < self.cm_minTitleMargin ? self.cm_minTitleMargin : titleMargin;
        
    }
    
    return _cm_titleMargin;
}


- (CGFloat)cm_minTitleMargin {
    
    
    return _cm_minTitleMargin ?: 20;
    
}

- (NSInteger)cm_defaultIndex {
    
    return _cm_defaultIndex < self.cm_titles.count ? _cm_defaultIndex : 0;
}

- (CGFloat)cm_scale {
    
    return _cm_scale ?: 1.05;
}


- (CGSize)cm_splitterSize {
    
    return CGSizeEqualToSize(_cm_splitterSize,CGSizeZero) ? CGSizeMake(1/[UIScreen mainScreen].scale, self.cm_titleHeight*0.5):_cm_splitterSize;
    
}

- (UIColor *)cm_splitterColor {
    
    return _cm_splitterColor ?: [UIColor lightGrayColor];
    
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
    
    if ([string isKindOfClass:[NSNull class]]) {
        NSException *exception = [NSException exceptionWithName:@"CMStringWidth C Method Exception" reason:@"title为空对象" userInfo:nil];
        [exception raise];
    }
    
    CGFloat width = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.width ;
    
    return ceilf(width);
}


CG_EXTERN CMEdgeHoriziontalInsets CMEdgeHoriziontalInsetsMake(CGFloat left,CGFloat right) {
    
    CMEdgeHoriziontalInsets insert = {left,right};
    
    return insert;
}



@end
