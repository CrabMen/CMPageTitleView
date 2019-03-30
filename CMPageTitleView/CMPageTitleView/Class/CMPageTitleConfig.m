//
//  CMPageTitleConfig.m
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/25.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMPageTitleConfig.h"
@implementation CMPageTitleConfig

- (CGFloat)cm_titleHeight {
    
    return _cm_titleHeight ?: 44;
}

- (UIFont *)cm_font {
    
    return _cm_font ?: [UIFont systemFontOfSize:12];
    
}

- (UIColor *)cm_normalColor {
    
    return _cm_normalColor ?:[UIColor blackColor];
}

- (UIColor *)cm_selectedColor {
    
    return _cm_selectedColor ?: [UIColor redColor];
}

- (UIColor *)cm_underLineColor {
    
    return _cm_underLineColor ?: self.cm_selectedColor;
    
}

- (CGFloat)cm_underLineHeight {
    
    return _cm_underLineHeight ?: 2;
    
}

- (NSArray *)cm_titles {
    
    NSArray *titles = [self.cm_childControllers valueForKey:@"title"];
    
    return _cm_titles ?: titles;
    
}

- (CGFloat)cm_seperateLineHeight {
    
    return _cm_seperateLineHeight ?: CM_ONE_PX;
}

-(UIColor *)cm_seperaterLineColor {
    
    return _cm_seperaterLineColor ?: [UIColor grayColor];
}

- (NSArray *)cm_titleWidths {
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSString *string in self.cm_titles) {
        
        [mArray addObject:@([string cm_widthWithFont:self.cm_font])];
        
    }
    
    return [mArray copy];
    
}

- (CGFloat)cm_totalWidth {
   
    return [[self.cm_titleWidths valueForKeyPath:@"@sum.floatValue"] floatValue];

}

- (CGFloat)cm_titleMargin {
    
    if (self.cm_totalWidth  >= CMSCREEN_W) {
        _cm_titleMargin = _cm_titleMargin ?: 20;
        
    } else {
        
        CGFloat titleMargin = (CMSCREEN_W - self.cm_totalWidth)/(self.cm_titles.count + 1);
        
        _cm_titleMargin = titleMargin < 20 ? 20 : titleMargin;
        
    }
    
    return _cm_titleMargin;
}

- (NSInteger)cm_defaultIndex {
    
    return _cm_defaultIndex < self.cm_titles.count ? _cm_defaultIndex : 0;
}

- (CGFloat)cm_scale {
    
    return _cm_scale ?: 1.2;
}


@end
