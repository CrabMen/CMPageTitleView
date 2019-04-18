//
//  CMMacro.h
//  CMPageTitleView个z
//
//  Created by 智借iOS on 2018/8/13.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#ifndef CMMacro_h
#define CMMacro_h

//1px
#define CM_ONE_PX  1.0/[UIScreen mainScreen].scale

//是否是刘海屏
#define CM_NOTCH_SCREEN \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//导航栏高度
#define CM_NAVI_BAR_H (CM_NOTCH_SCREEN ? 88 : 64)

//电池条高度
#define CM_STATUE_BAR_H (CM_NOTCH_SCREEN ? 44 : 20)

//tabbar高度
#define CM_TAB_BAR_H (CM_NOTCH_SCREEN ? 83.0f: 49.0)

//selfWeak 防止block循环引用，参数为weak的对象
#define CMWEAK_OBJ(obj) @autoreleasepool{} __weak typeof(obj) obj##Weak = obj;
#define CMSTRONG_OBJ(obj) @autoreleasepool{} __strong typeof(obj) obj = obj##Weak;

//屏幕尺寸
#define CMSCREEN_W  [UIScreen mainScreen].bounds.size.width
#define CMSCREEN_H  [UIScreen mainScreen].bounds.size.height

//屏幕适配(UI图尺寸1334x750)
#define DYNAMIC_H(y) ((y/1334.f)*CMSCREEN_H) //动态获得高度
#define DYNAMIC_W(x) ((x/750.f)*CMSCREEN_W) //动态获得宽度

//字体适配(如果是plus字号根据宽度等比拉伸)
#define DYNAMIC_FONT(x) (CM_IPHONE_PLUS ? 1.5*x : x/2)

//16进制纯色
#define CM_HEXCOLOR(s) [UIColor cm_colorWithHexString:s]

//16进制颜色+alpha
#define CM_HEXCOLOR_ALPHA(s,a) [UIColor cm_colorWithHexString:s alpha:a]

#endif /* CMMacro_h */
