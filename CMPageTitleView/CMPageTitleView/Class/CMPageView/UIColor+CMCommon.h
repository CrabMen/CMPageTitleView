//
//  UIColor+Hex.h
//  Timeline_Demo
//
//  Created by CrabMan on 16/8/4.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(CMCommon)

+ (UIColor *)cm_colorWithHexString:(NSString *)colorString;

//从十六进制字符串获取颜色
/**
 *  color支持:
 *          @"#3F7813"  @"0X341141"、 @"312143"
 */
+ (UIColor *)cm_colorWithHexString:(NSString *)colorString alpha:(CGFloat)alpha;


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


@end
