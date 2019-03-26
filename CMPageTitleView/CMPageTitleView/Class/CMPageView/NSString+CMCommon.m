//
//  NSString+CMCommon.m
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/26.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "NSString+CMCommon.h"

@implementation NSString (CMCommon)
- (CGFloat)cm_widthWithFont:(UIFont *)font {
    if ([self isKindOfClass:[NSNull class]]) {
        NSException *exception = [NSException exceptionWithName:@"cm_sizeWithFont Method Exception" reason:@"title为空对象" userInfo:nil];
        [exception raise];
    }
    
    CGFloat width = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |  NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.width ;
    
    
    
    return ceilf(width);
    
    
}
@end
