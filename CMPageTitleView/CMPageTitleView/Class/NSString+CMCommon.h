//
//  NSString+CMCommon.h
//  CMPageTitleView
//
//  Created by 智借iOS on 2019/3/26.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CMCommon)

/**
 获得某font字符串的宽度

 @param font 字符串的font
 @return 当前字符串的宽度
 */
- (CGFloat)cm_widthWithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
