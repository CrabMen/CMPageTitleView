![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/logo.png)

![](https://img.shields.io/cocoapods/v/CMPageTitleView.svg)
![](https://img.shields.io/cocoapods/p/CMPageTitleView.svg)
![](https://img.shields.io/apm/l/vim-mode.svg)

# Table of contents
* [Screenshots](#screenshots)
* [Installation](#installation)
* [Example](#example)
* [Version History](#version)
* [Support](#support)
* [License](#license)


## <a id="screenshots"></a>Screenshots 

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
| 混合样式 - 字体放大/下划线 - 填充色渐变  | ![](https://github.com/CrabMen /CMResources/blob/master/CMPageTitleView/CMPageTitleView_15.gif) | 
| 下划线 - 比例文字宽度  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_16.gif) | 
| 下划线 - 比例文字宽度 - 拉伸效果  | ![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/CMPageTitleView_17.gif) | 


## <a id="installation"></a>Installation 

### CocoaPods:

* For iOS8+: 

```ruby
use_frameworks!
target '<Your Target Name>' do
    pod 'CMPageTitleView'
end
```

### Manually:
* Drag all files under `CMPageTitleView/CMPageTitleView/Class` folder into your project. 


## <a id="example"></a>Example 

Firstly, you need import the .h file.

**if cocoaposd:**
```
#import <CMPageTitleView/CMPageTitleView.h>
```
**if manually:**

```
#import "CMPageTitleView.h"

```

Then create CMPageTitleView and use the CMPageTitleConfig class to configure .

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

Congratulations! You're done. 🎉
## <a id="version"></a> Version History
**0.3.0之前的版本不够稳定，建议使用0.3.0 及其以后的版本 **
* 2018-08-13 初始化项目 
* 2018-04-26 版本 0.3.0 新增 下划线比例宽度跟随标题文字宽度
* 2018-05-03 版本 0.3.1 cm_scale可以继续使用，新增cm_selectedFont属性，便于设置选中字体大小；支持**Masonry**
* 2018-05-09 版本 0.4.0 新增设置标题分割线Size以及Color功能；新增对外暴露的代理方法，便于用户做对应处理；新增断言异常提示；新增设置是否允许侧滑功能



## <a id="support"></a>Support this repo
* [**★Star**](#) this repo 
* If you find somes bugs or need some new functions,please **[issue](https://github.com/CrabMen/CMPageTitleView/issues)** me

## <a id="license"></a>License
CMPageTitleView is available under the MIT license. See the LICENSE file for more info.

