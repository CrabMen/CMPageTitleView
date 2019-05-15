![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/logo.png)

![](https://img.shields.io/cocoapods/v/CMPageTitleView.svg)
![](https://img.shields.io/cocoapods/p/CMPageTitleView.svg)
![](https://img.shields.io/apm/l/vim-mode.svg)

* [效果展示](#screenshots)
* [安装](#installation)
* [示例](#example)
* [版本记录](#version)
* [支持](#support)
* [许可](#license)


## <a id="screenshots"></a>效果展示

| 效果说明     |    GIF|
| :-------- | --------:| 
| 字体放大 - RGB颜色渐变  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_00.gif) | 
| 字体放大 - 填充色渐变  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_01.gif) | 
| 下划线 - RGB颜色渐变 - 跟随文字宽度| ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_02.gif) | 
| 下划线 - 填充渐变 - 跟随文字宽度| ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_03.gif) | 
| 下划线 - RGB渐变 - 固定宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_04.gif) | 
| 下划线 - 填充渐变 - 固定宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_05.gif) | 
| 下划线 - RGB渐变 - 跟随文字宽度 - 拉伸效果| ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_06.gif) | 
| 下划线 - 填充色渐变 - 跟随文字宽度 - 拉伸效果  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_07.gif) | 
| 下划线 - RGB渐变 - 固定宽度 - 拉伸效果  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_08.gif) | 
| 下划线 - 填充色渐变 - 固定宽度 - 拉伸效果  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_09.gif) | 
| 遮罩 - RGB渐变 - 跟随文字宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_10.gif) | 
| 遮罩 - 填充色渐变 - 跟随文字宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_11.gif) | 
| 遮罩 - RGB渐变 - 固定宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_12.gif) | 
| 遮罩 - 填充色渐变 - 固定宽度 | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_13.gif) | 
| 混合样式 - 字体放大/下划线 - RGB渐变  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_14.gif) | 
| 混合样式 - 字体放大/下划线 - 填充色渐变  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_15.gif) | 
| 下划线 - 比例文字宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_16.gif) | 
| 下划线 - 比例文字宽度 - 拉伸效果  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_17.gif) | 


## <a id="installation"></a>安装 

### CocoaPods安装:

* For iOS8+: 

```ruby
use_frameworks!
target '<Your Target Name>' do
    pod 'CMPageTitleView'
end
```

### 手动安装:
* 将 `CMPageTitleView/CMPageTitleView/Class` 路径下的所有文件拖拽到你的项目中. 


## <a id="example"></a>示例

首先, 先要导入.h头文件.

**如果cocoaposd安装:**
```
#import <CMPageTitleView/CMPageTitleView.h>
```
**如果手动安装:**

```
#import "CMPageTitleView.h"

```

创建CMPageTitleView 后，创建CMPageTitleConfig 对象并设置所需配置：

```
 CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:frame];
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Underline;
    config.cm_gradientStyle = CMTitleColorGradientStyle_Fill;
    config.cm_underlineStretch = YES;
    config.cm_underlineWidth = 10;
    pageView.cm_config = config;
    
    [self.view addSubview:pageView];
```

同样支持Masonry布局，代码如下：

```
 CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];

    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    
    pageView.delegate = self;
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_gradientStyle = CMTitleColorGradientStyle_RGB;
    config.cm_selectedFont = [UIFont systemFontOfSize:18];
    config.cm_contentMode = CMPageTitleContentMode_Center;
    pageView.cm_config = config;

```

 按照上方代码，即可完成配置🎉
## <a id="version"></a> 版本
**0.3.0之前的版本不够稳定，建议使用0.3.0 及其以后的版本**
* 2018-08-13 初始化项目 
* 2018-04-26 版本 0.3.0 新增 下划线比例宽度跟随标题文字宽度
* 2018-05-03 版本 0.3.1 cm_scale可以继续使用，新增cm_selectedFont属性，便于设置选中字体大小；支持**Masonry**
* 2018-05-09 版本 0.4.0 新增设置标题分割线Size以及Color功能；新增对外暴露的代理方法，便于用户做对应处理；新增断言异常提示；新增设置是否允许侧滑功能



## <a id="support"></a>支持
* 如果觉得该三方库还不错，可以[**★Star**]#支持一下你的[**★Star**]#就是我最大的动力
* 如果发现bug或想有其他的新功能，可以 **[issue](https://github.com/CrabMen/CMPageTitleView/issues)** 我

## <a id="license"></a>许可
CMPageTitleView 基于MIT许可

