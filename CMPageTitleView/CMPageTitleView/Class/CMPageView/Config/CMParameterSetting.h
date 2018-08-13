//
//  CMDisplayControllerHeader.h
//  CMCustomeTitleBar
//
//  Created by CrabMan on 16/7/27.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#ifndef CMParameterSetting_h
#define CMParameterSetting_h


// 导航条高度
#define CMNavBarH  64

// 标题滚动视图的高度
#define CMTitleScrollViewH 44

// 标题缩放比例
#define CMTitleTransformScale 1.2

// 下划线默认高度
#define CMUnderLineH  2

#define CMScreenW [UIScreen mainScreen].bounds.size.width
#define CMScreenH [UIScreen mainScreen].bounds.size.height

// 默认标题字体
#define CMTitleFont [UIFont systemFontOfSize:14]

//默认标题未选中颜色
#define CMNormalColor [UIColor blackColor]

//默认标题选中颜色
#define CMSelectColor [UIColor redColor]

#define CMCoverCornerRadius 13

// 默认标题间距
#define titleLabelMargin  DYNAMIC_W(40)
#define displayReuseIdentifier @"cell"
// 标题被点击或者内容滚动完成，会发出这个通知，监听这个通知，可以做自己想要做的事情，比如加载数据
#define  CMDisplayViewClickOrScrollDidFinshNote  @"YZDisplayViewClickOrScrollDidFinshNote"

// 重复点击通知
#define  CMDisplayViewRepeatClickTitleNote  @"YZDisplayViewRepeatClickTitleNote"



#endif /* CMDisplayControllerHeader_h */
